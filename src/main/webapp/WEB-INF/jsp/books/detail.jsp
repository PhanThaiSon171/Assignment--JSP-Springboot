<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sách</title>
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
                <h4 class="mb-0"><i class="fas fa-info-circle"></i> Chi tiết sách</h4>
            </div>
            <div class="card-body">
                <table class="table table-bordered">
                    <tr>
                        <th style="width: 200px;">Mã sách</th>
                        <td>${book.id}</td>
                    </tr>
                    <tr>
                        <th>Tên sách</th>
                        <td>${book.title}</td>
                    </tr>
                    <tr>
                        <th>Tác giả</th>
                        <td>${book.author}</td>
                    </tr>
                    <tr>
                        <th>Thể loại</th>
                        <td>${book.category}</td>
                    </tr>
                    <tr>
                        <th>Nhà xuất bản</th>
                        <td>${book.publisher}</td>
                    </tr>
                    <tr>
                        <th>Năm xuất bản</th>
                        <td>${book.publishYear}</td>
                    </tr>
                    <tr>
                        <th>Số lượng</th>
                        <td>${book.quantity}</td>
                    </tr>
                    <tr>
                        <th>Số lượng có sẵn</th>
                        <td>
                            <c:choose>
                                <c:when test="${book.availableQuantity > 0}">
                                    <span class="badge bg-success">${book.availableQuantity}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger">${book.availableQuantity}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>Mô tả</th>
                        <td>${book.description != null ? book.description : 'Không có mô tả'}</td>
                    </tr>
                    <tr>
                        <th>Ngày thêm</th>
                        <td>${book.createdAt}</td>
                    </tr>
                </table>

                <div class="d-flex gap-2">
                    <a href="/books/edit/${book.id}" class="btn btn-warning">
                        <i class="fas fa-edit"></i> Sửa
                    </a>
                    <a href="/books" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
