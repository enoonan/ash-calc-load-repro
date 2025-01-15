import Config

config :calc_rel, CalcRel.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "calc_rel_dev",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
