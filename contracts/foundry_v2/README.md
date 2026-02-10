## Uniswap V2 Interactions

We are using Unichain Sepolia, according to the [docs](https://docs.unichain.org/docs/technical-information/contract-addresses#unichain-sepolia) here are the contract addresses:

| Contract Name | Contract Address |
| --- | --- |
| Factory | [0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f](https://sepolia.uniscan.xyz/address/0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f)  |
| UniswapV2Router02 | [0x920b806E40A00E02E7D2b94fFc89860fDaEd3640](https://sepolia.uniscan.xyz/address/0x920b806E40A00E02E7D2b94fFc89860fDaEd3640) |

## RPCs

- https://unichain-sepolia-rpc.publicnode.com

## Deployments

| Contract Name | Contract Address |
| --- | --- |
| PlaygroundDefiToken (PDT) | [0x08bBB4a9D79b8399852cE870a901577a939c9983](https://unichain-sepolia.blockscout.com/token/0x08bBB4a9D79b8399852cE870a901577a939c9983) |
| USDPlaygroundToken (USDP) | [0x255b030F3d2b8023C7aCc11A5A25C768a4F99Af4](https://unichain-sepolia.blockscout.com/token/0x255b030F3d2b8023C7aCc11A5A25C768a4F99Af4) |
| Pair(USDP,PDT) | [0x486c627015838998A04e7742399700ff50643656](https://unichain-sepolia.blockscout.com/address/0x486c627015838998A04e7742399700ff50643656) |

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
