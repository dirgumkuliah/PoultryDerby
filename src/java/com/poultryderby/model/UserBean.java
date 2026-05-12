package com.poultryderby.model;

import java.io.Serializable;

public class UserBean implements Serializable {
    private int id;
    private String username;
    private int gachaCurrency;
    private int shopCurrency;
    private String password;
    
    public UserBean() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public int getGachaCurrency() { return gachaCurrency; }
    public void setGachaCurrency(int gachaCurrency) { this.gachaCurrency = gachaCurrency; }

    public int getShopCurrency() { return shopCurrency; }
    public void setShopCurrency(int shopCurrency) { this.shopCurrency = shopCurrency; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
