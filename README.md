# JACKPOT - The one that rules em all

	Links to all Jackpot repositories

## How to add a repo

```bash
git submodule add git@github.com:jackpot-mab/arm-selector.git
```

## How to update repos

```bash
git submodule update --init --recursive
git submodule update --remote --merge
```

TODOS:
1. You still have to create model bucket in minio or in S3
2. You still have to run db_creation scripts manually (located in experiment_params/db_schema)

