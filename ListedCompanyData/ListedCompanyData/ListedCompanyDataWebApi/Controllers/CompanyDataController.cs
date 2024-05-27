using ListedCompanyDataWebApi.Model;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;

namespace ListedCompanyDataWebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CompanyDataController : ControllerBase
    {
        private readonly ILogger<WeatherForecastController> _logger;
        //private

        public CompanyDataController(ILogger<WeatherForecastController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "GetSummaryMonthlyIncome")]
        public IEnumerable<GetSummaryMonthlyIncomeModel> Get(DateTime? dataDateTime)
        {
            List<GetSummaryMonthlyIncomeModel> records = new List<GetSummaryMonthlyIncomeModel>();

            DateTime? monthFirstDate = dataDateTime.HasValue ? new DateTime(dataDateTime.Value.Year, dataDateTime.Value.Month, 1) : null;
            // 可放config
            string connectionString = "Server=.;Database=ListedCompanyData;Trusted_Connection=True;MultipleActiveResultSets=True;";

            // 使用 using 確保資源正確釋放
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // 建立 SQL 命令物件，並指定存儲過程名稱和連接物件
                using (SqlCommand command = new SqlCommand("GetSummaryMonthlyIncome", connection))
                {
                    // 指定命令類型為存儲過程
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    // 添加存儲過程所需的參數，請替換參數名稱和值
                    command.Parameters.AddWithValue("@DataDatetime", monthFirstDate);

                    try
                    {
                        connection.Open(); // 開啟資料庫連接
                        //var data = command.ExecuteReader(); // 執行存儲過程
                        
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                var record = new GetSummaryMonthlyIncomeModel
                                {
                                    CompanyId = reader.GetString(0),
                                    DataDatetime = reader.GetDateTime(1),
                                    OperatingIncomeCurrentMonth = reader.GetDecimal(2),
                                    OperatingIncomeLastMonth = reader.GetDecimal(3),
                                    OperatingIncomeLastYearCurrentMonth = reader.GetDecimal(4),
                                    OperatingIncomeComparativeLastMonth = reader.GetDecimal(5),
                                    OperatingIncomeComparativeLastYearCurrentMonth = reader.GetDecimal(6),
                                    CumulativeOperatingIncomeCurrentMonth = reader.GetDecimal(7),
                                    CumulativeOperatingIncomeLastYearCurrentMonth = reader.GetDecimal(8),
                                    CumulativeOperatingIncomeComparative = reader.GetDecimal(9),
                                    Note = reader.GetString(10),
                                    CompanyName = reader.GetString(11),
                                    IndustryCategoryId = reader.GetInt32(12),
                                    IndustryCategoryName = reader.GetString(13),
                                };
                                records.Add(record);
                            }
                        }

                        Console.WriteLine("Stored procedure executed successfully.");
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Error executing stored procedure: " + ex.Message);
                    }
                }
            }

            return records;
        }
    }
}
