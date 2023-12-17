package dev.patika.spring.Service;

import dev.patika.spring.Dto.request.AppointmentRequest;
import dev.patika.spring.Entities.Animal;
import dev.patika.spring.Entities.Appointment;
import dev.patika.spring.Entities.Doctor;
import dev.patika.spring.Repositories.AnimalRepo;
import dev.patika.spring.Repositories.AppointmentRepo;
import dev.patika.spring.Repositories.AvailableDateRepo;
import dev.patika.spring.Repositories.DoctorRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class AppointmentService {
    private AppointmentRepo appointmentRepo;
    private DoctorRepo doctorRepository;
    private AvailableDateRepo availableDateRepo;
    private AnimalRepo animalRepo;


    @Autowired
    public AppointmentService(AppointmentRepo appointmentRepo, DoctorRepo doctorRepository, AvailableDateRepo availableDateRepo, AnimalRepo animalRepo) {
        this.appointmentRepo = appointmentRepo;
        this.doctorRepository = doctorRepository;
        this.availableDateRepo = availableDateRepo;
        this.animalRepo = animalRepo;
    }


    // Randevu oluşturma
    public Appointment createAppointment(AppointmentRequest appointmentRequest) {
        LocalDateTime requestedDateTime = appointmentRequest.getAppointmentDate();

        if (requestedDateTime.getMinute() != 0 || requestedDateTime.getSecond() != 0) {
            throw new RuntimeException("Sadece saat başı randevu alınabilir.");
        }

        Long doctorId = appointmentRequest.getDoctor().getDoctorId();
        Long animalId = appointmentRequest.getAnimal().getAnimalId();
        LocalDate appointmentDate = requestedDateTime.toLocalDate();
        if (!doctorRepository.existsById(doctorId)) {
            throw new RuntimeException("Böyle bir doktor bulunmamaktadır!");

        } else {
            if (appointmentRepo.existsByAppointmentDateAndDoctor_DoctorId(requestedDateTime, doctorId)) {
                throw new RuntimeException("Girilen tarihte başka bir randevu mevcuttur.");
            }

            if (!doctorRepository.isDoctorAvailableOnDate(doctorId, appointmentDate)) {
                throw new RuntimeException("Doktor bu tarihte çalışmamaktadır!");
            }

        }


        Appointment appointment = convertDtoToAppointment(appointmentRequest, animalId);
        appointment.setAppointmentDate(requestedDateTime); // Saat bilgisini atar

        return appointmentRepo.save(appointment);
    }

    private Appointment convertDtoToAppointment(AppointmentRequest appointmentRequest, Long animalId) {
        Appointment appointment = new Appointment();
        appointment.setAppointmentDate(appointmentRequest.getAppointmentDate());

        Long doctorId = appointmentRequest.getDoctor().getDoctorId();
        Doctor doctor = doctorRepository.findById(doctorId).orElseThrow(() -> new RuntimeException("Doktor bulunamadı."));
        appointment.setDoctor(doctor);


        Animal animal = animalRepo.findById(animalId).orElseThrow(() -> new RuntimeException("Hayvan bulunamadı."));
        appointment.setAnimal(animal);


        return appointment;
    }


    // Randevu bilgilerini güncelleme
    public Appointment updateAppointment(Appointment appointment) {
        try {
            // Güncelleme işlemi
            return appointmentRepo.save(appointment);
        } catch (DataIntegrityViolationException e) {
            // Veritabanı kısıtlaması hatası
            throw new RuntimeException("Güncelleme işlemi sırasında veritabanı kısıtlaması hatası oluştu.", e);
        }
    }


    // Randevu bilgilerini görüntüleme
    public Appointment getAppointment(Long appointmentId) {
        return appointmentRepo.findById(appointmentId).get();
    }

    // Randevuları tarih aralığına ve doktora göre filtreleme
    public List<Appointment> findAppointmentsByDateAndDoctor(LocalDate startDate, LocalDate endDate, Long doctorId) {
        LocalDateTime startDateTime = startDate.atStartOfDay();
        LocalDateTime endDateTime = endDate.atTime(23, 59, 59);

        return appointmentRepo.findByAppointmentDateBetweenAndDoctor_DoctorId(startDateTime, endDateTime, doctorId);
    }


    // Randevuları tarih aralığına ve hayvana göre filtreleme
    public List<Appointment> findAppointmentsByDateAndAnimal(LocalDate startDate, LocalDate endDate, Long animalId) {
        LocalDateTime startDateTime = startDate.atStartOfDay();
        LocalDateTime endDateTime = endDate.atTime(23, 59, 59);

        return appointmentRepo.findByAppointmentDateBetweenAndAnimalAnimalId(startDateTime, endDateTime, animalId);
    }

    public List<Appointment> findAllAppointments() {
        return appointmentRepo.findAll();
    }


}
