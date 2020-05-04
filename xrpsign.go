package main

import "C"

import (
	"fmt"
	"log"
	"os"

	"github.com/rubblelabs/ripple/crypto"
	"github.com/rubblelabs/ripple/data"
)

func checkerr(err error) {
	if err != nil {
		log.Println(err.Error())
		os.Exit(1)
	}
}

//export Sign
func Sign(tx, s *C.char) *C.char {
	keyseq := uint32(0)
	seed, err := crypto.NewRippleHashCheck(C.GoString(s), crypto.RIPPLE_FAMILY_SEED)
	checkerr(err)
	key, err := crypto.NewECDSAKey(seed.Payload())
	checkerr(err)
	txData := []byte(C.GoString(tx))
	var txm data.TransactionWithMetaData
	err = txm.UnmarshalJSON(txData)
	checkerr(err)
	transaction := txm.Transaction
	err = data.Sign(transaction, key, &keyseq)
	checkerr(err)
	_, raw, err := data.Raw(transaction)
	checkerr(err)
	return C.CString(fmt.Sprintf("%X", raw))
}

func main() {}
