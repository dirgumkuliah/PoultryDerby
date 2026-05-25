package com.poultryderby.model;

import com.poultryderby.util.GameConstants;
import java.util.Random;

public abstract class Poultry implements Trainable {
    protected String name;
    protected String species;
    protected String rarity;
    protected int attack;
    protected int speed;
    protected int iq;
    protected int energy;
    protected Random random = new Random();

    public Poultry(String name, String species, String rarity) {
        this.name = name;
        this.species = species;
        this.rarity = rarity;
        this.attack = 0;
        this.speed = 0;
        this.iq = 0;
        this.energy = GameConstants.MAX_ENERGY;
    }

    // Getters
    public String getName() { return name; }
    public String getSpecies() { return species; }
    public String getRarity() { return rarity; }
    public int getAttack() { return attack; }
    public int getSpeed() { return speed; }
    public int getIq() { return iq; }
    public int getEnergy() { return energy; }

    // Setters with limits
    public void setAttack(int attack) { this.attack = Math.max(0, Math.min(attack, GameConstants.MAX_ATTACK)); }
    public void setSpeed(int speed) { this.speed = Math.max(0, Math.min(speed, GameConstants.MAX_SPEED)); }
    public void setIq(int iq) { this.iq = Math.max(0, Math.min(iq, GameConstants.MAX_IQ)); }
    public void setEnergy(int energy) { this.energy = Math.max(0, Math.min(energy, GameConstants.MAX_ENERGY)); }

    @Override
    public void rest() {
        setEnergy(getEnergy() + GameConstants.ENERGY_RESTORE);
    }

    protected boolean checkFailure() {
        if (energy >= 50) return false;
        
        // Scaling failure rate: 50 energy -> 0%, 0 energy -> 99%
        double failureRate = (50.0 - energy) / 50.0 * 0.99;
        return random.nextDouble() < failureRate;
    }

    protected int calculateStatChange(int baseYield, boolean isFailed) {
        if (!isFailed) {
            return baseYield;
        } else {
            // 80% chance no increase (0), 20% chance decrease (-baseYield/2)
            if (random.nextDouble() < 0.80) {
                return 0;
            } else {
                return -(baseYield / 2);
            }
        }
    }

    protected int calculateIqEnergyGain() {
        int currentIq = getIq();

        if (currentIq <= 10) {
            return interpolateIqEnergyGain(currentIq, 0, 10, GameConstants.MIN_IQ_ENERGY_GAIN, 7);
        }
        if (currentIq <= 25) {
            return interpolateIqEnergyGain(currentIq, 10, 25, 7, 11);
        }
        return interpolateIqEnergyGain(currentIq, 25, GameConstants.MAX_IQ, 11, GameConstants.MAX_IQ_ENERGY_GAIN);
    }

    private int interpolateIqEnergyGain(int currentIq, int minIq, int maxIq, int minGain, int maxGain) {
        double iqRatio = (double) (currentIq - minIq) / (maxIq - minIq);
        return minGain + (int) Math.round((maxGain - minGain) * iqRatio);
    }

    public abstract String getPrimaryStatName();
    public abstract int getPrimaryStatValue();
    
    public abstract int getExpectedAttackGain();
    public abstract int getExpectedSpeedGain();
    public abstract int getExpectedIqGain();
}
