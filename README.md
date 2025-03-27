# TestProjectAssement

## 📌 Project Overview

This project includes a **Database implementation** with stored procedures and a **Web API** for user management. Key features include:

- Database setup with **stored procedures** and **tables**.
- Web API development with **NuGet package management**.

### 1️⃣ Database Setup

- **Created Database** ProjectDB.sql
- **Created tables** for user data.
- **Implemented stored procedures** for database operations.

### 2️⃣ WebApp Setup

- Installed required **NuGet packages**.
- Restored dependencies using:
  ```sh
  dotnet restore
  ```
- Cleaned and rebuilt the project using:
  ```sh
  dotnet build
  ```

---

## 🔄 Code Changes

### 📌 **ServiceController.cs**

#### 🔹 **User Login Refactoring**

```csharp
case "UserLogin":
break;
```

🔄 **Changed to:**

```csharp
case "GetAllUsers":
    _response = await _ius.GetAllUsers(uiReq);
    break;
```

#### 🔹 **Update User Handling**

```csharp
case "UpdateUser":
break;
```

🔄 **Changed to:**

```csharp
case "UpdateUser":
    _response = await _ius.UpdateUser(uiReq);
    break;
```

#### 🔹 **Delete User Updates**

```csharp
case "DeleteAllUsers":
break;
```

🔄 **Changed to:**

```csharp
case "DeleteSingleUser":
    _response = await _ius.DeleteSingleUser(uiReq);
    break;
```

### 📌 **UserDBServices.cs**

#### 🔹 **Implemented IUserDBServices Interface** (Line 9)

#### 🔹 **RegisterUser Method Update**

✅ **Added Parameters:**

```csharp
command.Parameters.AddWithValue("@UserId", usrm.UserId);
command.Parameters.AddWithValue("@UserName", usrm.UserName);
command.Parameters.AddWithValue("@UserToken", usrm.UserToken);
command.Parameters.AddWithValue("@Epoc", usrm.Epoc);
```

✅ **Changed Exception Message:**

```csharp
_result.Message = "UserLogin() Exception: " + ex.Message;
```

🔄 **Changed to:**

```csharp
_result.Message = "RegisterUser() Exception: " + ex.Message;
```

#### 🔹 **UserLogin Method Enhancements**

✅ **Updated Date Field:**

```csharp
DateTouched = reader.GetDateTime(reader.GetOrdinal("DateTime"));
```

🔄 **Changed to:**

```csharp
DateTouched = reader.GetDateTime(reader.GetOrdinal("DateTouched"));
```

✅ **Refined Success & Exception Messages:**

```csharp
_result.Message = "User retrieved successfully";
```

🔄 **Changed to:**

```csharp
_result.Message = "UserLogin() User retrieved successfully";
```

```csharp
_result.Message = "Exception occurred: " + ex.Message;
```

🔄 **Changed to:**

```csharp
_result.Message = "UserLogin() Exception occurred: " + ex.Message;
```

✅ **Added UserToken Retrieval:**

```csharp
UserToken = reader.GetString(reader.GetOrdinal("UserToken"));
```

### 📌 **GetAllUsers Method Fix**

✅ **Updated SQL Query:**

```csharp
using (SqlCommand command = new SqlCommand("dbo.__GetAllUsers", connection))
```

🔄 **Changed to:**

```csharp
using (SqlCommand command = new SqlCommand("dbo.GetAllUsers", connection))
```

✅ **Added:**

```csharp
UserName = reader.GetString(reader.GetOrdinal("UserName"));
```

### 📌 **DeleteSingleUser Method Update**

✅ **Changed Method Signature:**

```csharp
public async Task<ServiceModel> DeleteSingleUser(string UserId)
```

🔄 **Changed to:**

```csharp
public async Task<ServiceModel> DeleteSingleUser(string UserName)
```

✅ **Updated SQL Parameter:**

```csharp
command.Parameters.AddWithValue("@UserId", UserId);
```

🔄 **Changed to:**

```csharp
command.Parameters.AddWithValue("@UserName", UserName);
```

### 📌 **DeleteAllUsers Method Fix**

✅ **Fixed Incorrect SQL Query:**

```csharp
using (SqlCommand command = new SqlCommand("dbo.LetsSeeif you canDelete?", connection))
```

🔄 **Changed to:**

```csharp
using (SqlCommand command = new SqlCommand("dbo.DeleteAllUsers", connection))
```

### 📌 **UserServices.cs - DecryptUserToken Fix**

✅ **Updated Exception Handling:**

```csharp
_result.Message = $"LoginUser(): Exception: {ex}";
```

🔄 **Changed to:**

```csharp
_result.Message = $"DecryptUserToken(): Exception: {ex}";
```

### 📌 **Appsettings.json Update**

✅ **Updated API URL for Debugging:**

```json
"Url": "https://Localhost:8080"
```

---
1️⃣ **Running Web API:**

```sh
dotnet run
```

2️⃣ **Running Angular WebApp:**

```sh
cd webapp
npm install  # Install dependencies
ng serve     # Start frontend server
```

3️⃣ **Access the Application:**

- **API:** [https://localhost:5001/swagger](https://localhost:5001/swagger)
- **WebApp:** [http://localhost:4200](http://localhost:4200)

---

## 🛠️ Tech Stack

- **Backend:** C# .NET Web API, SQL Server
- **Frontend:** Angular
- **Database:** Stored Procedures, SQL Tables
---



