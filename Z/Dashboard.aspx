<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Z.Dashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
    <title>Admin Dashboard</title>
</head>
<body class="bg-gray-100">
    <form id="form1" runat="server">
        <div class="min-h-screen flex flex-col">
            <!-- Header -->
            <header class="bg-gray-800 text-gray-200 p-4 flex justify-between items-center">
                <h1 class="text-2xl font-bold">Admin Dashboard</h1>
                <div class="flex items-center space-x-4">
                    <span>Welcome, Admin</span>
                    <a href="#" class="py-2 px-4 bg-red-500 rounded hover:bg-red-700">Logout</a>
                </div>
            </header>
            
            <!-- Main Content and Sidebar -->
            <div class="flex flex-1">
                <!-- Sidebar -->
                <aside class="w-64 bg-gray-800 text-gray-200 flex-shrink-0">
                    <div class="p-4">
                        <h2 class="text-xl font-semibold">Navigation</h2>
                    </div>
                    <nav class="flex flex-col p-4">
                        <a href="#" class="py-2 px-4 rounded hover:bg-gray-700">HR Management</a>
                        <a href="#" class="py-2 px-4 rounded hover:bg-gray-700">Product Management</a>
                        <a href="#" class="py-2 px-4 rounded hover:bg-gray-700">Customer Management</a>
                    </nav>
                </aside>

                <!-- Main Content -->
                <div class="flex-1 p-6">
                    <h2 class="text-2xl font-semibold mb-6">Dashboard Overview</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        <!-- HR Management Block -->
                        <div class="bg-white p-4 rounded shadow">
                            <h3 class="text-xl font-semibold mb-4">HR Management</h3>
                            <p>Manage HR related tasks and employees.</p>
                            <a href="#" class="text-blue-500 hover:underline">Go to HR Management</a>
                        </div>
                        <!-- Product Management Block -->
                        <div class="bg-white p-4 rounded shadow">
                            <h3 class="text-xl font-semibold mb-4">Product Management</h3>
                            <p>Manage product related tasks and employees.</p>
                            <a href="#" class="text-blue-500 hover:underline">Go to Product Management</a>
                        </div>
                        <!-- Customer Management Block -->
                        <div class="bg-white p-4 rounded shadow">
                            <h3 class="text-xl font-semibold mb-4">Customer Management</h3>
                            <p>Manage customer related tasks and employees.</p>
                            <a href="#" class="text-blue-500 hover:underline">Go to Customer Management</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <footer class="bg-gray-800 text-gray-200 p-4 text-center">
                <p>&copy; 2024 Admin Dashboard. All rights reserved.</p>
            </footer>
        </div>
    </form>
</body>
</html>
