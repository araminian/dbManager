# Documentation

The *dbManager* is a CLI tool which can be used to manage remote or local **MySQL** or **MariaDB**.

I need a tool to help to manage databases in *CI/CD* pipelines, so I start *dbManager*.


# How to use

## Requirements

 1. *Mariadb* or *MySQL* clients
 2. *dbManager* needs 3 environment variables:
     - `DB_HOST`: The address or hostname of database, *Example*: `DB_HOST=db.production`
     - `DB_USER`: The user which have access database
     - `DB_PASSWORD`: The password of user
  
## Commands

### create

*Syntax*: 
```bash
dbManager create <DatabaseName>
```   
*create* will be used to create a database

**_NOTE:_**  If desired database exists, It returns ***exit code 1***

*Example*:
```bash
# Create database druapl if it doesn't exist
dbManager create drupal
```

### drop

*Syntax*: 
```bash
dbManager drop <DatabaseName>
```   
*drop* will drop the database

**_NOTE:_**  *Exit codes*:  Database exist ***exit code 0*** , Database does not exist ***exit code 1***

*Example*:
```bash
# Create database druapl if it exists
dbManager drop drupal
```

### exist

*Syntax*: 
```bash
dbManager exist <DatabaseName>
```   
*exist* check if the database exists

**_NOTE:_**  If desired database doesn't exist, It returns ***exit code 0*** and ***exit code 1*** 

*Example*:
```bash
# check if database drupal exists
dbManager exist drupal
```

### user

#### create
*Syntax*: 
```bash
dbManager user create <User> <Password>
```   
*user create* will be used to create user

**_NOTE:_**  The user can access database host both **remotely and locally**


**_NOTE:_**  The user doesn't permission to access anything in database host

*Example*:
```bash
# Create user armin with password ThisIsASecret
dbManager user create armin ThisIsASecret
```

#### delete

*Syntax*: 
```bash
dbManager user delete <User>
```   
*user create* will be used to delete user

**_NOTE:_**   If desired user doesn't exists, It returns ***exit code 1***


**_NOTE:_**  The delete user does not revoke user permissions

*Example*:
```bash
# delete user armin
dbManager user delete armin
```

### access

#### grant

*Syntax*: 
```bash
dbManager access grant <User> <Database>
```   
*access grant* give user full access to a database

**_NOTE:_**  If user or database don't exist, It returns ***exit code 1***

*Example*:
```bash
# give user armin full access of database drupal
dbManager access grant armin drupal
```

#### revoke

*Syntax*: 
```bash
dbManager access revoke <User>
```   
*access grant* revoke all access of user

**_NOTE:_**  If user doen't exist, It returns ***exit code 1***

*Example*:
```bash
# revoke all accesses of user armin
dbManager access revoke armin
```

### sync

*Syntax*: 
```bash
dbManager sync <SourceDB> <DestinationDB>
```   
*sync* sync destination database with source database

**_NOTE:_**  If source database doen't exist, It returns ***exit code 1***


**_NOTE:_**  If ddestination database doen't exist, It will ***be created***

*Example*:
```bash
# sync drupal-test database with drupal database
dbManager sync drupal drupal-test
```

### restore

*Syntax*: 
```bash
dbManager restore <Database> <Dumpfile>
```   
*restore* Restore database from a dumpfile

**_NOTE:_**  If dumpfile doen't exist, It returns ***exit code 1***


**_NOTE:_**  If database doen't exist, It will ***be created***

*Example*:
```bash
# restore database drupal from file stage.sql
dbManager restore drupal stage.sql
```

### view

#### databases

*Syntax*: 
```bash
dbManager view databases
```   
*view databases* view list of all databases on the database host

*Example*:
```bash
# list all databases
dbManager view databases
```


#### users

*Syntax*: 
```bash
dbManager view users
```   
*view users* view list of all users on the database host

*Example*:
```bash
# list all users
dbManager view users
```

#### tables

*Syntax*: 
```bash
dbManager view tables <Database>
```   
*tables* view all tables in a desired database

**_NOTE:_**  If database doen't exist, It returns ***exit code 1***

*Example*:
```bash
# list all tables in drupal database
dbManager view tables drupal
```

## How to use dbManager

 ###  Use docker image `heiran/dbmanager`
  
  The image is based on `bitnami/minideb` and will be run via `dbmanager` user with `id 1001` .
  
 To build image we use `Earthly` which you can have look `Earthfile` for more infromation.
  
 *Example*:
 ```bash
docker run -it --rm --name dbmanager --env DB_HOST=db.production --env DB_USER=armin --env DB_PASSWORD=ThisIsASecret heiran/dbmanager dbManager create test
```
```bash
# Kubernetes
kubectl run dbmanager -it --rm --image=heiran/dbmanager --env DB_HOST=<DB> --env DB_USER=<USER> --env DB_PASSWORD=<PASSWORD> -- dbManager view databases

```
### Non-container

 1. Clone the repository
 2. Create `dbManager` directory `/var/dbManager`
 3. Copy all files in `CLI` directory to `/var/dbManager` and make them executable
 ```bash
 chmod +x -R /var/dbManager
 ```
 4.  Move `/var/dbManager/dbManager` file to a folder in your path
 ```bash
 install -o root -g root -m 0755 /var/dbManager/dbManager /usr/local/bin/dbManager
 ```

## TODO

 - [x] Add K8s Job template
 - [ ] ...
