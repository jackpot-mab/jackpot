CREATE KEYSPACE IF NOT EXISTS store
  WITH REPLICATION = { 
   'class' : 'SimpleStrategy', 
   'replication_factor' : 1 
  };

-- Table optimized for fetching based on experiment_id and timestamp
CREATE TABLE IF NOT EXISTS store.reward (
    arm_selected int,
    experiment_id text,
    timestamp timestamp,
    session_id text,
    reward int,
    context map<text, text>,
    PRIMARY KEY ((experiment_id, session_id), timestamp)
) WITH CLUSTERING ORDER BY (timestamp DESC);
