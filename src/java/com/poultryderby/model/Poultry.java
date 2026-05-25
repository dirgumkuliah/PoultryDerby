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

    protected int calculateIQTrainingEnergyGain() {
        int energyGainRange = GameConstants.IQ_TRAINING_MAX_ENERGY_GAIN - GameConstants.IQ_TRAINING_MIN_ENERGY_GAIN;
        return GameConstants.IQ_TRAINING_MIN_ENERGY_GAIN + (this.iq * energyGainRange / GameConstants.MAX_IQ);
    }

    public abstract String getPrimaryStatName();
    public abstract int getPrimaryStatValue();
}
