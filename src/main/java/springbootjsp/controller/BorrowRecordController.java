package springbootjsp.controller;

import springbootjsp.entity.Book;
import springbootjsp.entity.BorrowRecord;
import springbootjsp.entity.Reader;
import springbootjsp.service.BookService;
import springbootjsp.service.BorrowRecordService;
import springbootjsp.service.ReaderService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/borrows")
public class BorrowRecordController {
    
    private final BorrowRecordService borrowRecordService;
    
    private final BookService bookService;
    
    private final ReaderService readerService;
    
    @GetMapping
    public String listBorrowRecords(@RequestParam(required = false) String status, Model model) {
        borrowRecordService.updateOverdueStatus();
        
        List<BorrowRecord> records;
        if ("borrowed".equals(status)) {
            records = borrowRecordService.getBorrowedRecords();
        } else if ("returned".equals(status)) {
            records = borrowRecordService.getReturnedRecords();
        } else if ("overdue".equals(status)) {
            records = borrowRecordService.getOverdueRecords();
        } else {
            records = borrowRecordService.getAllRecords();
        }
        
        model.addAttribute("records", records);
        model.addAttribute("status", status);
        return "borrows/list";
    }
    
    @GetMapping("/add")
    public String showAddForm(Model model) {
        List<Book> availableBooks = bookService.getAllBooks().stream()
                .filter(book -> book.getAvailableQuantity() > 0)
                .toList();
        List<Reader> readers = readerService.getAllReaders();
        
        model.addAttribute("record", new BorrowRecord());
        model.addAttribute("books", availableBooks);
        model.addAttribute("readers", readers);
        return "borrows/form";
    }
    
    @PostMapping("/add")
    public String addBorrowRecord(@RequestParam Long bookId,
                                 @RequestParam Long readerId,
                                 @RequestParam(required = false) Integer daysToReturn,
                                 @RequestParam(required = false) String notes,
                                 RedirectAttributes redirectAttributes) {
        try {
            Book book = bookService.getBookById(bookId).orElseThrow();
            Reader reader = readerService.getReaderById(readerId).orElseThrow();
            
            BorrowRecord record = new BorrowRecord();
            record.setBook(book);
            record.setReader(reader);
            record.setBorrowDate(LocalDate.now());
            
            int days = (daysToReturn != null && daysToReturn > 0) ? daysToReturn : 14;
            record.setDueDate(LocalDate.now().plusDays(days));
            record.setNotes(notes);
            
            borrowRecordService.createBorrowRecord(record);
            redirectAttributes.addFlashAttribute("successMessage", "Tạo phiếu mượn thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        return "redirect:/borrows";
    }
    
    @GetMapping("/return/{id}")
    public String returnBook(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            borrowRecordService.returnBook(id);
            redirectAttributes.addFlashAttribute("successMessage", "Trả sách thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        return "redirect:/borrows";
    }
}
