-- +migrate Up
CREATE TABLE IF NOT EXISTS colors (
  `id`        bigint(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `value`     varchar(255),
  `created`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified`  datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- +migrate Down
DROP TABLE colors;
