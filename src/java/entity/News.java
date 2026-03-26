package entity;

import java.util.Date;

public class News {

    private int newsId;
    private String title;
    private String content;
    private String image;
    private String type;       
    private Date createdAt;

    public News() {
    }

    public News(int newsId, String title, String content,
                String image, String type, Date createdAt) {
        this.newsId = newsId;
        this.title = title;
        this.content = content;
        this.image = image;
        this.type = type;
        this.createdAt = createdAt;
    }

    // ===== GET SET =====

    public int getNewsId() {
        return newsId;
    }

    public void setNewsId(int newsId) {
        this.newsId = newsId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getType() {   
        return type;
    }

    public void setType(String type) { 
        this.type = type;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}