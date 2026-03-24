/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

public class Seat {
    private int seatId;
    private int roomId;
    private String rowLabel;
    private int colNum;
    private String seatType;
    private boolean isActive;

    
    // getter setter

    public Seat() {
    }

    public Seat(int seatId, int roomId, String rowLabel, int colNum, String seatType, boolean isActive) {
        this.seatId = seatId;
        this.roomId = roomId;
        this.rowLabel = rowLabel;
        this.colNum = colNum;
        this.seatType = seatType;
        this.isActive = isActive;
    }

    public int getSeatId() {
        return seatId;
    }

    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRowLabel() {
        return rowLabel;
    }

    public void setRowLabel(String rowLabel) {
        this.rowLabel = rowLabel;
    }

    public int getColNum() {
        return colNum;
    }

    public void setColNum(int colNum) {
        this.colNum = colNum;
    }

    public String getSeatType() {
        return seatType;
    }

    public void setSeatType(String seatType) {
        this.seatType = seatType;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }
    
}
