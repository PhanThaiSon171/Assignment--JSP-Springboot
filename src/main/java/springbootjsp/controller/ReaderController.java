package springbootjsp.controller;

import springbootjsp.entity.Reader;
import springbootjsp.service.ReaderService;
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
@RequestMapping("/readers")
public class ReaderController {
    
    private final ReaderService readerService;
    
    @GetMapping
    public String listReaders(@RequestParam(required = false) String keyword, Model model) {
        List<Reader> readers;
        if (keyword != null && !keyword.trim().isEmpty()) {
            readers = readerService.searchByName(keyword);
            model.addAttribute("keyword", keyword);
        } else {
            readers = readerService.getAllReaders();
        }
        model.addAttribute("readers", readers);
        return "readers/list";
    }
    
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("reader", new Reader());
        return "readers/form";
    }
    
    @PostMapping("/add")
    public String addReader(@Valid @ModelAttribute("reader") Reader reader, 
                          BindingResult result,
                          RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "readers/form";
        }
        readerService.saveReader(reader);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm độc giả thành công!");
        return "redirect:/readers";
    }
    
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Reader reader = readerService.getReaderById(id).orElse(null);
        if (reader == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy độc giả!");
            return "redirect:/readers";
        }
        model.addAttribute("reader", reader);
        return "readers/form";
    }
    
    @PostMapping("/edit/{id}")
    public String updateReader(@PathVariable Long id, 
                             @Valid @ModelAttribute("reader") Reader reader, 
                             BindingResult result,
                             RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "readers/form";
        }
        reader.setId(id);
        readerService.saveReader(reader);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật độc giả thành công!");
        return "redirect:/readers";
    }
    
    @GetMapping("/delete/{id}")
    public String deleteReader(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            readerService.deleteReader(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa độc giả thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa độc giả này!");
        }
        return "redirect:/readers";
    }
}
