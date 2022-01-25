package main

import (
	"github.com/SealSC/SealABC/service/system"
	"github.com/SealSC/SealABC/network"
	"github.com/SealSC/SealABC/crypto"
	"github.com/SealSC/SealABC/network/http"
	"github.com/SealSC/SealABC/storage/db"
	"github.com/SealSC/SealABC/storage/db/dbDrivers/simpleMysql"
	"github.com/SealSC/SealABC/storage/db/dbDrivers/levelDB"
	"github.com/SealSC/SealABC/log"
	"github.com/sirupsen/logrus"
	"github.com/SealSC/SealABC/engine"
	"github.com/SealSC/SealABC/engine/engineStartup"
	"github.com/SealSC/SealABC/engine/engineApi"
	"github.com/SealSC/SealABC/service/system/blockchain"
	"github.com/SealSC/SealABC/service/system/blockchain/chainStructure"
	"github.com/SealSC/SealABC/service/system/blockchain/chainApi"
	"github.com/SealSC/SealABC/service/system/blockchain/chainSQLStorage"
	"github.com/SealSC/SealABC/service/application/oracle/oracleInterface"
	"time"
	"fmt"
	"github.com/SealSC/SealABC/network/topology/p2p/fullyConnect"
	"github.com/SealSC/SealABC/consensus/hotStuff"
	ed25519_ "github.com/SealSC/SealABC/crypto/signers/ed25519"
	"encoding/hex"
	"github.com/SealSC/SealABC/crypto/signers/signerCommon"
	"github.com/SealSC/SealEVM"
	"github.com/SealSC/SealABC/common/utility"
	"os"
	"strconv"
	"github.com/SealSC/SealABC/crypto/hashes/sha3"
	"github.com/SealSC/SealABC/crypto/ciphers/aes"
	"github.com/SealSC/SealABC/metadata/blockchainRequest"
	"github.com/SealSC/SealABC/metadata/applicationResult"
	"crypto/tls"
	http2 "net/http"
	"mime"
	"io/ioutil"
	"crypto/sha1"
	"errors"
)

var pkList = []pk{
	{
		pk:  "52345410a668e9247d23066e05bd483503aa5e6149c5f12d603478bf62e052fbb4418d60a7396e8a8aca7c2364ca23ccaaef9fb370a918970c637d364530ed57",
		pub: "b4418d60a7396e8a8aca7c2364ca23ccaaef9fb370a918970c637d364530ed57",
	},
	{
		pk:  "32bcd37c3eabe7c58f50ca6300a219a3d847d600d75ad022cc02ed3b0e08eee8778e31cf52c133ccf6dffdbeb36d0b465d3b56df0ad37c281c23c9fb93ff81d1",
		pub: "778e31cf52c133ccf6dffdbeb36d0b465d3b56df0ad37c281c23c9fb93ff81d1",
	},
	{
		pk:  "0411754cde6f272da07353a7e596f53c349724c2bc9d68165ce5c36ad1e8e611d07997de88077fc19aacbfd50463af92b218f628d7f5433aac08f59d89b6eb3c",
		pub: "d07997de88077fc19aacbfd50463af92b218f628d7f5433aac08f59d89b6eb3c",
	},
	{
		pk:  "5a86674ff95900b4a2aade1f55b4e3483434756b50a07a14508d7401be4bb82ad38ead09a1ca964d61b2f7b1e3065f3114df8ff7aa5b26dfcb8247ccd6ad312d",
		pub: "d38ead09a1ca964d61b2f7b1e3065f3114df8ff7aa5b26dfcb8247ccd6ad312d",
	},
	{
		pk:  "31182e334926da235278e4e5af97253eff7d08c882ce401986fb22c447cb1e2ac0eb507da912f06f116fadb5345de4f19e09ee7c8c1a8d4777eb55209e131d04",
		pub: "c0eb507da912f06f116fadb5345de4f19e09ee7c8c1a8d4777eb55209e131d04",
	},
}

func init() {
	SealEVM.Load()
	utility.Load()
	crypto.Load()
}

type pk struct {
	pk  string
	pub string
}

type a3 struct{}

func (a a3) VerifyReq(r blockchainRequest.Entity) error                     { return nil }
func (a a3) Name() string                                                   { return "120" }
func (a a3) FormatResult(req blockchainRequest.Entity) (interface{}, error) { return req.Data, nil }
func (a a3) CronPaths() []string                                            { return []string{"0 0/1 * * * *"} }

func sha1Hash(b []byte) []byte {
	hash := sha1.New()
	_, err := hash.Write(b)
	if err != nil {
		panic(err)
	}
	return hash.Sum(nil)
}

func (a a3) VerifyRemoteResp(response *http2.Response) (blockchainRequest.Entity, error) {
	var result blockchainRequest.Entity
	if response.StatusCode != http2.StatusOK {
		return result, errors.New(response.Status)
	}
	all, err := ioutil.ReadAll(response.Body)
	if err != nil {
		return result, err
	}
	result.Data = all
	result.Seal.Hash = sha1Hash(all)
	return result, nil
}

func (a a3) VerifyRemoteCA(state tls.ConnectionState) error { return nil }

func (a a3) UrlContentType() (string, string) {
	return "http://127.0.0.1:8888/now", mime.TypeByExtension(".json")
}

type a2 struct{}

func (a a2) Name() string                             { return "001" }
func (a a2) VerifyReq(blockchainRequest.Entity) error { return nil }
func (a a2) FormatResult(req blockchainRequest.Entity) (result applicationResult.Entity, err error) {
	result.Data = req.Data
	result.Seal = &req.Seal
	return
}

func main() {
	if len(os.Args) < 2 {
		return
	}
	atoi, _ := strconv.Atoi(os.Args[1])
	if atoi > 4 || atoi < 0 {
		return
	}
	var ConsensusNetworkAddr = 9080
	var P2PNetworkAddr = 9090
	var engineApiAddr = 8090
	var APIAddr = 8080

	var name = fmt.Sprintf("0x%d", atoi)
	var members []hotStuff.Member
	var P2PSeeds []string
	var ConsensusP2PSeeds []string
	for i, p := range pkList {
		if i == atoi {
			continue
		}
		members = append(members, hotStuff.Member{Signer: ed25519Pub(p.pub)})
		P2PSeeds = append(P2PSeeds, fmt.Sprintf("127.0.0.1:%d", P2PNetworkAddr+i))
		ConsensusP2PSeeds = append(ConsensusP2PSeeds, fmt.Sprintf("127.0.0.1:%d", ConsensusNetworkAddr+i))
	}

	sqlDriver, err := db.NewSimpleSQLDatabaseDriver("MySQL", simpleMysql.Config{
		User:          "root",
		Password:      "123456789",
		DBName:        name,
		Charset:       "utf8mb4",
		MaxConnection: 255,
	})
	if err != nil {
		panic(err)
	}

	driver, err := db.NewKVDatabaseDriver("levelDB", levelDB.Config{
		DBFilePath: fmt.Sprintf("./cache.%s.db", name),
	})
	if err != nil {
		panic(err)
	}

	pri := ed25519Pri(pkList[atoi].pk)
	oracleApplication := oracleInterface.NewOracleApplication(time.Second*30, sqlDriver, driver)

	err = oracleApplication.RegFunction(a3{})
	if err != nil {
		panic(err)
	}
	config := engineStartup.Config{
		Api: engineApi.Config{
			HttpJSON: http.Config{
				Address:        fmt.Sprintf(":%d", engineApiAddr+atoi),
				BasePath:       "",
				EnableTLS:      false,
				AllowCORS:      false,
				RequestHandler: nil,
			},
		},
		Log: log.Config{
			Level:   logrus.DebugLevel,
			LogFile: "./xx.log",
		},
		//SelfSigner: nil, //没用
		//CryptoTools: crypto.Tools{ //没用
		//	HashCalculator:  nil,
		//	Cipher:          nil,
		//	SignerGenerator: nil,
		//},
		//StorageConfig: nil, //没用
		ConsensusNetwork: network.Config{
			ID:              pri.PublicKeyString(),
			ClientOnly:      false,
			ServiceProtocol: "tcp",
			ServiceAddress:  fmt.Sprintf(":%d", ConsensusNetworkAddr+atoi),
			P2PSeeds:        ConsensusP2PSeeds,
			Topology:        fullyConnect.NewTopology(),
			Router:          nil,
		},
		ConsensusDisabled: false, //没用
		//Consensus:         nil,
		Consensus: hotStuff.Config{
			SelfSigner:                pri,
			Members:                   members,
			MemberOnlineCheckInterval: time.Second * 1,
			ConsensusTimeout:          time.Millisecond * 15000,
			ConsensusInterval:         time.Millisecond * 5000,
			Network:                   network.Service{},
			SingerGenerator:           ed25519_.SignerGenerator,
			HashCalc:                  sha3.Sha256,
		},
		SystemService: system.Config{ //没用
			Chain: blockchain.Config{
				ServiceName: "demo service",
				Blockchain: chainStructure.Config{
					Signer: pri,
					CryptoTools: crypto.Tools{
						HashCalculator:  sha3.Sha256,
						SignerGenerator: ed25519_.SignerGenerator,
						Cipher:          aes.Cipher,
					},
					NewWhenGenesis: false,
					StorageDriver:  driver,
					SQLStorage:     &chainSQLStorage.Storage{Driver: sqlDriver},
				},
				Network: network.Config{
					ID:              pri.PrivateKeyString(),
					ClientOnly:      false,
					ServiceProtocol: "tcp",
					ServiceAddress:  fmt.Sprintf(":%d", P2PNetworkAddr+atoi),
					P2PSeeds:        P2PSeeds,
					Topology:        fullyConnect.NewTopology(),
					Router:          nil,
				},
				Api: chainApi.Config{
					HttpJSON: http.Config{
						Address:        fmt.Sprintf(":%d", APIAddr+atoi),
						BasePath:       "",
						EnableTLS:      false,
						AllowCORS:      false,
						RequestHandler: nil,
					},
				},
				EnableSQLDB:       true,
				SQLStorage:        sqlDriver,
				ExternalExecutors: []chainStructure.IBlockchainExternalApplication{oracleApplication},
			},
		},
	}
	engine.Startup(config)
	service := system.NewBlockchainService(config.SystemService.Chain)
	fmt.Println(service)
	select {}
}
func ed25519Pub(h string) signerCommon.ISigner {
	mk, err := hex.DecodeString(h)
	if err != nil {
		panic(err)
	}
	key, err := ed25519_.SignerGenerator.FromRawPublicKey(mk)
	if err != nil {
		panic(err)
	}
	return key
}
func ed25519Pri(h string) signerCommon.ISigner {
	sk, err := hex.DecodeString(h)
	if err != nil {
		panic(err)
	}
	selfSigner, err := ed25519_.SignerGenerator.FromRawPrivateKey(sk)
	if err != nil {
		panic(err)
	}
	return selfSigner
}
