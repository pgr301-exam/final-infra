# Create Heroku apps for staging and production
resource "heroku_app" "ci" {
  name   = "${var.app_prefix}-app-ci"
  region = "eu"

  config_vars = {
    HOSTEDGRAPHITE_APIKEY = "${var.hosted_graphite_apikey}"
    GRAPHITE_HOST = "${var.hosted_graphite_host}"
    LOGZ_IO_TOKEN = "${var.logz_io_token}"
  }
}
resource "heroku_addon" "hostedgraphite_ci" {
  app  = "${heroku_app.ci.name}"
  plan = "hostedgraphite"
}
###################################################
resource "heroku_app" "staging" {
  name   = "${var.app_prefix}-app-staging"
  region = "eu"

  config_vars = {
    HOSTEDGRAPHITE_APIKEY = "${var.hosted_graphite_apikey}"
    GRAPHITE_HOST = "${var.hosted_graphite_host}"
    LOGZ_IO_TOKEN = "${var.logz_io_token}"
  }
}
resource "heroku_addon" "hostedgraphite_staging" {
  app  = "${heroku_app.staging.name}"
  plan = "hostedgraphite"
}
###################################################
resource "heroku_app" "production" {
  name   = "${var.app_prefix}-app-production"
  region = "eu"

  config_vars = {
    HOSTEDGRAPHITE_APIKEY = "${var.hosted_graphite_apikey}"
    GRAPHITE_HOST = "${var.hosted_graphite_host}"
    LOGZ_IO_TOKEN = "${var.logz_io_token}"
  }
}
resource "heroku_addon" "hostedgraphite_prod" {
  app  = "${heroku_app.production.name}"
  plan = "hostedgraphite"
}
###################################################
resource "heroku_pipeline" "test-app" {
  name = "${var.pipeline_name}"
}

# Couple apps to different pipeline stages
resource "heroku_pipeline_coupling" "ci" {
  app      = "${heroku_app.ci.name}"
  pipeline = "${heroku_pipeline.test-app.id}"
  stage    = "development"
}

# Couple apps to different pipeline stages
resource "heroku_pipeline_coupling" "staging" {
  app      = "${heroku_app.staging.name}"
  pipeline = "${heroku_pipeline.test-app.id}"
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "production" {
  app      = "${heroku_app.production.name}"
  pipeline = "${heroku_pipeline.test-app.id}"
  stage    = "production"
}
