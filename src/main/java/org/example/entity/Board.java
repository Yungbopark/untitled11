package org.example.entity;

import lombok.Data;

@Data // Lombok API
public class Board {

    private int idx;
    private String memID;
    private String title;
    private String contents;
    private String writer;
    private String indate;
    private int count;
    // setter, getter



}
