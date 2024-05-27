using ListedCompanyDataWebApi.Model;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;

namespace ListedCompanyDataWebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CompanyDataController : ControllerBase
    {
        private readonly ILogger<CompanyDataController> _logger;
        // TODO: 改放config
        private readonly string _connectionString = "Server=.;Database=ListedCompanyData;Trusted_Connection=True;MultipleActiveResultSets=True;";

        public CompanyDataController(ILogger<CompanyDataController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "GetSummaryMonthlyIncome")]
        public IEnumerable<GetSummaryMonthlyIncomeOutputModel> Get(DateTime? dataDateTime)
        {
            List<GetSummaryMonthlyIncomeOutputModel> records = new List<GetSummaryMonthlyIncomeOutputModel>();

            DateTime? monthFirstDate = dataDateTime.HasValue ? new DateTime(dataDateTime.Value.Year, dataDateTime.Value.Month, 1) : null;

            // 使用 using 確保資源正確釋放
            using (SqlConnection connection = new SqlConnection(_connectionString))
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
                                var record = new GetSummaryMonthlyIncomeOutputModel
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


        [HttpPost(Name = "InsertSummaryMonthlyIncome")]
        public bool InsertSummaryMonthlyIncome(InsertSummaryMonthlyIncomeInputModel model)
        {
            bool addResult = false;

            DateTime? monthFirstDate = new DateTime(model.DataDatetime.Year, model.DataDatetime.Month, 1);

            // 使用 using 确保资源正确释放
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                // 创建 SQL 命令对象，并指定存储过程名称和连接对象
                using (SqlCommand command = new SqlCommand("InsertSummaryMonthlyIncome", connection))
                {
                    // 指定命令类型为存储过程
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    // 添加存储过程所需的参数，请替换参数名称和值
                    command.Parameters.AddWithValue("@CompanyId", model.CompanyId);
                    command.Parameters.AddWithValue("@DataDatetime", monthFirstDate);
                    command.Parameters.AddWithValue("@OperatingIncomeCurrentMonth", model.OperatingIncomeCurrentMonth);
                    command.Parameters.AddWithValue("@OperatingIncomeLastMonth", model.OperatingIncomeLastMonth);
                    command.Parameters.AddWithValue("@OperatingIncomeLastYearCurrentMonth", model.OperatingIncomeLastYearCurrentMonth);
                    command.Parameters.AddWithValue("@OperatingIncomeComparativeLastMonth", model.OperatingIncomeComparativeLastMonth);
                    command.Parameters.AddWithValue("@OperatingIncomeComparativeLastYearCurrentMonth", model.OperatingIncomeComparativeLastYearCurrentMonth);
                    command.Parameters.AddWithValue("@CumulativeOperatingIncomeCurrentMonth", model.CumulativeOperatingIncomeCurrentMonth);
                    command.Parameters.AddWithValue("@CumulativeOperatingIncomeLastYearCurrentMonth", model.CumulativeOperatingIncomeLastYearCurrentMonth);
                    command.Parameters.AddWithValue("@CumulativeOperatingIncomeComparative", model.CumulativeOperatingIncomeComparative);
                    command.Parameters.AddWithValue("@Note", model.Note);

                    try
                    {
                        connection.Open();

                        // 执行存储过程并获取返回值
                        var reader = command.ExecuteReader();
                        int returnValue = 0;
                        while (reader.Read())
                        {
                            returnValue = reader.GetInt32(0);
                        }

                        if (returnValue == 1)
                        {
                            addResult = true;
                            Console.WriteLine("Insert successful.");
                        }
                        else
                        {
                            Console.WriteLine("Insert failed.");
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Error executing stored procedure: " + ex.Message);
                    }
                }
            }

            return addResult;
        }
    }
}
