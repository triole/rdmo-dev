# RDMO Docker Dev Containers

## Default Dev API Key
Run `/opt/pg_add-api-key.sh` to generate the default api key for the admin user. The key string is can be configured `variables.env`.

On the local machine from outside the dockers you can do something like this.
```shell
curl -LH \
    "Authorization: 58114e78e6c3488247148a3e5c9e6fa462a9e4c9" \
    "http://localhost:8280/api/v1/projects"
```

Inside the rdmo container there is a `/opt/api.sh` that does send requests to the api.
```shell
/opt/api.sh "api/v1/projects"
```
