/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

public class Movie {
    private int movieId;
    private String title;
    private String poster;
    private String description;
    private int duration;
    private String genre;
    private String language;
    private String director;
    private String castList;
    private Date releaseDate;
    private Date endDate;
    private double rating;
    private String ageLimit;
    private String status;
    private Date createdAt;
  
    
    
    // getter setter

    public Movie() {
    }

    public Movie(int movieId, String title, String poster, String description, int duration, String genre, String language, String director, String castList, Date releaseDate, Date endDate, double rating, String ageLimit, String status, Date createdAt) {
        this.movieId = movieId;
        this.title = title;
        this.poster = poster;
        this.description = description;
        this.duration = duration;
        this.genre = genre;
        this.language = language;
        this.director = director;
        this.castList = castList;
        this.releaseDate = releaseDate;
        this.endDate = endDate;
        this.rating = rating;
        this.ageLimit = ageLimit;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getCastList() {
        return castList;
    }

    public void setCastList(String castList) {
        this.castList = castList;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getAgeLimit() {
        return ageLimit;
    }

    public void setAgeLimit(String ageLimit) {
        this.ageLimit = ageLimit;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
}
