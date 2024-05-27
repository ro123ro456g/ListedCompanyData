namespace ListedCompanyDataWebApi.Model
{
    public class InsertSummaryMonthlyIncomeInputModel
    {
        public string CompanyId { get; set; }

        public DateTime DataDatetime { get; set; }

        public decimal? OperatingIncomeCurrentMonth { get; set; }

        public decimal? OperatingIncomeLastMonth { get; set; }

        public decimal? OperatingIncomeLastYearCurrentMonth { get; set; }

        public decimal? OperatingIncomeComparativeLastMonth { get; set; }

        public decimal? OperatingIncomeComparativeLastYearCurrentMonth { get; set; }

        public decimal? CumulativeOperatingIncomeCurrentMonth { get; set; }

        public decimal? CumulativeOperatingIncomeLastYearCurrentMonth { get; set; }

        public decimal? CumulativeOperatingIncomeComparative { get; set; }

        public string Note { get; set; }
    }
}
