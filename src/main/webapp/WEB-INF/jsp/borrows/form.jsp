<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo phiếu mượn sách</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/"><i class="fas fa-book-reader"></i> Quản lý thư viện</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="/"><i class="fas fa-home"></i> Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="/books"><i class="fas fa-book"></i> Quản lý sách</a></li>
                    <li class="nav-item"><a class="nav-link" href="/readers"><i class="fas fa-users"></i> Độc giả</a></li>
                    <li class="nav-item"><a class="nav-link active" href="/borrows"><i class="fas fa-exchange-alt"></i> Mượn/Trả</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="card">
            <div class="card-header bg-info text-white">
                <h4 class="mb-0"><i class="fas fa-plus"></i> Tạo phiếu mượn sách</h4>
            </div>
            <div class="card-body">
                <form action="/borrows/add" method="post">
                    <div class="mb-3">
                        <label class="form-label">Chọn sách <span class="text-danger">*</span></label>
                        <select name="bookId" class="form-select" required>
                            <option value="">-- Chọn sách --</option>
                            <c:forEach var="book" items="${books}">
                                <option value="${book.id}">
                                    ${book.title} - ${book.author} (Còn: ${book.availableQuantity})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Chọn độc giả <span class="text-danger">*</span></label>
                        <select name="readerId" class="form-select" required>
                            <option value="">-- Chọn độc giả --</option>
                            <c:forEach var="reader" items="${readers}">
                                <option value="${reader.id}">
                                    ${reader.fullName} - ${reader.phone != null ? reader.phone : ''}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Số ngày mượn (mặc định: 14 ngày)</label>
                        <input type="number" name="daysToReturn" class="form-control" 
                               value="14" min="1" max="90">
                        <small class="text-muted">Nhập số ngày cho phép mượn (1-90 ngày)</small>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Ghi chú</label>
                        <textarea name="notes" class="form-control" rows="3"></textarea>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Tạo phiếu mượn
                        </button>
                        <a href="/borrows" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Hủy
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
