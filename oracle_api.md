## Call application

POST /api/v1/call/application Content-Type: application/json; charset=utf-8

### JSON body

| Param              | Type                         | 是否必传  | Desc |
|--------------------|------------------------------|-------|------|
| RequestApplication | String                       | True  | desc |
| RequestAction      | String                       | True  | -    |
| Data               | Base64(byte[])               | False | -    |
| QueryString        | String                       | False | -    |
| Packed             | Bool                         | False | -    |
| PackedCount        | Int                          | False | -    |
| Seal               | Object([Seal](#Seal Object)) | --    | -    |

### Seal Object

| Param           | Type           | 是否必传  | Desc |
|-----------------|----------------|-------|------|
| Hash            | Base64(byte[]) | True  | -    |
| Signature       | Base64(byte[]) | False | -    |
| SignerPublicKey | Base64(byte[]) | False | -    |
| SignerAlgorithm | Base64(byte[]) | False | -    |

### request

```http request
POST api/v1/call/application
Content-Type: *; charset=utf-8

{
    "RequestApplication":"Oracle",
    "Data":"MDAxMjM=",
    "Seal":{
        "Hash":"MDAxMjQ="
    }
}
```

### response

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

null
```

## Query Oracle application

POST /api/v1/query/application/Oracle Content-Type: *; charset=utf-8

### JSON body

| Param         | Type                                              | 是否必传 | Desc |
|---------------|---------------------------------------------------|------|------|
| RequestAction | String                                            | True | -    |
| Seal          | Object([Seal](#Seal Object))Only hash is required | True | -    |
| RequestAction | String                                            | True | -    |

### response

```http request
POST /api/v1/query/application/Oracle
Content-Type: *; charset=utf-8

{
    "Seal":{
        "Hash":"MDAxMjQ="
    },
    "RequestAction":"GoGo"
}
```

### response

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
    "status": 2, //as: 2 |3 |4  
    "statusMSG": "Saved", //as: Saved |Saving |Notfound
    "data": {
        "hash": "3030313234",
        "height": "0",
        "payload": {
            "Data": "MDAxMjM=",
            "QueryString": "",
            "RequestAction": "",
            "RequestApplication": "Oracle"
        },
        "time": "2021-12-31 10:54:54"
    }
}
```
