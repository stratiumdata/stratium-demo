# Stratium Demo

## Clone Repository

```bash
git clone https://github.com/stratiumdata/stratium-demo.git
```

## Quickstart

```bash
make quickstart
```

## Make Keycloak Accessible

```bash
docker exec stratium-keycloak /opt/keycloak/bin/kcadm.sh update realms/master -s sslRequired=NONE --server http://localhost:8080 --realm master --user admin --password admin
```

## Client Tutorial

Golang CLI Client --> [Stratium Documentation](https://www.stratium.dev/docs)