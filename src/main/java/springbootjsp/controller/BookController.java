package springbootjsp.controller;

import springbootjsp.entity.Book;
import springbootjsp.service.BookService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/books")
public class BookController {
    
    private final BookService bookService;
    
    @GetMapping
    public String listBooks(@RequestParam(required = false) String keyword, Model model) {
        List<Book> books;
        if (keyword != null && !keyword.trim().isEmpty()) {
            books = bookService.searchBooks(keyword);
            model.addAttribute("keyword", keyword);
        } else {
            books = bookService.getAllBooks();
        }
        model.addAttribute("books", books);
        return "books/list";
    }
    
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("book", new Book());
        return "books/form";
    }
    
    @PostMapping("/add")
    public String addBook(@Valid @ModelAttribute("book") Book book, 
                         BindingResult result, 
                         RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "books/form";
        }
        bookService.saveBook(book);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm sách thành công!");
        return "redirect:/books";
    }
    
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Book book = bookService.getBookById(id)
                .orElse(null);
        if (book == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy sách!");
            return "redirect:/books";
        }
        model.addAttribute("book", book);
        return "books/form";
    }
    
    @PostMapping("/edit/{id}")
    public String updateBook(@PathVariable Long id, 
                           @Valid @ModelAttribute("book") Book book, 
                           BindingResult result,
                           RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "books/form";
        }
        book.setId(id);
        bookService.saveBook(book);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật sách thành công!");
        return "redirect:/books";
    }
    
    @GetMapping("/delete/{id}")
    public String deleteBook(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            bookService.deleteBook(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa sách thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa sách này!");
        }
        return "redirect:/books";
    }
    
    @GetMapping("/detail/{id}")
    public String viewDetail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Book book = bookService.getBookById(id).orElse(null);
        if (book == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy sách!");
            return "redirect:/books";
        }
        model.addAttribute("book", book);
        return "books/detail";
    }
}
