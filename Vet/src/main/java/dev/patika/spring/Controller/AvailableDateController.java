package dev.patika.spring.Controller;


import dev.patika.spring.Dto.request.AvailableDateRequest;
import dev.patika.spring.Entities.AvailableDate;
import dev.patika.spring.Entities.Doctor;
import dev.patika.spring.Repositories.AvailableDateRepo;
import dev.patika.spring.Repositories.DoctorRepo;
import dev.patika.spring.Service.AvailableDateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/available-date")
public class AvailableDateController {
    @Autowired
    private AvailableDateService availableDateService;
    @Autowired
    private AvailableDateRepo availableDateRepo;
    @Autowired
    private DoctorRepo doctorRepo;
    AvailableDate availableDate;


    @GetMapping("/{doctorId}")
    public ResponseEntity<List<AvailableDate>> getAvailableDatesByDoctorId(@PathVariable Long doctorId) {
        List<AvailableDate> availableDates = availableDateService.getAvailableDates(doctorId);
        return ResponseEntity.ok(availableDates);
    }

    @PostMapping("/save")
    public ResponseEntity<AvailableDate> save(@RequestBody AvailableDateRequest request) {
        AvailableDate availableDate = new AvailableDate();
        availableDate.setAvailableDate(request.getAvailableDate());

        Long doctorId = request.getDoctor().getDoctorId();
        Doctor doctor = doctorRepo.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Belirtilen id'ye sahip doktor bulunamadı: " + doctorId)); //Doktor yoksa diye kontrol
        availableDate.setDoctor(doctor);

        Doctor doctorDate = availableDate.getDoctor();
        LocalDate appointmentDate = availableDate.getAvailableDate();
        if (availableDateRepo.existsByDoctorAndAvailableDate(doctorDate, appointmentDate)) { //Aynı tarihte randevu varsa hata veriyoruz
            throw new RuntimeException("Bu tarih için zaten bir kayıt var.");
        }

        availableDateRepo.save(availableDate);
        return ResponseEntity.ok(availableDate);
    }

    //id'ye göre doktorun çalıştığı günleri silebilmek için
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> deleteAvailableDate(@PathVariable("id") long id) {
        try {
            Optional<AvailableDate> optionalAvailableDate = availableDateRepo.findById(id);

            if (optionalAvailableDate.isPresent()) {
                availableDateRepo.deleteById(id);
                return ResponseEntity.ok(id + " numaralı doktorun tarih silindi.");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Bu ID'de bir doktor çalışma tarih bulunamadı."); // Eğer müsait tarih bulunamazsa 404 hatası
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("ID'ye sahip müsait tarih silinemedi: " + id + ": " + e.getMessage());
        }
    }
}
