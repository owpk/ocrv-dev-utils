# Path: /nz/save
# Method: POST
# Cache: ?
# Roles: ?
# Body:
> Актуальное тело запроса эквиваленто структуре ответа из api: 6.1.3.6.3 API по чтению документа
```json
{
  "id": 0,
  "orgeh": 0,
  "year": 0,
  "ndocum": 0,
  "dept":0,
  "deptName": "string",
  "tempZone": "string",
  "hasError": true,
  "addInfo": "string",
  "fromDay": "2024-05-29T07:48:07.446Z",
  "toDay": "2024-05-29T07:48:07.446Z",
  "nzStatus": "IN_WORK",
  "nzPeople": "SINGLE",
  "nzTime": "SHIFT",
  "timely":true,
  "timeRecord": flase,
  "nvPlan": 0,
  "nvFakt": 0,
  "nvBase": 0,
  "tplan": 0,
  "tfakt": 0,
  "nvPlanRank": 0,
  "nvFaktRank": 0,
  "nvFaktRankTkf": 0,
  "tfaktRank": 0,
  "tfaktRankTkf": 0,
  "lastModified":"2024-02-28T03:36:36.877+00:00"
  "lastModifiedBy":"string",
  "peopleInfoList": [
    {
      "persNum": 0,
      "lastName": "string",
      "firstName": "string",
      "middleName": "string",
      "isManager": true,
      "plans": 0,
      "plansName": "string",
      "positionRank": 0,
      "tPlan": 0,
      "tPlanQuote": 0,
      "tFakt": 0,
      "tFaktQuote": 0,
      "quote":0,  
      "planTimeSheetList": [
          {
            "day": 0,
            "date": "2024-05-29",
            "userInputHour": 0,
            "workBeginTime": "22:38:40",
            "controlHour": 0,
            "controlBeginTimeList": [
              {
                "beguz": "07:48:07",
                "enduz": "17:48:07"
              }
            ],
            "stypeDayList": [
              "WORK"
            ]
          }
        ],
    "faktTimeSheetList": [
          {
            "day": 0,
            "date": "2024-05-29",
            "userInputHour": 0,
            "workBeginTime": "22:38:40",
            "controlHour": 0,
            "controlBeginTimeList": [
              {
                "beguz": "07:48:07",
                "enduz": "17:48:07"
              }
            ],
            "stypeDayList": [
              "WORK"
            ]
          }
        ],
    "absenceList": [
        {
          "absence": "string",
          "begDate": "2024-05-29",
          "endDate": "2024-05-29",
          "begTime": "22:38:40", 
          "hour": 0, 
          "absenceName": "string"
        }
      ],
    "workPlaceList": [
        {
          "begDate": "2024-05-29", 
          "endDate": "2024-05-29",
          "peopleGroup": "Списочный состав",
          "category": "1",
          "dept": 0, 
          "deptName": 0,
          "plans": 0, 
          "plansName": 0, 
          "positionId": 0,
          "positionName": 0,
          "positionCode": "string",
          "positionRank": 0,
          "tariffKoeff": 0,
          "tariffStavka": 0,
          "schedule": "string",
          "weekHours": 0,
          "country": "string",
          "regionId": "string", regionCode
          "regionName": "string"
        }
      ]
    }
  ],
  "workList": [
    {
      "rowId": 0,
      "normId": 0,
      "normClass": "INDIVIDUAL",
      "normType": "TYPICAL",
      "workName": "string",
      "refElementName": "string",
      "normCode": "string",
      "atrSize": 0,
      "measureCode": "string",
      "measureCodeName": "string",
      "addInfo": "string",
      "timeNorm": 0,
      "workRank": 0,
      "tariffKoef": 0,
      "timeKoef": 0,
      "winterKoef": 0,
      "timeNormWithKoef": 0,
      "section": "string",    
      "repairObject": "string",
      "sborShortName": "string",
      "vfakt": 0,
      "vplan": 0,
      "nvPlan": 0,
      "nvFakt": 0,
      "nvFaktRecord": 0,
      "dayFrom": 0,
      "dayTo": 0,
      "timeFrom": "22:38:40",
      "timeTo": "22:38:40",    
      "koefList": [
        {
          "id": 0,
          "description": "string",
          "timeKoef": 1.25,
          "koefGroup": {
            "id": 0,
            "shortName": "string",
            "name": "string"
          }
        }
      ], 
      "completitionErrorList": [
        {
          "completeId": 0,         
          "shortName": "string",
          "needAddInfo": true,
          "vFakt": 0,
          "addInfo": "string"
        }
      ],
    }
  ], 
}
```

# Response:
- Status: 200
```
тело запроса эквиваленто структуре ответа из api: 6.1.3.6.3 API по чтению документа
```

- Status: 422 
> в случае неудачного сохранения в бд
> при валидации входных данных от пользователя
```json
{
    message:””, 
    messageType:”ERROR”, 
    timestamp: “29-07-2024 12:12:12” 
}
```

## Description
https://docs.google.com/spreadsheets/d/1Oz1PoBMeyOFuON9u5WNjx5sWM77uUukq-dYyYpqxBhs/edit?usp=sharing
