package dev.patika.spring.Repositories;

import dev.patika.spring.Entities.Animal;
import dev.patika.spring.Entities.Vaccine;
import org.springframework.data.domain.Example;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface VaccineRepo extends JpaRepository<Vaccine, Long> {

    boolean existsByAnimal_AnimalIdAndVaccineNameAndVaccineCode(Long animalId, String name, String code);

    //Bir hayvanda isim ve koda göre aşı var mı kontrolü
    @Query("SELECT vaccine " +
            "FROM Vaccine vaccine " +
            "WHERE vaccine.animal.animalId = :animalId " +
            "AND vaccine.vaccineName = :vaccineName " +
            "AND vaccine.vaccineCode = :vaccineCode")
    List<Vaccine> findByAnimalIdAndVaccineNameAndVaccineCode(
            @Param("animalId") long animalId,
            @Param("vaccineName") String vaccineName,
            @Param("vaccineCode") String vaccineCode
    );

    List<Vaccine> findByAnimal_AnimalId(Long animalId);

    //İki tarih arasında aşı süresi geçecek hayvanları bulmak için
    @Query("SELECT DISTINCT v.animal FROM Vaccine v WHERE v.protectionFinishDate BETWEEN :startDate AND :endDate")
    List<Animal> findAnimalsWithExpiringVaccines(
            @Param("startDate") LocalDate startDate,
            @Param("endDate") LocalDate endDate);
}
