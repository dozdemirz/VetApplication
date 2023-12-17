package dev.patika.spring.Controller;


import dev.patika.spring.Dto.request.AnimalRequest;
import dev.patika.spring.Entities.Animal;
import dev.patika.spring.Entities.Customer;
import dev.patika.spring.Repositories.AnimalRepo;
import dev.patika.spring.Repositories.CustomerRepo;
import dev.patika.spring.Service.AnimalService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/animal")
public class AnimalController {
    private final AnimalRepo animalRepo;
    private final AnimalService animalService;
    private final CustomerRepo customerRepo;

    public AnimalController(AnimalRepo animalRepo, AnimalService animalService, CustomerRepo customerRepo) {
        this.animalRepo = animalRepo;
        this.animalService = animalService;
        this.customerRepo = customerRepo;
    }

    //Hayvan id'sine göre hayvanı çekme
    @GetMapping("/{id}")
    public Animal findbyId(@PathVariable("id") long id){
        return this.animalRepo.findById(id).orElseThrow();
    }

    @PostMapping("/save")
    public ResponseEntity<?> saveAnimal(@RequestBody AnimalRequest animalRequest) {
        try {
            // Eğer gelen istekte id değeri yoksa yeni bir hayvan kaydedilir
            if (animalRequest.getAnimalId() == null) {
                Animal savedAnimal = animalService.saveAnimal(animalRequest);
                return ResponseEntity.ok(savedAnimal);
            } else { // Eğer id değeri varsa, id'ye göre hayvan güncellenir
                Optional<Animal> optionalAnimal = animalRepo.findById(animalRequest.getAnimalId());
                if (optionalAnimal.isPresent()) {
                    Animal existingAnimal = getAnimal(animalRequest, optionalAnimal);
                    Animal updatedAnimal = animalRepo.save(existingAnimal);
                    return ResponseEntity.ok(updatedAnimal);
                } else {
                    return ResponseEntity.notFound().build(); // Eğer id'ye sahip bir hayvan bulunamazsa 404 hatası döndürülür
                }
            }
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    //Hayvan güncellemek için
    private static Animal getAnimal(AnimalRequest animalRequest, Optional<Animal> optionalAnimal) {
        Animal existingAnimal = optionalAnimal.get();
        // Yeni bilgilerle var olan hayvanın bilgileri güncellenir
        existingAnimal.setAnimalName(animalRequest.getAnimalName());
        existingAnimal.setSpecies(animalRequest.getAnimalSpecies());
        existingAnimal.setBreed(animalRequest.getAnimalBreed());
        existingAnimal.setGender(animalRequest.getAnimalGender());
        existingAnimal.setColor(animalRequest.getAnimalColor());
        existingAnimal.setBirthDate(animalRequest.getDateOfBirth());
        return existingAnimal;
    }

    //Tüm hayvanları getirmek için
    @GetMapping("/find-all")
    public List<Animal> findAll(){
        return this.animalRepo.findAll();
    }

    @GetMapping("/name/{name}")
    public List<Animal> findByAnimalName(@PathVariable("name") String name) {
        return this.animalRepo.findByAnimalNameIgnoreCase(name);
    }

    //id'ye göre animal silmek için
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> deleteAnimal(@PathVariable("id") long id) {
        try {
            Optional<Animal> optionalAnimal = animalRepo.findById(id);

            if (optionalAnimal.isPresent()) {
                animalRepo.deleteById(id);
                return ResponseEntity.ok( id + " numaralı hayvan silindi.");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Bu id'de bir hayvan yok"); // Eğer hayvan bulunamazsa 404 hatası
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Id'ye sahip hayvan silinemedi: " + id + ": " + e.getMessage());
        }
    }
}
