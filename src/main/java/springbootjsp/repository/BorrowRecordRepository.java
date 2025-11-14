package springbootjsp.repository;

import springbootjsp.entity.BorrowRecord;
import springbootjsp.entity.BorrowRecord.BorrowStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface BorrowRecordRepository extends JpaRepository<BorrowRecord, Long> {
    List<BorrowRecord> findByStatus(BorrowStatus status);
    List<BorrowRecord> findByReader_Id(Long readerId);
    List<BorrowRecord> findByBook_Id(Long bookId);
    
    @Query("SELECT br FROM BorrowRecord br WHERE br.status = 'BORROWED' AND br.dueDate < :today")
    List<BorrowRecord> findOverdueRecords(@org.springframework.data.repository.query.Param("today") LocalDate today);
    
    @Query("SELECT COUNT(br) FROM BorrowRecord br WHERE br.status = 'BORROWED'")
    long countBorrowedBooks();
    
    @Query("SELECT COUNT(br) FROM BorrowRecord br WHERE br.status = 'BORROWED' AND br.dueDate < :today")
    long countOverdueBooks(@org.springframework.data.repository.query.Param("today") LocalDate today);
}
