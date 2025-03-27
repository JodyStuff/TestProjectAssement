using BaseProjectApi.Models;

namespace BaseProjectApi.Services.UserServices
{
    public interface IUserDBServices
    {
        Task<ServiceModel> RegisterUser(UsersModel usrm, UsersProfile usrp);
        Task<ServiceModel> UserLogin(bool UserName);
        Task<ServiceModel> GetSingleUser(string UserId);
        Task<ServiceModel> GetAllUsers(SelectionFilterModel Payload);
        Task<ServiceModel> UpdateUser(UsersModel usrm);
        Task<ServiceModel> DeleteSingleUser(string payload);
        Task<ServiceModel> DeleteAllUsers();
        Task<ServiceModel> UserLogin(string userName);
    }
}
