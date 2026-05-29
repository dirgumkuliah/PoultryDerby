package com.poultryderby.model;

import com.poultryderby.util.GameConstants;
import java.util.Random;

public class CareerManager {
    private Poultry poultry;
    private int currentTurn = 1;
    private int wins = 0;
    private int losses = 0;
    private int bossWins = 0;
    private boolean careerOver = false;
    private String outcome = "Ongoing";
    private int lastCompetitionTurn = -10; // Start with no cooldown
    private Random random = new Random();

    public CareerManager(Poultry poultry) {
        this.poultry = poultry;
    }

    public void processTurn(String action) {
        if (careerOver) return;

        boolean turnAdvanced = false;

        if (isBossTurn()) {
            if ("fight".equals(action)) {
                // No energy requirement for boss fights
                handleCompetition(true);
                turnAdvanced = true;
            } else if ("rest".equals(action)) {
                poultry.rest();
                // turnAdvanced remains false to stay on the boss turn
            }
        } else {
            switch (action) {
                case "train_attack":
                    if (poultry.canTrainAttack()) {
                        poultry.trainAttack();
                        turnAdvanced = true;
                    }
                    break;
                case "train_speed":
                    if (poultry.canTrainSpeed()) {
                        poultry.trainSpeed();
                        turnAdvanced = true;
                    }
                    break;
                case "train_iq":
                    if (poultry.canTrainIQ()) {
                        poultry.trainIQ();
                        turnAdvanced = true;
                    }
                    break;
                case "rest":
                    poultry.rest();
                    turnAdvanced = true;
                    break;
                case "fight":
                case "race":
                    if (canCompete() && poultry.getEnergy() >= GameConstants.COMPETITION_ENERGY_COST) {
                        handleCompetition(false);
                        lastCompetitionTurn = currentTurn;
                        turnAdvanced = true;
                    }
                    break;
            }
        }

        if (turnAdvanced && !careerOver) {
            currentTurn++;
        }

        if (currentTurn > GameConstants.TOTAL_TURNS && !careerOver) {
            endCareer(true);
        }
    }

    private void handleCompetition(boolean isBoss) {
        int playerStat = getCompetitionStat();
        int enemyStat = getEnemyStat(isBoss);

        if (calculateWin(playerStat, enemyStat)) {
            if (isBoss) {
                bossWins++;
                applyReward(true);
            } else {
                wins++;
                applyReward(false);
            }
        } else {
            losses++;
            if (isBoss && currentTurn == GameConstants.TOTAL_TURNS) {
                endCareer(false);
            }
        }

        // Energy drain
        poultry.setEnergy(poultry.getEnergy() - GameConstants.COMPETITION_ENERGY_COST);

        // Final boss win at Turn 60
        if (isBoss && currentTurn == GameConstants.TOTAL_TURNS && !careerOver) {
            endCareer(true);
        }
    }

    private int getCompetitionStat() {
        if ("Turkey".equals(poultry.getSpecies())) {
            return poultry.getAttack();
        } else if ("Pheasant".equals(poultry.getSpecies())) {
            return poultry.getSpeed();
        } else if ("Duck".equals(poultry.getSpecies())) {
            // Duck coin toss: 50% Attack, 50% Speed
            return random.nextBoolean() ? poultry.getAttack() : poultry.getSpeed();
        }
        return poultry.getPrimaryStatValue();
    }

    private int getEnemyStat(boolean isBoss) {
        int year = getYear();
        if (isBoss) {
            return (year == 1) ? GameConstants.BOSS_STAT_Y1 :
                   (year == 2) ? GameConstants.BOSS_STAT_Y2 : GameConstants.BOSS_STAT_Y3;
        } else {
            return (year == 1) ? GameConstants.ENEMY_STAT_Y1 :
                   (year == 2) ? GameConstants.ENEMY_STAT_Y2 : GameConstants.ENEMY_STAT_Y3;
        }
    }

    private void applyReward(boolean isBoss) {
        int year = getYear();
        int reward;
        if (isBoss) {
            reward = (year == 1) ? GameConstants.REWARD_BOSS_Y1 :
                     (year == 2) ? GameConstants.REWARD_BOSS_Y2 : GameConstants.REWARD_BOSS_Y3;
        } else {
            reward = (year == 1) ? GameConstants.REWARD_NORMAL_Y1 :
                     (year == 2) ? GameConstants.REWARD_NORMAL_Y2 : GameConstants.REWARD_NORMAL_Y3;
        }
        poultry.setAttack(poultry.getAttack() + reward);
        poultry.setSpeed(poultry.getSpeed() + reward);
    }

    private boolean calculateWin(int playerStat, int enemyStat) {
        int diff = playerStat - enemyStat;
        if (diff >= 300) return true;
        if (diff <= -300) return false;

        double winProb = 0.5 + (diff / 600.0);
        return random.nextDouble() < winProb;
    }

    public boolean isBossTurn() {
        return currentTurn == GameConstants.YEAR_1_TURNS ||
               currentTurn == GameConstants.YEAR_1_TURNS + GameConstants.YEAR_2_TURNS ||
               currentTurn == GameConstants.TOTAL_TURNS;
    }

    private void endCareer(boolean wonFinalBoss) {
        careerOver = true;
        outcome = wonFinalBoss ? "Win" : "Loss";
    }

    // Getters
    public Poultry getPoultry() { return poultry; }
    public int getCurrentTurn() { return currentTurn; }
    public int getWins() { return wins; }
    public int getLosses() { return losses; }
    public int getBossWins() { return bossWins; }
    public boolean isCareerOver() { return careerOver; }
    public String getOutcome() { return outcome; }

    public int getYear() {
        if (currentTurn <= GameConstants.YEAR_1_TURNS) return 1;
        if (currentTurn <= GameConstants.YEAR_1_TURNS + GameConstants.YEAR_2_TURNS) return 2;
        return 3;
    }
    public int getYearTurn(){
        if (currentTurn <= GameConstants.YEAR_1_TURNS){
            return currentTurn;
        }else if (currentTurn <= GameConstants.YEAR_1_TURNS + GameConstants.YEAR_2_TURNS){
            return currentTurn - GameConstants.YEAR_1_TURNS;
        }else{
            return currentTurn - (GameConstants.YEAR_1_TURNS + GameConstants.YEAR_2_TURNS);
        }
    }

    public boolean canCompete() {
        return currentTurn - lastCompetitionTurn > 6;
    }

    public int getCompetitionCooldown() {
        int diff = currentTurn - lastCompetitionTurn;
        return Math.max(0, 7 - diff);
    }

    public int getMaxYear(){
        if (currentTurn <= GameConstants.YEAR_1_TURNS){
            return GameConstants.YEAR_1_TURNS;
        }else if (currentTurn <= GameConstants.YEAR_1_TURNS + GameConstants.YEAR_2_TURNS){
            return GameConstants.YEAR_2_TURNS;
        }else{
            return GameConstants.YEAR_3_TURNS;
        }
    }
}
