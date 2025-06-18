using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;

namespace Quan_Ly_Cua_Hang_Do_An_Vat
{
    internal class DataProvider
    {
        private string connectionStr = "Data Source=LAPTOP-N9S3AN7U;Initial Catalog=QLCHAV;Integrated Security=True";
        public DataTable ExcuteQuery(string query, object[] param = null)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionStr))
            {
                conn.Open();
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = query;

                if (param != null)
                {
                    string[] listParam = query.Split(' ');
                    int i = 0;
                    foreach (var item in listParam)
                    {
                        if (item.Contains('@'))
                        {
                            cmd.Parameters.AddWithValue(item, param[i]);
                            i++;
                        }
                    }
                }
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                adapter.Fill(dt);
                conn.Close();
            }
            return dt;
        }
        public int ExcuteNonQuery(string query, object[] param = null)
        {
            int dt = 0;
            using (SqlConnection conn = new SqlConnection(connectionStr))
            {
                conn.Open();
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = query;

                if (param != null)
                {
                    string[] listParam = query.Split(' ');
                    int i = 0;
                    foreach (var item in listParam)
                    {
                        if (item.Contains('@'))
                        {
                            cmd.Parameters.AddWithValue(item, param[i]);
                            i++;
                        }
                    }
                }
                dt = cmd.ExecuteNonQuery();
                conn.Close();
            }
            return dt;
        }
        public object ExcuteScalar(string query, object[] param = null)
        {
            object dt = 0;
            using (SqlConnection conn = new SqlConnection(connectionStr))
            {
                conn.Open();
                SqlCommand cmd = conn.CreateCommand();
                if (param != null)
                {
                    string[] listParam = query.Split(' ');
                    int i = 0;
                    foreach (var item in listParam)
                    {
                        if (item.Contains('@'))
                        {
                            cmd.Parameters.AddWithValue(item, param[i]);
                            i++;
                        }
                    }
                }
                dt = cmd.ExecuteScalar();
                conn.Close();
            }
            return dt;
        }
    }
}
