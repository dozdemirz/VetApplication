package dev.patika.spring.Dto.response;

import lombok.*;

import java.time.LocalDate;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class VaccineResponse {

    private long animalId;
    private long vaccineId;
    private String vaccineName;
    private String vaccineCode;
    private LocalDate protectionStartDate;
    private LocalDate protectionFinishDate;

    private boolean isProtectionExpired;
}
