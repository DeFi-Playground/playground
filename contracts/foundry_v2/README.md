## Uniswap V2 Interactions

We are using Unichain Sepolia, according to the [docs](https://docs.unichain.org/docs/technical-information/contract-addresses#unichain-sepolia) here are the contract addresses:

| --- | --- |
| Factory | [0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f](https://sepolia.uniscan.xyz/address/0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f)  |
| UniswapV2Router02 | [0x920b806E40A00E02E7D2b94fFc89860fDaEd3640](https://sepolia.uniscan.xyz/address/0x920b806E40A00E02E7D2b94fFc89860fDaEd3640) |

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
