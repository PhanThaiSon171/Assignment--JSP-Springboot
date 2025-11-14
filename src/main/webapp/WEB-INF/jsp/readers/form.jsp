<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${reader.id != null ? 'Sửa độc giả' : 'Thêm độc giả'}</title>
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
                    <li class="nav-item"><a class="nav-link active" href="/readers"><i class="fas fa-users"></i> Độc giả</a></li>
                    <li class="nav-item"><a class="nav-link" href="/borrows"><i class="fas fa-exchange-alt"></i> Mượn/Trả</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="card">
            <div class="card-header bg-success text-white">
                <h4 class="mb-0">
                    <c:choose>
                        <c:when test="${reader.id != null}">
                            <i class="fas fa-edit"></i> Sửa thông tin độc giả
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-plus"></i> Thêm độc giả mới
                        </c:otherwise>
                    </c:choose>
                </h4>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${reader.id != null}">
                        <form action="/readers/edit/${reader.id}" method="post">
                    </c:when>
                    <c:otherwise>
                        <form action="/readers/add" method="post">
                    </c:otherwise>
                </c:choose>
                    <div class="mb-3">
                        <label class="form-label">Họ tên <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="fullName" value="${reader.fullName}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" value="${reader.email}">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" name="phone" placeholder="0123456789" value="${reader.phone}">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Địa chỉ</label>
                        <textarea class="form-control" name="address" rows="3">${reader.address}</textarea>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save"></i> Lưu
                        </button>
                        <a href="/readers" class="btn btn-secondary">
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
