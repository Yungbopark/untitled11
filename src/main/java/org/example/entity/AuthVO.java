package org.example.entity;

import lombok.Data;

@Data
public class AuthVO {
    private int no;
    private String memID;
    private String auth; // 권한 (3가지로 부여)
}
