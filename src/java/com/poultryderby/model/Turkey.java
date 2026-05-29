package com.poultryderby.model;

import com.poultryderby.util.GameConstants;

public class Turkey extends Poultry {
    public Turkey(String name, String rarity) {
        super(name, "Turkey", rarity);
    }

    @Override
    public void trainAttack() {
        boolean failed = checkFailure();
        int baseYield = GameConstants.BASE_TRAIN_STAT + this.iq;
        int change = calculateStatChange(baseYield, failed);
        setAttack(this.attack + change);
        setEnergy(this.energy - GameConstants.TRAINING_ENERGY_COST);
    }

    @Override
    public void trainSpeed() {
        boolean failed = checkFailure();
        int baseYield = GameConstants.BASE_TRAIN_STAT / 2 + this.iq;
        int change = calculateStatChange(baseYield, failed);
        setSpeed(this.speed + change);
        setEnergy(this.energy - GameConstants.TRAINING_ENERGY_COST);
    }

    @Override
    public void trainIQ() {
        boolean failed = checkFailure();
        int baseYield = GameConstants.BASE_TRAIN_IQ;
        int change = calculateStatChange(baseYield, failed);
        setIq(this.iq + change);
        setEnergy(this.energy + calculateIqEnergyGain());
    }

    @Override
    public boolean canTrainSpeed() {
        return false;
    }

    @Override
    public String getPrimaryStatName() { return "Attack"; }

    @Override
    public int getPrimaryStatValue() { return getAttack(); }
    
    @Override
    public int getExpectedAttackGain() {
        return GameConstants.BASE_TRAIN_STAT + this.iq;
    }

    @Override
    public int getExpectedSpeedGain() {
        return GameConstants.BASE_TRAIN_STAT / 2 + this.iq;
    }

    @Override
    public int getExpectedIqGain() {
        return GameConstants.BASE_TRAIN_IQ;
    }
}
