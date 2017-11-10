# mkt
Mean kinetic temperature aggregate function for postgres

**_input temp and output in celsius_**

### installation
[Linux]
1. open your terminal an type
```
  psql -h localhost -U postgres < MKT_function.sql
```

### Usage example

```
CREATE TABLE data(temp numeric);
INSERT INTO data VALUES (2), (2), (5), (8),(8),(8),(8);

select mkt(temp) from data;

```
###### Result
```
mkt  
------
 6.25
```

### External links
Wikipedia [Temperatura cinética media](https://es.wikipedia.org/wiki/Temperatura_cin%C3%A9tica_media)
