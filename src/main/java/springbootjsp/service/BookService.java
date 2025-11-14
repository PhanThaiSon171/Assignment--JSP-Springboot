package springbootjsp.service;

import springbootjsp.entity.Book;
import springbootjsp.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class BookService {
    
    @Autowired
    private BookRepository bookRepository;
    
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }
    
    @SuppressWarnings("null")
    public Optional<Book> getBookById(Long id) {
        return bookRepository.findById(id);
    }
    
    @SuppressWarnings("null")
    public Book saveBook(Book book) {
        return bookRepository.save(book);
    }

    @SuppressWarnings("null")
    public void deleteBook(Long id) {
        bookRepository.deleteById(id);
    }
    
    public List<Book> searchBooks(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllBooks();
        }
        return bookRepository.searchBooks(keyword.trim());
    }
    
    public List<Book> searchByTitle(String title) {
        return bookRepository.findByTitleContainingIgnoreCase(title);
    }
    
    public List<Book> searchByAuthor(String author) {
        return bookRepository.findByAuthorContainingIgnoreCase(author);
    }
    
    public List<Book> searchByCategory(String category) {
        return bookRepository.findByCategoryContainingIgnoreCase(category);
    }
    
    public long getTotalBooks() {
        return bookRepository.countAllBooks();
    }
    
    public long getAvailableBooks() {
        Long sum = bookRepository.sumAvailableBooks();
        return sum != null ? sum : 0;
    }
    
    @SuppressWarnings("null")
    public boolean decreaseAvailableQuantity(Long bookId) {
        Optional<Book> bookOpt = bookRepository.findById(bookId);
        if (bookOpt.isPresent()) {
            Book book = bookOpt.get();
            if (book.getAvailableQuantity() > 0) {
                book.setAvailableQuantity(book.getAvailableQuantity() - 1);
                bookRepository.save(book);
                return true;
            }
        }
        return false;
    }
    
    @SuppressWarnings("null")
    public void increaseAvailableQuantity(Long bookId) {
        Optional<Book> bookOpt = bookRepository.findById(bookId);
        if (bookOpt.isPresent()) {
            Book book = bookOpt.get();
            if (book.getAvailableQuantity() < book.getQuantity()) {
                book.setAvailableQuantity(book.getAvailableQuantity() + 1);
                bookRepository.save(book);
            }
        }
    }
}
