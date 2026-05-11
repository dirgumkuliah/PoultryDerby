package com.poultryderby.model;

import com.poultryderby.util.GameConstants;
import java.util.Random;

public class GachaSystem {
    private Random random = new Random();

    public Poultry pull() {
        double roll = random.nextDouble();
        String rarity;
        
        if (roll < GameConstants.RATE_HACK) {
            rarity = "Hack";
        } else if (roll < GameConstants.RATE_HACK + GameConstants.RATE_SECRET) {
            rarity = "Secret";
        } else if (roll < GameConstants.RATE_HACK + GameConstants.RATE_SECRET + GameConstants.RATE_LEGEND) {
            rarity = "Legend";
        } else if (roll < GameConstants.RATE_HACK + GameConstants.RATE_SECRET + GameConstants.RATE_LEGEND + GameConstants.RATE_RARE) {
            rarity = "Rare";
        } else {
            rarity = "Common";
        }

        // Randomly pick a species that has this rarity
        int speciesRoll = random.nextInt(3);
        String species = speciesRoll == 0 ? "Turkey" : (speciesRoll == 1 ? "Pheasant" : "Duck");
        
        String name = getNameForSpeciesAndRarity(species, rarity);
        
        // If a species doesn't have a certain rarity (like Duck Common), default to another species
        if (name == null) {
            species = speciesRoll == 0 ? "Pheasant" : "Turkey"; // Swap if Duck failed
            name = getNameForSpeciesAndRarity(species, rarity);
        }

        if ("Turkey".equals(species)) return new Turkey(name, rarity);
        if ("Pheasant".equals(species)) return new Pheasant(name, rarity);
        return new Duck(name, rarity);
    }

    private String getNameForSpeciesAndRarity(String species, String rarity) {
        if ("Turkey".equals(species)) {
            switch (rarity) {
                case "Common": return "Black Turkey";
                case "Rare": return "Kile Turkey";
                case "Legend": return "Bourbon Red Turkey";
                case "Secret": return "Bronze Turkey";
                case "Hack": return "Silver Auburn Turkey";
                default: return "Midget White Turkey";
            }
        } else if ("Pheasant".equals(species)) {
            switch (rarity) {
                case "Common": return "Ring-Necked Pheasant";
                case "Rare": return "Mikado Pheasant";
                case "Legend": return "Himalayan Moral Pheasant";
                case "Secret": return "Crested Argus Pheasant";
                case "Hack": return "Bornean Peacock Pheasant";
                default: return null;
            }
        } else if ("Duck".equals(species)) {
            switch (rarity) {
                case "Legend": return "Madagascar Pochard Duck";
                case "Secret": return "Mergus Serrator Duck";
                case "Hack": return "Donald Duck";
                default: return null; // No Common/Rare ducks listed in prompt
            }
        }
        return null;
    }

    public int getDuplicateValue(String rarity) {
        switch (rarity) {
            case "Common": return GameConstants.DUPE_COMMON;
            case "Rare": return GameConstants.DUPE_RARE;
            case "Legend": return GameConstants.DUPE_LEGEND;
            case "Secret": return GameConstants.DUPE_SECRET;
            case "Hack": return GameConstants.DUPE_HACK;
            default: return 0;
        }
    }
}
