package springbootjsp.service;

import springbootjsp.entity.Reader;
import springbootjsp.repository.ReaderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ReaderService {
    
    @Autowired
    private ReaderRepository readerRepository;
    
    public List<Reader> getAllReaders() {
        return readerRepository.findAll();
    }
    
    @SuppressWarnings("null")
    public Optional<Reader> getReaderById(Long id) {
        return readerRepository.findById(id);
    }
    
    @SuppressWarnings("null")
    public Reader saveReader(Reader reader) {
        return readerRepository.save(reader);
    }
    
    @SuppressWarnings("null")
    public void deleteReader(Long id) {
        readerRepository.deleteById(id);
    }
    
    public List<Reader> searchByName(String name) {
        return readerRepository.findByFullNameContainingIgnoreCase(name);
    }
    
    public long getTotalReaders() {
        return readerRepository.count();
    }
}
