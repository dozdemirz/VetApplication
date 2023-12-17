package dev.patika.spring.Controller;


import dev.patika.spring.Dto.request.VaccineRequest;
import dev.patika.spring.Dto.response.VaccineResponse;
import dev.patika.spring.Entities.Animal;
import dev.patika.spring.Entities.Vaccine;
import dev.patika.spring.Repositories.VaccineRepo;
import dev.patika.spring.Service.VaccineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/vaccine")
public class VaccineController {

    private final VaccineService vaccineService;
    private final VaccineRepo vaccineRepo;

    @Autowired
    public VaccineController(VaccineService vaccineService, VaccineRepo vaccineRepo) {
        this.vaccineService = vaccineService;
        this.vaccineRepo = vaccineRepo;
    }

    @PostMapping("/save")
    public ResponseEntity<?> createVaccine(@RequestBody VaccineRequest vaccineRequest) {
        try {
            if (!vaccineService.isAnimalExist(vaccineRequest.getAnimalId())) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("Belirtilen id'de hayvan mevcut değil"); //Hayvan yoksa aşı da yapılamaz kontrolü
            }

            VaccineResponse response = vaccineService.saveVaccine(vaccineRequest);
            return new ResponseEntity<>(response, HttpStatus.CREATED);
        } catch (RuntimeException e) {
            System.out.println(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());

        }
    }

    @GetMapping("/{animalId}")
    public ResponseEntity<List<Vaccine>> getVaccinesByAnimalId(@PathVariable Long animalId) {
        List<Vaccine> vaccines = vaccineService.getVaccinesByAnimalId(animalId);
        return ResponseEntity.ok(vaccines);
    }

    //Burası başlangıç ve bitiş tarihleri alarak o tarihler arasında aşısı bitecek olan hayvanları getiriyor
    @GetMapping("/expiring")
    public ResponseEntity<List<Animal>> getAnimalsWithExpiringVaccines(
            @RequestParam("startDate") LocalDate startDate,
            @RequestParam("endDate") LocalDate endDate) {
        List<Animal> animals = vaccineService.getAnimalsWithExpiringVaccines(startDate, endDate);
        return ResponseEntity.ok(animals);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> deleteVaccine(@PathVariable("id") long id) {
        try {
            Optional<Vaccine> optionalVaccine = vaccineRepo.findById(id);

            if (optionalVaccine.isPresent()) {
                vaccineRepo.deleteById(id);
                return ResponseEntity.ok(id + " numaralı aşı silindi.");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Bu ID'de bir aşı bulunamadı."); // Eğer aşı bulunamazsa 404 hatası
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("ID'ye sahip aşı silinemedi: " + id + ": " + e.getMessage());
        }
    }

}
