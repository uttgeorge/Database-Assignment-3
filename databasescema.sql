-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hyperparameter
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hyperparameter
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hyperparameter` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema Basketball
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Basketball
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Basketball` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `hyperparameter` ;

-- -----------------------------------------------------
-- Table `hyperparameter`.`dataset_cat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter`.`dataset_cat` (
  `dataset_id` INT(11) NOT NULL AUTO_INCREMENT,
  `dataset_name` TEXT NOT NULL,
  `domain` TEXT NOT NULL,
  PRIMARY KEY (`dataset_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hyperparameter`.`iteration2_500`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter`.`iteration2_500` (
  `model_id` TEXT NULL DEFAULT NULL,
  `mean_residual_deviance` DOUBLE NULL DEFAULT NULL,
  `rmse` DOUBLE NULL DEFAULT NULL,
  `mse` DOUBLE NULL DEFAULT NULL,
  `mae` DOUBLE NULL DEFAULT NULL,
  `rmsle` DOUBLE NULL DEFAULT NULL,
  `dataset_id` TEXT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hyperparameter`.`models`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter`.`models` (
  `dataset_id` INT(11) NULL DEFAULT NULL,
  `model_id` INT(11) NOT NULL AUTO_INCREMENT,
  `model_name` TEXT NOT NULL,
  `mrd` DOUBLE NULL DEFAULT NULL,
  `rmse` DOUBLE NULL DEFAULT NULL,
  `mse` DOUBLE NULL DEFAULT NULL,
  `mae` DOUBLE NULL DEFAULT NULL,
  `rmsle` DOUBLE NULL DEFAULT NULL,
  `histogram_type` TEXT NULL DEFAULT NULL,
  `learn_rate` DOUBLE NULL DEFAULT NULL,
  `fold_column` TEXT NULL DEFAULT NULL,
  `col_sample_rate_per_tree` DOUBLE NULL DEFAULT NULL,
  `learn_rate_annealing` DOUBLE NULL DEFAULT NULL,
  `score_tree_interval` INT(11) NULL DEFAULT NULL,
  `sample_rate_per_class` TEXT NULL DEFAULT NULL,
  `seed` BIGINT(20) NULL DEFAULT NULL,
  `weights_column` TEXT NULL DEFAULT NULL,
  `nfolds` INT(11) NULL DEFAULT NULL,
  `keep_cross_validation_models` TEXT NULL DEFAULT NULL,
  `offset_column` TEXT NULL DEFAULT NULL,
  `categorical_encoding` TEXT NULL DEFAULT NULL,
  `checkpoint` TEXT NULL DEFAULT NULL,
  `stopping_tolerance` DOUBLE NULL DEFAULT NULL,
  `monotone_constraints` TEXT NULL DEFAULT NULL,
  `training_frame` TEXT NULL DEFAULT NULL,
  `max_hit_ratio_k` INT(11) NULL DEFAULT NULL,
  `max_runtime_secs` DOUBLE NULL DEFAULT NULL,
  `calibrate_model` TEXT NULL DEFAULT NULL,
  `max_abs_leafnode_pred` DOUBLE NULL DEFAULT NULL,
  `export_checkpoints_dir` TEXT NULL DEFAULT NULL,
  `balance_classes` TEXT NULL DEFAULT NULL,
  `sample_rate` DOUBLE NULL DEFAULT NULL,
  `pred_noise_bandwidth` DOUBLE NULL DEFAULT NULL,
  `max_depth` INT(11) NULL DEFAULT NULL,
  `custom_metric_func` TEXT NULL DEFAULT NULL,
  `build_tree_one_node` TEXT NULL DEFAULT NULL,
  `ntrees` INT(11) NULL DEFAULT NULL,
  `min_split_improvement` DOUBLE NULL DEFAULT NULL,
  `ignored_columns` JSON NULL DEFAULT NULL,
  `tweedie_power` DOUBLE NULL DEFAULT NULL,
  `min_rows` DOUBLE NULL DEFAULT NULL,
  `max_after_balance_size` DOUBLE NULL DEFAULT NULL,
  `score_each_iteration` TEXT NULL DEFAULT NULL,
  `max_confusion_matrix_size` INT(11) NULL DEFAULT NULL,
  `quantile_alpha` DOUBLE NULL DEFAULT NULL,
  `col_sample_rate_change_per_level` DOUBLE NULL DEFAULT NULL,
  `nbins` INT(11) NULL DEFAULT NULL,
  `validation_frame` TEXT NULL DEFAULT NULL,
  `huber_alpha` DOUBLE NULL DEFAULT NULL,
  `col_sample_rate` DOUBLE NULL DEFAULT NULL,
  `fold_assignment` TEXT NULL DEFAULT NULL,
  `keep_cross_validation_predictions` TEXT NULL DEFAULT NULL,
  `stopping_rounds` INT(11) NULL DEFAULT NULL,
  `nbins_top_level` INT(11) NULL DEFAULT NULL,
  `stopping_metric` TEXT NULL DEFAULT NULL,
  `nbins_cats` INT(11) NULL DEFAULT NULL,
  `r2_stopping` DOUBLE NULL DEFAULT NULL,
  `calibration_frame` TEXT NULL DEFAULT NULL,
  `distribution` TEXT NULL DEFAULT NULL,
  `class_sampling_factors` TEXT NULL DEFAULT NULL,
  `check_constant_response` TEXT NULL DEFAULT NULL,
  `ignore_const_cols` TEXT NULL DEFAULT NULL,
  `keep_cross_validation_fold_assignment` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`model_id`),
  INDEX `fk_dataset_idx` (`dataset_id` ASC) VISIBLE,
  CONSTRAINT `fk_dataset`
    FOREIGN KEY (`dataset_id`)
    REFERENCES `hyperparameter`.`dataset_cat` (`dataset_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hyperparameter`.`mushroom_training_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter`.`mushroom_training_data` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `class` INT(11) NULL DEFAULT NULL,
  `cap-shape` INT(11) NULL DEFAULT NULL,
  `cap-surface` INT(11) NULL DEFAULT NULL,
  `cap-color` INT(11) NULL DEFAULT NULL,
  `bruises` INT(11) NULL DEFAULT NULL,
  `odor` INT(11) NULL DEFAULT NULL,
  `gill-attachment` INT(11) NULL DEFAULT NULL,
  `gill-spacing` INT(11) NULL DEFAULT NULL,
  `gill-size` INT(11) NULL DEFAULT NULL,
  `gill-color` INT(11) NULL DEFAULT NULL,
  `stalk-shape` INT(11) NULL DEFAULT NULL,
  `stalk-root` INT(11) NULL DEFAULT NULL,
  `stalk-surface-above-ring` INT(11) NULL DEFAULT NULL,
  `stalk-surface-below-ring` INT(11) NULL DEFAULT NULL,
  `stalk-color-above-ring` INT(11) NULL DEFAULT NULL,
  `stalk-color-below-ring` INT(11) NULL DEFAULT NULL,
  `veil-type` INT(11) NULL DEFAULT NULL,
  `veil-color` INT(11) NULL DEFAULT NULL,
  `ring-number` INT(11) NULL DEFAULT NULL,
  `ring-type` INT(11) NULL DEFAULT NULL,
  `spore-print-color` INT(11) NULL DEFAULT NULL,
  `population` INT(11) NULL DEFAULT NULL,
  `habitat` INT(11) NULL DEFAULT NULL,
  `dataset_cat_dataset_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_mushroom_training_data_dataset_cat1_idx` (`dataset_cat_dataset_id` ASC, `id` ASC) VISIBLE,
  CONSTRAINT `fk_mushroom_training_data_dataset_cat1`
    FOREIGN KEY (`dataset_cat_dataset_id` , `id`)
    REFERENCES `hyperparameter`.`dataset_cat` (`dataset_id` , `dataset_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `Basketball` ;

-- -----------------------------------------------------
-- Table `Basketball`.`teamstats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`teamstats` (
  `Team` TEXT NOT NULL,
  `Wins` INT(11) NULL DEFAULT NULL,
  `Losses` INT(11) NULL DEFAULT NULL,
  `Minutes` INT(11) NULL DEFAULT NULL,
  `Points` DOUBLE NULL DEFAULT NULL,
  `FieldGoalsAttempted` DOUBLE NULL DEFAULT NULL,
  `FieldGoalsMade` DOUBLE NULL DEFAULT NULL,
  `FieldGoalsPercentage` DOUBLE NULL DEFAULT NULL,
  `TwoPointersAttempted` DOUBLE NULL DEFAULT NULL,
  `TwoPointersMade` DOUBLE NULL DEFAULT NULL,
  `TwoPointersPercentage` DOUBLE NULL DEFAULT NULL,
  `ThreePointersAttempted` DOUBLE NULL DEFAULT NULL,
  `ThreePointersMade` DOUBLE NULL DEFAULT NULL,
  `ThreePointersPercentage` DOUBLE NULL DEFAULT NULL,
  `FreeThrowsAttempted` DOUBLE NULL DEFAULT NULL,
  `FreeThrowsMade` DOUBLE NULL DEFAULT NULL,
  `FreeThrowsPercentage` DOUBLE NULL DEFAULT NULL,
  `Rebounds` DOUBLE NULL DEFAULT NULL,
  `OffensiveRebounds` DOUBLE NULL DEFAULT NULL,
  `DefensiveRebounds` DOUBLE NULL DEFAULT NULL,
  `Assists` DOUBLE NULL DEFAULT NULL,
  `Blocks` DOUBLE NULL DEFAULT NULL,
  `Steals` DOUBLE NULL DEFAULT NULL,
  `Turnovers` DOUBLE NULL DEFAULT NULL,
  `Fouls` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`Team`(255)))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Basketball`.`teamnames`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`teamnames` (
  `Team_Name` TEXT NULL DEFAULT NULL,
  `Team` VARCHAR(255) NOT NULL,
  `teamstats_Team` TEXT NOT NULL,
  PRIMARY KEY (`Team`),
  INDEX `fk_teamnames_teamstats1_idx` (`teamstats_Team` ASC) VISIBLE,
  CONSTRAINT `fk_teamnames_teamstats1`
    FOREIGN KEY (`teamstats_Team`)
    REFERENCES `Basketball`.`teamstats` (`Team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Basketball`.`Salary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`Salary` (
  `Personid` INT(11) NOT NULL DEFAULT '0',
  `Salary` DOUBLE NULL DEFAULT NULL,
  `AllStar` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`Personid`),
  INDEX `idx_star` (`AllStar`(25) ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Basketball`.`Detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`Detail` (
  `Team` VARCHAR(255) NOT NULL,
  `BirthDate` TEXT NULL DEFAULT NULL,
  `BirthCity` TEXT NULL DEFAULT NULL,
  `College` TEXT NULL DEFAULT NULL,
  `Height` INT(11) NULL DEFAULT NULL,
  `Weight` INT(11) NULL DEFAULT NULL,
  `PhotoUrl` TEXT NULL DEFAULT NULL,
  `Position` TEXT NULL DEFAULT NULL,
  `JerseyNo` INT(11) NULL DEFAULT NULL,
  `ExperienceYear` INT(11) NULL DEFAULT NULL,
  `Personid` INT(11) NOT NULL DEFAULT '0',
  `FirstName` VARCHAR(50) NULL DEFAULT NULL,
  `LastName` VARCHAR(50) NULL DEFAULT NULL,
  `Salary_Personid` INT(11) NOT NULL,
  PRIMARY KEY (`Personid`),
  INDEX `detail_teamnames_fk` (`Team` ASC) VISIBLE,
  INDEX `fk_Detail_Salary1_idx` (`Salary_Personid` ASC) VISIBLE,
  CONSTRAINT `detail_teamnames_fk`
    FOREIGN KEY (`Team`)
    REFERENCES `Basketball`.`teamnames` (`Team`),
  CONSTRAINT `fk_Detail_Salary1`
    FOREIGN KEY (`Salary_Personid`)
    REFERENCES `Basketball`.`Salary` (`Personid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Basketball`.`nba_twitter_accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`nba_twitter_accounts` (
  `Abbr` TEXT NULL DEFAULT NULL,
  `Name` TEXT NULL DEFAULT NULL,
  `Account` TEXT NOT NULL,
  `teamnames_Team` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Account`(255), `teamnames_Team`),
  INDEX `idx_tm` (`Abbr`(25) ASC) VISIBLE,
  INDEX `fk_nba_twitter_accounts_teamnames1_idx` (`teamnames_Team` ASC) VISIBLE,
  CONSTRAINT `fk_nba_twitter_accounts_teamnames1`
    FOREIGN KEY (`teamnames_Team`)
    REFERENCES `Basketball`.`teamnames` (`Team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Basketball`.`Tweets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`Tweets` (
  `Tweets` TEXT NULL DEFAULT NULL,
  `id` VARCHAR(255) NOT NULL,
  `account` TEXT NOT NULL,
  `len` INT(11) NULL DEFAULT NULL,
  `date` TEXT NULL DEFAULT NULL,
  `likes` INT(11) NULL DEFAULT NULL,
  `retweets` INT(11) NULL DEFAULT NULL,
  `#hashtag` INT(11) NULL DEFAULT NULL,
  `nba_twitter_accounts_Account` TEXT NOT NULL,
  `nba_twitter_accounts_teamnames_Team` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`, `nba_twitter_accounts_Account`, `nba_twitter_accounts_teamnames_Team`),
  INDEX `fk_Tweets_nba_twitter_accounts1_idx` (`nba_twitter_accounts_Account` ASC, `nba_twitter_accounts_teamnames_Team` ASC) VISIBLE,
  CONSTRAINT `fk_Tweets_nba_twitter_accounts1`
    FOREIGN KEY (`nba_twitter_accounts_Account` , `nba_twitter_accounts_teamnames_Team`)
    REFERENCES `Basketball`.`nba_twitter_accounts` (`Account` , `teamnames_Team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Basketball`.`Hashtag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`Hashtag` (
  `id` BIGINT(20) NOT NULL,
  `ht` MEDIUMTEXT NOT NULL,
  `Tweets_id` VARCHAR(255) NOT NULL,
  `Tweets_nba_twitter_accounts_Account` TEXT NOT NULL,
  `Tweets_nba_twitter_accounts_teamnames_Team` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`, `ht`(255)),
  INDEX `fk_Hashtag_Tweets1_idx` (`Tweets_id` ASC, `Tweets_nba_twitter_accounts_Account` ASC, `Tweets_nba_twitter_accounts_teamnames_Team` ASC) VISIBLE,
  CONSTRAINT `fk_Hashtag_Tweets1`
    FOREIGN KEY (`Tweets_id` , `Tweets_nba_twitter_accounts_Account` , `Tweets_nba_twitter_accounts_teamnames_Team`)
    REFERENCES `Basketball`.`Tweets` (`id` , `nba_twitter_accounts_Account` , `nba_twitter_accounts_teamnames_Team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Basketball`.`NBA_Twitter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`NBA_Twitter` (
  `Tweets` TEXT NULL DEFAULT NULL,
  `team` TEXT NULL DEFAULT NULL,
  `id` BIGINT(20) NULL DEFAULT NULL,
  `account` TEXT NULL DEFAULT NULL,
  `len` INT(11) NULL DEFAULT NULL,
  `date` TEXT NULL DEFAULT NULL,
  `likes` INT(11) NULL DEFAULT NULL,
  `retweets` INT(11) NULL DEFAULT NULL,
  `#hashtag` INT(11) NULL DEFAULT NULL,
  `N1` TEXT NULL DEFAULT NULL,
  `N2` TEXT NULL DEFAULT NULL,
  `N3` TEXT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Basketball`.`POP_TEAM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`POP_TEAM` (
  `team` TEXT NULL DEFAULT NULL,
  `Tweets` TEXT NULL DEFAULT NULL,
  `likes` INT(11) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Basketball`.`Stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`Stats` (
  `Personid` INT(11) NOT NULL DEFAULT '0',
  `GP` INT(11) NULL DEFAULT NULL,
  `MPG` DOUBLE NULL DEFAULT NULL,
  `FGM` DOUBLE NULL DEFAULT NULL,
  `FGA` DOUBLE NULL DEFAULT NULL,
  `FG%` DOUBLE NULL DEFAULT NULL,
  `3PM` DOUBLE NULL DEFAULT NULL,
  `3PA` DOUBLE NULL DEFAULT NULL,
  `3P%` DOUBLE NULL DEFAULT NULL,
  `FTM` DOUBLE NULL DEFAULT NULL,
  `FTA` DOUBLE NULL DEFAULT NULL,
  `FT%` DOUBLE NULL DEFAULT NULL,
  `TOV` DOUBLE NULL DEFAULT NULL,
  `PF` DOUBLE NULL DEFAULT NULL,
  `ORB` DOUBLE NULL DEFAULT NULL,
  `DRB` DOUBLE NULL DEFAULT NULL,
  `RPG` DOUBLE NULL DEFAULT NULL,
  `APG` DOUBLE NULL DEFAULT NULL,
  `SPG` DOUBLE NULL DEFAULT NULL,
  `BPG` DOUBLE NULL DEFAULT NULL,
  `PPG` DOUBLE NULL DEFAULT NULL,
  `Detail_Personid` INT(11) NOT NULL,
  PRIMARY KEY (`Personid`),
  INDEX `fk_Stats_Detail1_idx` (`Detail_Personid` ASC) VISIBLE,
  CONSTRAINT `fk_Stats_Detail1`
    FOREIGN KEY (`Detail_Personid`)
    REFERENCES `Basketball`.`Detail` (`Personid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Basketball`.`hashtags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`hashtags` (
  `id` BIGINT(20) NULL DEFAULT NULL,
  `N1` TEXT NULL DEFAULT NULL,
  `N2` TEXT NULL DEFAULT NULL,
  `N3` TEXT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Basketball`.`nba_salary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`nba_salary` (
  `Player` TEXT NULL DEFAULT NULL,
  `Team` TEXT NULL DEFAULT NULL,
  `Salary` DOUBLE NULL DEFAULT NULL,
  `AllStar` TEXT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Basketball`.`nba_tweets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`nba_tweets` (
  `Tweets` TEXT NULL DEFAULT NULL,
  `team` TEXT NULL DEFAULT NULL,
  `id` VARCHAR(255) NULL DEFAULT NULL,
  `account` TEXT NULL DEFAULT NULL,
  `len` INT(11) NULL DEFAULT NULL,
  `date` TEXT NULL DEFAULT NULL,
  `likes` INT(11) NULL DEFAULT NULL,
  `retweets` INT(11) NULL DEFAULT NULL,
  `#hashtag` INT(11) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Basketball`.`player_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`player_details` (
  `PlayerName` TEXT NULL DEFAULT NULL,
  `Team` TEXT NULL DEFAULT NULL,
  `BirthDate` TEXT NULL DEFAULT NULL,
  `BirthCity` TEXT NULL DEFAULT NULL,
  `College` TEXT NULL DEFAULT NULL,
  `Height` INT(11) NULL DEFAULT NULL,
  `Weight` INT(11) NULL DEFAULT NULL,
  `PhotoUrl` TEXT NULL DEFAULT NULL,
  `Pos` VARCHAR(25) NULL DEFAULT NULL,
  `JerseyNo` INT(11) NULL DEFAULT NULL,
  `ExperienceYear` INT(11) NULL DEFAULT NULL,
  `Personid` INT(11) NOT NULL AUTO_INCREMENT,
  UNIQUE INDEX `Personid` (`Personid` ASC) VISIBLE,
  INDEX `team_idx` (`Team`(25) ASC) VISIBLE,
  INDEX `position_idx` (`Pos` ASC) VISIBLE,
  INDEX `idx_exp` (`ExperienceYear` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 500
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Basketball`.`player_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basketball`.`player_stats` (
  `Player` TEXT NULL DEFAULT NULL,
  `Team` TEXT NULL DEFAULT NULL,
  `GP` INT(11) NULL DEFAULT NULL,
  `MPG` DOUBLE NULL DEFAULT NULL,
  `FGM` DOUBLE NULL DEFAULT NULL,
  `FGA` DOUBLE NULL DEFAULT NULL,
  `FG%` DOUBLE NULL DEFAULT NULL,
  `3PM` DOUBLE NULL DEFAULT NULL,
  `3PA` DOUBLE NULL DEFAULT NULL,
  `3P%` DOUBLE NULL DEFAULT NULL,
  `FTM` DOUBLE NULL DEFAULT NULL,
  `FTA` DOUBLE NULL DEFAULT NULL,
  `FT%` DOUBLE NULL DEFAULT NULL,
  `TOV` DOUBLE NULL DEFAULT NULL,
  `PF` DOUBLE NULL DEFAULT NULL,
  `ORB` DOUBLE NULL DEFAULT NULL,
  `DRB` DOUBLE NULL DEFAULT NULL,
  `RPG` DOUBLE NULL DEFAULT NULL,
  `APG` DOUBLE NULL DEFAULT NULL,
  `SPG` DOUBLE NULL DEFAULT NULL,
  `BPG` DOUBLE NULL DEFAULT NULL,
  `PPG` DOUBLE NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
