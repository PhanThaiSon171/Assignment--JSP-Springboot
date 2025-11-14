<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sách</title>
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
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show">
                <i class="fas fa-check-circle"></i> ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show">
                <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="card">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0"><i class="fas fa-list"></i> Danh sách sách</h4>
            </div>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <a href="/books/add" class="btn btn-success">
                            <i class="fas fa-plus"></i> Thêm sách mới
                        </a>
                    </div>
                    <div class="col-md-6">
                        <form action="/books" method="get" class="input-group">
                            <input type="text" name="keyword" class="form-control" 
                                   placeholder="Tìm kiếm sách..." value="${keyword}">
                            <button class="btn btn-primary" type="submit">
                                <i class="fas fa-search"></i> Tìm kiếm
                            </button>
                        </form>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Tên sách</th>
                                <th>Tác giả</th>
                                <th>Thể loại</th>
                                <th>NXB</th>
                                <th>Năm XB</th>
                                <th>Số lượng</th>
                                <th>Có sẵn</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty books}">
                                <tr>
                                    <td colspan="9" class="text-center text-muted">Không có dữ liệu</td>
                                </tr>
                            </c:if>
                            <c:forEach var="book" items="${books}">
                                <tr>
                                    <td>${book.id}</td>
                                    <td>${book.title}</td>
                                    <td>${book.author}</td>
                                    <td>${book.category}</td>
                                    <td>${book.publisher}</td>
                                    <td>${book.publishYear}</td>
                                    <td>${book.quantity}</td>
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
                                    <td>
                                        <a href="/books/detail/${book.id}" class="btn btn-sm btn-info">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="/books/edit/${book.id}" class="btn btn-sm btn-warning">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="/books/delete/${book.id}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Bạn có chắc muốn xóa?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
