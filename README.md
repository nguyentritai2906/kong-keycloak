### Add service
```
curl -s -X POST http://localhost:8001/services \
-d name=mock-service \
-d url=http://mockbin.org/request | jq
```

### Add route
```
service_id=$(curl -s http://localhost:8001/services/mock-service | jq -r .id)
curl -s -X POST http://localhost:8001/routes \
-d service.id=${service_id} \
-d paths=/mock | jq
```

### Try out without authentication
```
curl -s http://localhost:8000/mock
```

### Test OIDC
```
curl -s http://localhost:8180/realms/master/.well-known/openid-configuration | jq
```

### Configure the OIDC plugin on Kong
```
HOST_IP=$(ipconfig getifaddr en0)
CLIENT_SECRET=<client_secret_from_keycloak>
```

### Test the OIDC functionality with Kong as a client of Keycloak
```
curl -s -X POST http://localhost:8001/plugins \
-d name=oidc \
-d config.client_id=kong \
-d config.client_secret=${CLIENT_SECRET} \
-d config.discovery=http://${HOST_IP}:8180/realms/master/.well-known/openid-configuration \
| python -mjson.tool
```
