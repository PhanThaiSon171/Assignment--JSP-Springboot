package springbootjsp.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDate;

@Entity
@Table(name = "borrow_records")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BorrowRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "book_id", nullable = false)
    private Book book;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "reader_id", nullable = false)
    private Reader reader;

    @NotNull(message = "Ngày mượn không được để trống")
    @Column(name = "borrow_date", nullable = false)
    private LocalDate borrowDate;

    @NotNull(message = "Ngày hạn trả không được để trống")
    @Column(name = "due_date", nullable = false)
    private LocalDate dueDate;

    @Column(name = "return_date")
    private LocalDate returnDate;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private BorrowStatus status;

    @Column(columnDefinition = "TEXT")
    private String notes;

    public enum BorrowStatus {
        BORROWED,
        RETURNED,
        OVERDUE
    }

    @PrePersist
    protected void onCreate() {
        if (borrowDate == null) {
            borrowDate = LocalDate.now();
        }
        if (dueDate == null) {
            dueDate = borrowDate.plusDays(14);
        }
        if (status == null) {
            status = BorrowStatus.BORROWED;
        }
    }

    public boolean isOverdue() {
        if (returnDate != null) {
            return false;
        }
        return LocalDate.now().isAfter(dueDate);
    }
}
