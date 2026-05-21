//nanda
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
    private Random random = new Random();

    public CareerManager(Poultry poultry) {
        this.poultry = poultry;
    }

    public void processTurn(String action) {
        if (careerOver) return;

        switch (action) {
            case "train_attack": poultry.trainAttack(); break;
            case "train_speed": poultry.trainSpeed(); break;
            case "train_iq": poultry.trainIQ(); break;
            case "rest": poultry.rest(); break;
            case "fight":
            case "race":
                handleStandardEncounter();
                break;
        }

        checkBossEncounter();
        currentTurn++;

        if (currentTurn > GameConstants.TOTAL_TURNS) {
            endCareer(true);
        }
    }

    private void handleStandardEncounter() {
        int enemyStat = currentTurn * 15; // Scaled enemy
        if (calculateWin(poultry.getPrimaryStatValue(), enemyStat)) {
            wins++;
        } else {
            losses++;
        }
    }

    private void checkBossEncounter() {
        if (currentTurn == GameConstants.YEAR_1_TURNS ||
            currentTurn == GameConstants.YEAR_1_TURNS + GameConstants.YEAR_2_TURNS ||
            currentTurn == GameConstants.TOTAL_TURNS) {

            int bossStat = (currentTurn == GameConstants.YEAR_1_TURNS) ? 300 :
                           (currentTurn == GameConstants.YEAR_1_TURNS + GameConstants.YEAR_2_TURNS) ? 750 : 1200;

            if (calculateWin(poultry.getPrimaryStatValue(), bossStat)) {
                bossWins++;
                if (currentTurn == GameConstants.TOTAL_TURNS) endCareer(true);
            } else {
                if (currentTurn == GameConstants.TOTAL_TURNS) endCareer(false);
            }
        }
    }

    private boolean calculateWin(int playerStat, int enemyStat) {
        if (playerStat >= enemyStat + 300) return true;
        if (playerStat <= enemyStat - 300) return false;

        double winProb = (double) playerStat / (playerStat + enemyStat);
        return random.nextDouble() < winProb;
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
}
