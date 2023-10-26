#!/bin/bash

set -e

cat ascii_banner.txt

echo "Jackpot initializer script"

# Check if MySQL environment variables are set
if [ -z "${DB_HOST}" ] || [ -z "${DB_PORT}" ] || [ -z "${DB_USER}" ] || [ -z "${DB_PASSWORD}" ] ; then
    echo "MySQL environment variables are not set. Please set the required variables."
    exit 1
fi

# Check if S3/Minio environment variables are set
if [ -z "${S3_ENDPOINT}" ] || [ -z "${BUCKET_NAME}" ] || [ -z "${AWS_KEY}" ] || [ -z "${AWS_SECRET}" ]; then
    echo "S3/Minio environment variables are not set. Please set the required variables."
    exit 1
fi

echo "Waiting 15 seconds to the db to be up..."
sleep 15
echo "Starting.."

echo "Excuting db creation script...."

mysql -h "${DB_HOST}" -P "${DB_PORT}" -u "${DB_USER}" -p"${DB_PASSWORD}" < db/creation_schema.sql

echo "Finalized db creation."

echo "Generating bucket in S3/Minio...."
export AWS_ACCESS_KEY_ID=${AWS_KEY}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET}

if aws --endpoint-url "${S3_ENDPOINT}" s3 ls "s3://${BUCKET_NAME}" 2>/dev/null; then
  echo "The bucket '${BUCKET_NAME}' exists."
else
  aws --endpoint-url "${S3_ENDPOINT}" s3api create-bucket --bucket "${BUCKET_NAME}"
fi

echo "Finalized bucket creation."

echo "Executing cassandra script...."
cqlsh ${CASSANDRA_HOST} -p ${CASSANDRA_PORT} -f cass/db_init.cql
echo "Cassandra script executed."

echo "All done! Bye."

