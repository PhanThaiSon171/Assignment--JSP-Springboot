<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${book.id != null ? 'Sửa sách' : 'Thêm sách'}</title>
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
                    <li class="nav-item"><a class="nav-link active" href="/books"><i class="fas fa-book"></i> Quản lý sách</a></li>
                    <li class="nav-item"><a class="nav-link" href="/readers"><i class="fas fa-users"></i> Độc giả</a></li>
                    <li class="nav-item"><a class="nav-link" href="/borrows"><i class="fas fa-exchange-alt"></i> Mượn/Trả</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">
                    <c:choose>
                        <c:when test="${book.id != null}">
                            <i class="fas fa-edit"></i> Sửa thông tin sách
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-plus"></i> Thêm sách mới
                        </c:otherwise>
                    </c:choose>
                </h4>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${book.id != null}">
                        <form action="/books/edit/${book.id}" method="post">
                    </c:when>
                    <c:otherwise>
                        <form action="/books/add" method="post">
                    </c:otherwise>
                </c:choose>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Tên sách <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="title" value="${book.title}" required>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Tác giả <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="author" value="${book.author}" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Thể loại <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="category" value="${book.category}" required>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Nhà xuất bản <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="publisher" value="${book.publisher}" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Năm xuất bản <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" name="publishYear" value="${book.publishYear}" required>
                        </div>
                        
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Số lượng <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" name="quantity" value="${book.quantity}" min="0" required>
                        </div>
                        
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Số lượng có sẵn <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" name="availableQuantity" value="${book.availableQuantity}" min="0" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Mô tả</label>
                        <textarea class="form-control" name="description" rows="3">${book.description}</textarea>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Lưu
                        </button>
                        <a href="/books" class="btn btn-secondary">
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
