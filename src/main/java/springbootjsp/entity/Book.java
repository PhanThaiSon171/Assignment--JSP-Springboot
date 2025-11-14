package springbootjsp.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDate;

@Entity
@Table(name = "books")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Tên sách không được để trống")
    @Column(nullable = false)
    private String title;

    @NotBlank(message = "Tác giả không được để trống")
    @Column(nullable = false)
    private String author;

    @NotBlank(message = "Thể loại không được để trống")
    @Column(nullable = false)
    private String category;

    @NotBlank(message = "Nhà xuất bản không được để trống")
    @Column(nullable = false)
    private String publisher;

    @NotNull(message = "Năm xuất bản không được để trống")
    @Column(nullable = false)
    private Integer publishYear;

    @Column(columnDefinition = "TEXT")
    private String description;

    @NotNull(message = "Số lượng không được để trống")
    @Min(value = 0, message = "Số lượng phải >= 0")
    @Column(nullable = false)
    private Integer quantity;

    @NotNull(message = "Số lượng có sẵn không được để trống")
    @Min(value = 0, message = "Số lượng có sẵn phải >= 0")
    @Column(nullable = false)
    private Integer availableQuantity;

    @Column(name = "created_at")
    private LocalDate createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDate.now();
        if (availableQuantity == null) {
            availableQuantity = quantity;
        }
    }
}
