# oracle startup

## USE

> [golang Demo](https://github.com/SealSC/SealABCDemo/blob/main/oracle_main.go)

### Step1. New an OracleApplication

```go
//service/application/oracle/oracleInterface/oracleInterface.go:103
oracleApplication := oracleInterface.NewOracleApplication(time.Second*30, sqlDriver, driver)
```

| params           | type                      | desc                                                                                |
|------------------|---------------------------|-------------------------------------------------------------------------------------|
| pullTimeOut      | time.Duration             | Timeout for Oracle to obtain data from remote                                       |
| blockchainDriver | simpleSQLDatabase.IDriver | It is used to query the data saved by the Oracle                                    |
| kvDB             | kvDatabase.IDriver        | It is used to query the progress of Oracle saving data (saving , not found , saved) |

### Step2. Register ActionFunc

```go
type a3 struct{}

func (a a3) VerifyReq(blockchainRequest.Entity) error                       { return nil }
func (a a3) Name() string                                                   { return "120" }
func (a a3) FormatResult(req blockchainRequest.Entity) (interface{}, error) { return req.Data, nil }
func (a a3) CronPaths() []string                                            { return []string{"0 0/1 * * * *"} }


//service/application/oracle/oracleInterface/oracleInterface.go:117
err = oracleApplication.RegFunction(a3{})
```

### Step3. Start BlockchainService

```go
Chain := blockchain.Config{
.....
ExternalExecutors: []chainStructure.IBlockchainExternalApplication{oracleApplication},
}
service := system.NewBlockchainService(Chain)
```

### Step4: API

> See [oracle_api.md](./oracle_api.md)

## Actions

| type                                | interface                | desc |
|-------------------------------------|--------------------------|------|
| Simple Action                       | Action                   | ...  |
| Validate data from remote           | ActionRemoteVerifier     | ...  |
| Manually pull data from remote      | ActionRemoteManualPuller | ...  |
| Automatically pull data from remote | ActionRemoteAutoPuller   | ...  |
| Request to save data from API       | ActionRequestSaver       | ...  |

### Actions describe:

```go
package oracleInterface

type Action interface {
	Name() string
	//Desc: ActionName : Related to API(/api/v1/call/application) JSON parameter `requestaction`

	FormatResult(req blockchainRequest.Entity) (interface{}, error)
	//Desc: return The data saved on the blockchain is used to query the API(/api/v1/query/application/Oracle)
}
type ActionRemoteVerifier interface {
	Action
	RemoteGet
	RequestVerifier
}

type ActionRemoteManualPuller interface {
	Action
	RemoteGet
	RequestVerifier
}

type ActionRemoteAutoPuller interface {
	RequestVerifier
	Action
	AutoFunc
	RemoteGet
}

type ActionRequestSaver interface {
	Action
	RequestVerifier
}

type AutoFunc interface {
	//CronPaths data format{Second | Minute | Hour | Dom | Month | Dow | Descriptor}
	CronPaths() []string
	//Desc: Returns the scheduled task execution interval that conforms to cron syntax 
}

type RequestVerifier interface {
	VerifyReq(r blockchainRequest.Entity) error
}
type RemoteGet interface {
	VerifyRemoteResp(*http.Response) (blockchainRequest.Entity, error)
	//Desc: Verify the data obtained from the remote end and return blockchainrequest Entity

	VerifyRemoteCA(state tls.ConnectionState) error
	//Desc: Verify HTTPS certificate for remote connection

	UrlContentType() (string, string)
	//Desc: remote url and request content-type
}

```

###