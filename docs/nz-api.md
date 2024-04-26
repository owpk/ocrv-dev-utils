## Nz document validation api

# Path:
> /nz/doc

# Method:
> PUT

# Request body:
```json
{
  "nzId": 1,
  "docId": 1,
  "year": 2022,
  "orgehId": 0,
  "nzStatus": "IN_WORK",
  "hasError": false,
  "note": "false",
  "fromDay": "2022-01-01T00:00:00",
  "toDay": "2022-01-01T00:00:00",
  "people": "SINGLE",
  "period": "SHIFT",
  "nvPlan": 2,
  "nvFact": 3,
  "osnr": 200,
  "completionPercent": 50,
  "inTime": true,
  "issuedBy": "Pepkin",
  "dateUpdated": "2022-01-01",
  "tplan": 5,
  "tfact": 6,
  "temperatureZone": "C",
  "nvPlanTime": 2,
  "nvFactTime": 3,
  "works": [], 
  "peoples": [],
  "tplanTime": 5,
  "tfactTime": 6
}
```

# Api response:

> Status 200: 
```json
{
    "isValid": false,
    "validationErrorEntries": [{   
        "category" : "example", 
        "errors": [{
            "fieldName": "name",
            "msg" : "errorMessage"
        }]
    }]
}
```
