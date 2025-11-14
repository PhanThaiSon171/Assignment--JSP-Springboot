package springbootjsp.repository;

import springbootjsp.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
    List<Book> findByTitleContainingIgnoreCase(String title);
    List<Book> findByAuthorContainingIgnoreCase(String author);
    List<Book> findByCategoryContainingIgnoreCase(String category);
    List<Book> findByPublisherContainingIgnoreCase(String publisher);
    
    @Query("SELECT b FROM Book b WHERE " +
           "LOWER(b.title) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(b.author) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(b.category) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(b.publisher) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Book> searchBooks(@Param("keyword") String keyword);
    
    @Query("SELECT COUNT(b) FROM Book b")
    long countAllBooks();
    
    @Query("SELECT SUM(b.availableQuantity) FROM Book b")
    Long sumAvailableBooks();
}
