package com.poultryderby.model;

import com.poultryderby.util.GameConstants;

public class Pheasant extends Poultry {
    public Pheasant(String name, String rarity) {
        super(name, "Pheasant", rarity);
    }

    @Override
    public void trainAttack() {
        boolean failed = checkFailure();
        int baseYield = GameConstants.BASE_TRAIN_STAT / 2 + this.iq;
        int change = calculateStatChange(baseYield, failed);
        setAttack(this.attack + change);
        setEnergy(this.energy - GameConstants.TRAINING_ENERGY_COST);
    }

    @Override
    public void trainSpeed() {
        boolean failed = checkFailure();
        int baseYield = GameConstants.BASE_TRAIN_STAT + this.iq;
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
    public String getPrimaryStatName() { return "Speed"; }

    @Override
    public int getPrimaryStatValue() { return getSpeed(); }
    
    @Override
    public int getExpectedAttackGain() {
        return GameConstants.BASE_TRAIN_STAT / 2 + this.iq;
    }

    @Override
    public int getExpectedSpeedGain() {
        return GameConstants.BASE_TRAIN_STAT + this.iq;
    }

    @Override
    public int getExpectedIqGain() {
        return GameConstants.BASE_TRAIN_IQ;
    }
}
