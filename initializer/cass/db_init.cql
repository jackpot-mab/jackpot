drop keyspace store;

CREATE KEYSPACE store
  WITH REPLICATION = { 
   'class' : 'SimpleStrategy', 
   'replication_factor' : 1 
  };

-- Table optimized for fetching based on experiment_id and timestamp
CREATE TABLE IF NOT EXISTS store.reward_by_experiment_date (
   arm_selected text,
   experiment_id text,
   timestamp timestamp,
   session_id text,
   reward int,
   context map<text, text>,
   PRIMARY KEY ((experiment_id), timestamp, session_id)
) WITH CLUSTERING ORDER BY (timestamp DESC);

CREATE TABLE IF NOT EXISTS store.rewards_by_session (
    arm_selected text,
    experiment_id text,
    timestamp timestamp,
    session_id text,
    context map<text, text>,
    PRIMARY KEY (experiment_id, session_id)
);
