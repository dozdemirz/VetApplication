package dev.patika.spring.Service;

import dev.patika.spring.Dto.request.VaccineRequest;
import dev.patika.spring.Dto.response.VaccineResponse;
import dev.patika.spring.Entities.Animal;
import dev.patika.spring.Entities.Vaccine;
import dev.patika.spring.Repositories.AnimalRepo;
import dev.patika.spring.Repositories.VaccineRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class VaccineService {
    private final VaccineRepo vaccineRepository;
    private final AnimalRepo animalRepo;

    @Autowired
    public VaccineService(VaccineRepo vaccineRepository, AnimalRepo animalRepo) {
        this.vaccineRepository = vaccineRepository;
        this.animalRepo = animalRepo;
    }

    //Aşı ekleme
    public VaccineResponse saveVaccine(VaccineRequest vaccineRequest) {
        Vaccine vaccine = new Vaccine();
        vaccine.setVaccineName(vaccineRequest.getVaccineName());
        vaccine.setVaccineCode(vaccineRequest.getVaccineCode());
        vaccine.setProtectionStartDate(vaccineRequest.getProtectionStartDate());
        vaccine.setProtectionFinishDate(vaccineRequest.getProtectionFinishDate());
        vaccine.setAnimal(animalRepo.findById(vaccineRequest.getAnimalId()).orElse(null));

        List<Vaccine> vaccines = vaccineRepository.findByAnimalIdAndVaccineNameAndVaccineCode(
                vaccine.getAnimal().getAnimalId(),
                vaccine.getVaccineName(),
                vaccine.getVaccineCode()
        );


        //Tekrar eklemeyi önlemek için
        if (!vaccines.isEmpty()) {
            throw new RuntimeException("Aynı tarihlerde aynı hayvana aynı aşıyı tekrar ekleyemezsiniz.");
        }

        // Koruma bitiş tarihinin koruma başlangıç tarihinden önce olmadığını kontrol etme
        if (vaccine.getProtectionFinishDate().isBefore(vaccine.getProtectionStartDate())) {
            throw new RuntimeException("Koruma bitiş tarihi koruma başlangıç tarihinden önce olamaz.");
        }

        vaccineRepository.save(vaccine);

        VaccineResponse vaccineResponse = new VaccineResponse();
        vaccineResponse.setVaccineId(vaccine.getVaccineId());
        vaccineResponse.setVaccineName(vaccine.getVaccineName());
        vaccineResponse.setVaccineCode(vaccine.getVaccineCode());
        vaccineResponse.setProtectionStartDate(vaccine.getProtectionStartDate());
        vaccineResponse.setProtectionFinishDate(vaccine.getProtectionFinishDate());
        vaccineResponse.setAnimalId(vaccine.getAnimal().getAnimalId());

        return vaccineResponse;
    }

    public List<Vaccine> getVaccinesByAnimalId(Long animalId) {
        return vaccineRepository.findByAnimal_AnimalId(animalId);
    }

    public List<Animal> getAnimalsWithExpiringVaccines(LocalDate startDate, LocalDate endDate) {
        return vaccineRepository.findAnimalsWithExpiringVaccines(startDate, endDate);
    }

    public boolean isAnimalExist(Long animalId) {
        return animalRepo.existsById(animalId);
    }


}
