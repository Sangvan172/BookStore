<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.all.min.js"></script>
        <link rel="stylesheet" href="css/listMenu.css">

        <style>
            body {
                font-family: Arial, sans-serif;
                line-height: 1.6;
                background-color: #f4f4f4;
            }

            .container-i {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                padding: 20px;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .logo-tittle {
                margin-right: 20px;
            }

            .name-tittle {
                font-size: 24px;
                font-weight: bold;
                color: #333;
            }

            .user-info {
                text-align: right;
            }

            .search-main {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .search-container {
                flex: 1;
                margin-right: 10px;
            }

            .search-box {
                width: 100%;
                padding: 10px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .filter {
                flex: 1;
                text-align: right;
            }

            .select-box {
                padding: 8px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            .table th,
            .table td {
                padding: 10px;
                text-align: center;
            }

            .table th {
                background-color: #f2f2f2;
                border-bottom: 2px solid #ddd;
            }

            .table-striped tbody tr:nth-of-type(odd) {
                background-color: #f9f9f9;
            }

            .btn {
                padding: 8px 16px;
                margin-right: 5px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
            }

            .btn-update {
                background-color: #007bff;
                color: white;
            }

            .btn-delete {
                background-color: #dc3545;
                color: white;
            }

            .btn-detail {
                background-color: #28a745;
                color: white;
            }

            .not-found {
                text-align: center;
                margin-top: 20px;
                display: none;
            }
        </style>

        <title>BookStore manager</title>
    </head>

    <body>
        <div class="container-i">
            <%@include file="Msidebar.jsp" %>
            <main>
                <%
                    String username = (String) request.getSession().getAttribute("username");
                    if (username == null) {
                        response.sendRedirect("/Mlogin");
                    }
                %>
                <div class="header">
                    <div class="name-tittle">
                        Menu
                    </div>
                    <div class="user-info">
                        <p>Hey, <b><%= request.getSession().getAttribute("username")%></b></p>
                        <small class="text-muted">Admin</small>
                    </div>
                </div>
                <h2>List Book</h2>
                <div class="search-main">
                    <div class="search-container">
                        <input type="text" class="search-box" id="searchInput" placeholder="Search Name Book...">
                    </div>
                    <div class="filter">
                        <label>Category filter: </label>
                        <select class="select-box">
                            <option value="All" selected>All</option>
                            <option value="CAT001">Children books</option>
                            <option value="CAT002">Comic</option>
                            <option value="CAT003">Textbook</option>
                            <option value="CAT004">Psychology books</option>
                            <option value="CAT005">Fables</option>
                            <option value="CAT006">Novel</option>
                            <option value="CAT007">Combo</option>
                        </select>
                    </div>
                </div>
                <table class="table table-striped" id="bookList">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Total Order</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="m" items="${requestScope.menu}">
                            <tr>
                                <td>${m.name}</td>
                                <td>${m.price}$</td>
                                <td>${m.status}</td>
                                <td>${m.numOrder}</td>
                                <td class="actions">
<!--                                    <button class="btn btn-update" onclick="updateBook('${m.id}')">Update</button>
                                    <button class="btn btn-delete" onclick="confirmDeleteBook('${m.id}')">Delete</button>-->
                                    <button class="btn btn-detail" style="background-color: white; color: blue;" onclick="viewBookDetail('${m.id}')">View</button>

                                    <style>
                                        .btn-detail:hover {
                                            background-color: lightblue; /* Nền chuyển thành xanh nhạt khi di chuột vào */
                                            color: white; /* Chữ chuyển thành màu trắng khi di chuột vào */
                                        }
                                    </style>


                                </td>
                                <td class="categoryId" style="display: none;">
                                    <p>${m.categoryId}</p>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="not-found" style="display: none;">
                    <p>Not found !</p>
                </div>
            </main>
        </div>
    </body>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const bookItems = document.querySelectorAll('#bookList tbody tr');
            const searchInput = document.getElementById('searchInput');
            const selectBox = document.querySelector('.select-box');
            const notFoundMessage = document.querySelector('.not-found');
            const originalBookList = Array.from(bookItems);

            selectBox.addEventListener('change', function () {
                const selectedCategory = selectBox.value;
                const searchTerm = searchInput.value.toLowerCase();

                originalBookList.forEach(bookItem => {
                    const categoryId = bookItem.querySelector('.categoryId p').textContent.trim();
                    const nameBook = bookItem.querySelector('td').textContent.toLowerCase();

                    if (
                            (selectedCategory === 'All' || categoryId === selectedCategory) &&
                            (nameBook.includes(searchTerm))
                            ) {
                        bookItem.style.display = '';
                    } else {
                        bookItem.style.display = 'none';
                    }
                });

                const resultsFound = originalBookList.some(bookItem => bookItem.style.display !== 'none');

                notFoundMessage.style.display = resultsFound ? 'none' : '';
            });

            searchInput.addEventListener('input', function () {
                const searchTerm = searchInput.value.toLowerCase();
                const selectedCategory = selectBox.value;

                originalBookList.forEach(bookItem => {
                    const categoryId = bookItem.querySelector('.categoryId p').textContent.trim();
                    const nameBook = bookItem.querySelector('td').textContent.toLowerCase();

                    if (
                            (selectedCategory === 'All' || categoryId === selectedCategory) &&
                            (nameBook.includes(searchTerm))
                            ) {
                        bookItem.style.display = '';
                    } else {
                        bookItem.style.display = 'none';
                    }
                });

                const resultsFound = originalBookList.some(bookItem => bookItem.style.display !== 'none');

                notFoundMessage.style.display = resultsFound ? 'none' : '';
            });
        });

        function confirmDeleteBook(bookId) {
            Swal.fire({
                title: 'Are you sure?',
                text: 'Do you really want to delete this book?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'No, cancel!',
                reverseButtons: false
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location = "MdeleteBook?bid=" + bookId;
                }
            });
        }

        function updateBook(bookId) {
            window.location = "MupdateBook?bid=" + bookId;
        }

        function viewBookDetail(bookId) {
            window.location = "MbookDetails?bid=" + bookId;
        }


    </script>
</html>
