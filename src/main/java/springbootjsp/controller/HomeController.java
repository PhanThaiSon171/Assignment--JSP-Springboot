package springbootjsp.controller;

import springbootjsp.service.BookService;
import springbootjsp.service.BorrowRecordService;
import springbootjsp.service.ReaderService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HomeController {
    
    private final BookService bookService;
    
    private final ReaderService readerService;
    
    private final BorrowRecordService borrowRecordService;
    
    @GetMapping("/")
    public String home(Model model) {
        borrowRecordService.updateOverdueStatus();
        
        model.addAttribute("totalBooks", bookService.getTotalBooks());
        model.addAttribute("availableBooks", bookService.getAvailableBooks());
        model.addAttribute("totalReaders", readerService.getTotalReaders());
        model.addAttribute("totalBorrowed", borrowRecordService.getTotalBorrowed());
        model.addAttribute("totalOverdue", borrowRecordService.getTotalOverdue());
        
        return "index";
    }
}
