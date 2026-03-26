package entity;

import java.util.Date;

public class Showtime {

    private int showtimeId;
    private int movieId;
    private int roomId;
    private Date startTime;
    private Date endTime;

    private String format;
    private String status;

    
    private String movieTitle;
    private String poster;

   
    private double priceStd;
    private double priceVip;
    private double priceCouple;

    public Showtime() {
    }

    public Showtime(int showtimeId, int movieId, int roomId,
                    Date startTime, Date endTime,
                    String format, String status) {
        this.showtimeId = showtimeId;
        this.movieId = movieId;
        this.roomId = roomId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.format = format;
        this.status = status;
    }

   

    public int getShowtimeId() {
        return showtimeId;
    }

    public void setShowtimeId(int showtimeId) {
        this.showtimeId = showtimeId;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

   

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }


    public double getPriceStd() {
        return priceStd;
    }

    public void setPriceStd(double priceStd) {
        this.priceStd = priceStd;
    }

    public double getPriceVip() {
        return priceVip;
    }

    public void setPriceVip(double priceVip) {
        this.priceVip = priceVip;
    }

    public double getPriceCouple() {
        return priceCouple;
    }

    public void setPriceCouple(double priceCouple) {
        this.priceCouple = priceCouple;
    }


private String cinemaName;

public String getCinemaName() {
    return cinemaName;
}

public void setCinemaName(String cinemaName) {
    this.cinemaName = cinemaName;
}
}