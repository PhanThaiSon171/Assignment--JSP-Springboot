<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Quản lý thư viện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .stat-card {
            border-left: 4px solid;
            transition: all 0.3s;
            background: white;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,.2);
        }
        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,.1);
        }
        .welcome-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,.2);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-book-reader"></i> Hệ thống quản lý thư viện
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="/"><i class="fas fa-home"></i> Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/books"><i class="fas fa-book"></i> Quản lý sách</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/readers"><i class="fas fa-users"></i> Quản lý độc giả</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/borrows"><i class="fas fa-exchange-alt"></i> Mượn/Trả sách</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="welcome-card mb-4">
            <h1 class="text-center mb-3">
                <i class="fas fa-book-reader text-primary"></i> 
                Chào mừng đến với hệ thống quản lý thư viện
            </h1>
            <p class="text-center text-muted">Quản lý sách, độc giả và mượn/trả sách một cách dễ dàng và hiệu quả</p>
        </div>

        <h3 class="text-white mb-4"><i class="fas fa-chart-bar"></i> Thống kê tổng quan</h3>
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card stat-card border-0" style="border-left-color: #007bff !important;">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted mb-2">Tổng số sách</h6>
                                <h2 class="mb-0">${totalBooks != null ? totalBooks : 0}</h2>
                            </div>
                            <div class="text-primary">
                                <i class="fas fa-book fa-3x"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="card stat-card border-0" style="border-left-color: #28a745 !important;">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted mb-2">Sách có sẵn</h6>
                                <h2 class="mb-0">${availableBooks != null ? availableBooks : 0}</h2>
                            </div>
                            <div class="text-success">
                                <i class="fas fa-check-circle fa-3x"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="card stat-card border-0" style="border-left-color: #ffc107 !important;">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted mb-2">Tổng độc giả</h6>
                                <h2 class="mb-0">${totalReaders != null ? totalReaders : 0}</h2>
                            </div>
                            <div class="text-warning">
                                <i class="fas fa-users fa-3x"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mb-4">
                <div class="card stat-card border-0" style="border-left-color: #17a2b8 !important;">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted mb-2">Sách đang mượn</h6>
                                <h2 class="mb-0">${totalBorrowed != null ? totalBorrowed : 0}</h2>
                            </div>
                            <div class="text-info">
                                <i class="fas fa-hand-holding-heart fa-3x"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mb-4">
                <div class="card stat-card border-0" style="border-left-color: #dc3545 !important;">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted mb-2">Sách quá hạn</h6>
                                <h2 class="mb-0">${totalOverdue != null ? totalOverdue : 0}</h2>
                            </div>
                            <div class="text-danger">
                                <i class="fas fa-exclamation-triangle fa-3x"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-md-4 mb-3">
                <a href="/books" class="text-decoration-none">
                    <div class="card border-0 text-center h-100" style="background: #007bff; color: white;">
                        <div class="card-body">
                            <i class="fas fa-book fa-4x mb-3"></i>
                            <h5>Quản lý sách</h5>
                            <p class="small">Thêm, sửa, xóa và tìm kiếm sách</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 mb-3">
                <a href="/readers" class="text-decoration-none">
                    <div class="card border-0 text-center h-100" style="background: #28a745; color: white;">
                        <div class="card-body">
                            <i class="fas fa-users fa-4x mb-3"></i>
                            <h5>Quản lý độc giả</h5>
                            <p class="small">Quản lý thông tin độc giả</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 mb-3">
                <a href="/borrows" class="text-decoration-none">
                    <div class="card border-0 text-center h-100" style="background: #17a2b8; color: white;">
                        <div class="card-body">
                            <i class="fas fa-exchange-alt fa-4x mb-3"></i>
                            <h5>Mượn/Trả sách</h5>
                            <p class="small">Quản lý phiếu mượn và trả sách</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <footer class="mt-5 py-3 bg-dark text-white text-center">
        <div class="container">
            <p class="mb-0">© 2025 Hệ thống quản lý thư viện - Java Spring Boot Application</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
