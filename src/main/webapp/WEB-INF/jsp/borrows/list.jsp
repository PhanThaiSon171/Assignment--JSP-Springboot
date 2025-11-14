<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách mượn/trả sách</title>
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
            <div class="card-header bg-info text-white">
                <h4 class="mb-0"><i class="fas fa-exchange-alt"></i> Danh sách mượn/trả sách</h4>
            </div>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <a href="/borrows/add" class="btn btn-success">
                            <i class="fas fa-plus"></i> Tạo phiếu mượn mới
                        </a>
                    </div>
                    <div class="col-md-6">
                        <div class="btn-group float-end">
                            <a href="/borrows" class="btn btn-sm ${status == null ? 'btn-primary' : 'btn-outline-primary'}">
                                Tất cả
                            </a>
                            <a href="/borrows?status=borrowed" class="btn btn-sm ${status == 'borrowed' ? 'btn-primary' : 'btn-outline-primary'}">
                                Đang mượn
                            </a>
                            <a href="/borrows?status=returned" class="btn btn-sm ${status == 'returned' ? 'btn-primary' : 'btn-outline-primary'}">
                                Đã trả
                            </a>
                            <a href="/borrows?status=overdue" class="btn btn-sm ${status == 'overdue' ? 'btn-primary' : 'btn-outline-primary'}">
                                Quá hạn
                            </a>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Sách</th>
                                <th>Độc giả</th>
                                <th>Ngày mượn</th>
                                <th>Hạn trả</th>
                                <th>Ngày trả</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty records}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted">Không có dữ liệu</td>
                                </tr>
                            </c:if>
                            <c:forEach var="record" items="${records}">
                                <tr>
                                    <td>${record.id}</td>
                                    <td>${record.book.title}</td>
                                    <td>${record.reader.fullName}</td>
                                    <td>${record.borrowDate}</td>
                                    <td>${record.dueDate}</td>
                                    <td>${record.returnDate != null ? record.returnDate : '-'}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${record.status.toString() == 'BORROWED'}">
                                                <span class="badge bg-warning">Đang mượn</span>
                                            </c:when>
                                            <c:when test="${record.status.toString() == 'RETURNED'}">
                                                <span class="badge bg-success">Đã trả</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">Quá hạn</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${record.status.toString() != 'RETURNED'}">
                                            <a href="/borrows/return/${record.id}" 
                                               class="btn btn-sm btn-success"
                                               onclick="return confirm('Xác nhận trả sách?')">
                                                <i class="fas fa-undo"></i> Trả sách
                                            </a>
                                        </c:if>
                                        <c:if test="${record.status.toString() == 'RETURNED'}">
                                            <span class="text-muted">
                                                <i class="fas fa-check"></i> Đã trả
                                            </span>
                                        </c:if>
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
