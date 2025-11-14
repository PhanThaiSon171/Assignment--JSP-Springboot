package springbootjsp.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDate;

@Entity
@Table(name = "readers")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reader {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Họ tên không được để trống")
    @Column(nullable = false)
    private String fullName;

    @Email(message = "Email không hợp lệ")
    @Column(unique = true)
    private String email;

    @Pattern(regexp = "^\\d{10,11}$", message = "Số điện thoại không hợp lệ")
    @Column(unique = true)
    private String phone;

    @Column(columnDefinition = "TEXT")
    private String address;

    @Column(name = "registration_date")
    private LocalDate registrationDate;

    @PrePersist
    protected void onCreate() {
        registrationDate = LocalDate.now();
    }
}
