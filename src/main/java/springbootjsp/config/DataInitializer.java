package springbootjsp.config;

import springbootjsp.entity.Book;
import springbootjsp.entity.Reader;
import springbootjsp.repository.BookRepository;
import springbootjsp.repository.ReaderRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {
    
    private final BookRepository bookRepository;
    
    private final ReaderRepository readerRepository;
    
    @Override
    public void run(String... args) throws Exception {
        if (bookRepository.count() == 0) {
            bookRepository.save(new Book(null, "Lập trình Java cơ bản", "Nguyễn Văn A", "Công nghệ thông tin", "NXB Giáo dục", 2023, "Sách hướng dẫn lập trình Java từ cơ bản đến nâng cao", 10, 10, null));
            bookRepository.save(new Book(null, "Spring Boot thực chiến", "Trần Thị B", "Công nghệ thông tin", "NXB Lao động", 2024, "Xây dựng ứng dụng web với Spring Boot", 8, 8, null));
            bookRepository.save(new Book(null, "Cơ sở dữ liệu", "Lê Văn C", "Công nghệ thông tin", "NXB Khoa học", 2022, "Thiết kế và quản trị cơ sở dữ liệu", 15, 15, null));
            bookRepository.save(new Book(null, "Trí tuệ nhân tạo", "Phạm Thị D", "Công nghệ thông tin", "NXB Đại học Quốc gia", 2024, "Nhập môn trí tuệ nhân tạo và machine learning", 5, 5, null));
            bookRepository.save(new Book(null, "Đắc nhân tâm", "Dale Carnegie", "Kỹ năng sống", "NXB Tổng hợp", 2020, "Nghệ thuật giao tiếp và ứng xử", 20, 20, null));
            bookRepository.save(new Book(null, "Nhà giả kim", "Paulo Coelho", "Văn học", "NXB Hội Nhà văn", 2019, "Hành trình tìm kiếm giấc mơ", 12, 12, null));
            bookRepository.save(new Book(null, "Sapiens - Lược sử loài người", "Yuval Noah Harari", "Lịch sử", "NXB Thế giới", 2021, "Câu chuyện về sự tiến hóa của loài người", 7, 7, null));
            bookRepository.save(new Book(null, "Thuật toán và cấu trúc dữ liệu", "Hoàng Văn E", "Công nghệ thông tin", "NXB Khoa học", 2023, "Các thuật toán cơ bản và nâng cao", 6, 6, null));
        }
        
        if (readerRepository.count() == 0) {
            readerRepository.save(new Reader(null, "Nguyễn Minh Anh", "minhanh@example.com", "0901234567", "Hà Nội", null));
            readerRepository.save(new Reader(null, "Trần Hoàng Bảo", "hoangbao@example.com", "0912345678", "TP. Hồ Chí Minh", null));
            readerRepository.save(new Reader(null, "Lê Thị Cẩm", "thicam@example.com", "0923456789", "Đà Nẵng", null));
            readerRepository.save(new Reader(null, "Phạm Văn Dũng", "vandung@example.com", "0934567890", "Hải Phòng", null));
            readerRepository.save(new Reader(null, "Hoàng Thị Nga", "thinga@example.com", "0945678901", "Cần Thơ", null));
        }
    }
}
