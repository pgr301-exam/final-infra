# PGR301
### For å opprette pipeline gjør følgende

 - lag fork av app og infra repo
[infra](https://github.com/pgr301-exam/final-infra)
[app](https://github.com/pgr301-exam/final-app)
 - Endr **pipeline.yml**, og sett inn egne repositories under "source"
 - Lag egne deploy keys for begge git repo
- Døp om filen **credentials_example.yml** til **credentials.yml** og legg inn egne hemmeligheter
- Endre terraform/variables.tf
- Endre **username** i terraform/statuscake.tf
- Endre provider **email** i terraform/provider_heroku.tf
- Sett miljøvariabler for, **GITHUB_TOKEN** (Personal access token) og **HEROKU_API_KEY**
- Start docker-compose
- I infra kjør ```fly -t (min target) set-pipeline -c "infra repo"/concourse/pipeline.yml -l "infra repo"/credentials.yml -p student_name```
- trigger funksjon er ikke implementert siden jeg ikke fikk ønsket resultat
![pipeline](https://github.com/pgr301-exam/final-infra/blob/master/pipeline.png)
![heroku](https://github.com/pgr301-exam/final-infra/blob/master/heroku.png)
![
statuscake](https://github.com/pgr301-exam/final-infra/blob/master/statuscake.png)
![
statuscake](https://github.com/pgr301-exam/final-infra/blob/master/stauscake.png)

## Oppgaver løst
Jeg valgte å løse oppgavene [Overvåking, varsling og metrics](https://github.com/PGR301-2018/oppgave-eksamen#overv%C3%A5kning-varsling-og-metrics-20-poeng) og [Applikasjonslogger](https://github.com/PGR301-2018/oppgave-eksamen#applikasjonslogger-10-poeng).

### Overvåking, varsling og metrics

- For at **infra** jobben skal kunne kjøres må instruksjonene i linken over følges. Det er først etter dette **deploy-app** jobben kan kjøres.
- Det er mulig at miljøvariablene for **GRAPHITE_HOST** og **HOSTEDGRAPHITE_APIKEY** også må settes. 
- Pipeline setter ikke heroku config vars så jeg har løst dette ved å sende dem via concourse/java/task.sh
- Jeg måtte bruke GraphiteMetricsConfig klassen på litt annen måte siden jeg ikke fikk @Autowired annotasjon til å fungere riktig. 
![hosted graphite](https://github.com/pgr301-exam/final-infra/blob/master/hosted_graphite.png)

### Applikasjonslogger

 - For at docker-compose kan kunne kjøres må grensen for nnmap økes, Linux systemer kan kjøre `sysctl -w vm.max_map_count=262144` som root. For andre systemer må dokumentasjon følges [docker elk](https://elk-docker.readthedocs.io/#prerequisites)
 - Kjør `docker-compose up`  i elk/docker-compose.yml for å få tilgang til
**ElasticSearch** ([http://localhost:9200](http://localhost:9200/))
**Kibana** ([http://localhost:5601](http://localhost:5601/))

![kibana](https://github.com/pgr301-exam/final-infra/blob/master/kibana.png)
![elasticsearch](https://github.com/pgr301-exam/final-infra/blob/master/elasticsearch.png)
