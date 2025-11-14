package springbootjsp.service;

import springbootjsp.entity.BorrowRecord;
import springbootjsp.entity.BorrowRecord.BorrowStatus;
import springbootjsp.repository.BorrowRecordRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class BorrowRecordService {
    
    @Autowired
    private BorrowRecordRepository borrowRecordRepository;
    
    @Autowired
    private BookService bookService;
    
    public List<BorrowRecord> getAllRecords() {
        return borrowRecordRepository.findAll();
    }
    
    @SuppressWarnings("null")
    public Optional<BorrowRecord> getRecordById(Long id) {
        return borrowRecordRepository.findById(id);
    }
    
    public BorrowRecord createBorrowRecord(BorrowRecord record) {
        if (bookService.decreaseAvailableQuantity(record.getBook().getId())) {
            return borrowRecordRepository.save(record);
        }
        throw new RuntimeException("Sách không còn sẵn để mượn");
    }
    
    @SuppressWarnings("null")
    public BorrowRecord returnBook(Long recordId) {
        Optional<BorrowRecord> recordOpt = borrowRecordRepository.findById(recordId);
        if (recordOpt.isPresent()) {
            BorrowRecord record = recordOpt.get();
            record.setReturnDate(LocalDate.now());
            record.setStatus(BorrowStatus.RETURNED);
            bookService.increaseAvailableQuantity(record.getBook().getId());
            return borrowRecordRepository.save(record);
        }
        throw new RuntimeException("Không tìm thấy bản ghi mượn sách");
    }
    
    public List<BorrowRecord> getBorrowedRecords() {
        return borrowRecordRepository.findByStatus(BorrowStatus.BORROWED);
    }
    
    public List<BorrowRecord> getReturnedRecords() {
        return borrowRecordRepository.findByStatus(BorrowStatus.RETURNED);
    }
    
    public List<BorrowRecord> getOverdueRecords() {
        return borrowRecordRepository.findOverdueRecords(LocalDate.now());
    }
    
    public List<BorrowRecord> getRecordsByReader(Long readerId) {
        return borrowRecordRepository.findByReader_Id(readerId);
    }
    
    public long getTotalBorrowed() {
        return borrowRecordRepository.countBorrowedBooks();
    }
    
    public long getTotalOverdue() {
        return borrowRecordRepository.countOverdueBooks(LocalDate.now());
    }
    
    public void updateOverdueStatus() {
        List<BorrowRecord> overdueRecords = borrowRecordRepository.findOverdueRecords(LocalDate.now());
        for (BorrowRecord record : overdueRecords) {
            if (record.getStatus() == BorrowStatus.BORROWED) {
                record.setStatus(BorrowStatus.OVERDUE);
                borrowRecordRepository.save(record);
            }
        }
    }
}
