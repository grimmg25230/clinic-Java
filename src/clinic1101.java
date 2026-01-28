import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

//import com.mysql.cj.xdevapi.PreparableStatement;

import java.sql.Statement;

//import java.nio.charset.StandardCharsets;

public class clinic1101 {
    private static final String URL = "jdbc:mysql://localhost:3306/1141029_clinic";
    private static final String USER = "root";
    private static final String PASSWORD = "84447521";

    public static void main(String[] args) {
        // ? 使用 UTF-8 Scanner（避免中文輸入亂碼）
        Scanner scanner=new Scanner(System.in,"BIG5");
        Connection conn = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            
            System.out.println("? MySQL 連線成功！");

            while (true) {
                System.out.println("\n請選擇操作:");
                System.out.println("0 - 退出");
                System.out.println("1 - 預約看診日期");
                System.out.println("2 - 新增醫師");
                System.out.println("3 - 查看醫師");
                System.out.println("4 - 查看病人");
                System.out.println("5 - 查看預約狀況");
                System.out.println("6 - 更改預約狀況");
                System.out.println("7 - 新增病例");
                System.out.println("8 - 查看付款明細及狀況");
                System.out.println("9 - 更改付款狀況");
                System.out.print("輸入選項: ");
                String choice = scanner.nextLine();

                if ("0".equals(choice)) {
                    System.out.println("退出程式");
                    break;
                
                } else if ("1".equals(choice)){
                    System.out.print("輸入身分證(ex:A123456789): ");
                    PreparedStatement ps = conn.prepareStatement("SELECT patient_id FROM patients WHERE national_id = ?");
                    String national_id = scanner.nextLine();
                    ps.setString(1, national_id);
                    ResultSet rs = ps.executeQuery();
                    int a_id = -1;
                    
                    /*if(rs.next()){
                        count = rs.getInt(1);
                    }*/
                    if (rs.next()) {
                        a_id = rs.getInt("patient_id");
                        System.out.println("? 病人已存在 , ID = " + a_id);
                    } else {
                        System.out.println("?查無此人 請新增病人");
                        System.out.print("輸入姓名: ");
                        String p_name = scanner.nextLine();
                        System.out.print("輸入性別(M/F): ");
                        String p_gender = scanner.nextLine();
                        System.out.print("輸入生日(ex:1999-12-30): ");
                        String p_date = scanner.nextLine();
                        System.out.print("輸入電話(ex:09xxxxxxxx): ");
                        String p_phone = scanner.nextLine();

                        // 單一 SQL 自動 +1 插入
                        String insertSQL = "INSERT INTO patients (national_id, name, gender, birth_date, phone) VALUES (?, ?, ?, ?, ?)";
                        try (PreparedStatement pstmt = conn.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS)) {
                            pstmt.setString(1, national_id);
                            pstmt.setString(2, p_name);
                            pstmt.setString(3, p_gender);
                            pstmt.setString(4, p_date);
                            pstmt.setString(5, p_phone);
                            int rows = pstmt.executeUpdate();
                            System.out.println("病人新增成功，共 " + rows + " 筆資料。");

                            ResultSet keyRs = pstmt.getGeneratedKeys();
                            if (keyRs.next()) {
                                a_id = keyRs.getInt(1);
                                System.out.println("? 新病人 patient_id = " + a_id);
                            } else {
                                System.out.println("? ERROR: 沒取得 patient_id (新增失敗)");
                                return; // 中止程式避免錯誤
                            }
                        }                        
                    }
                    System.out.println("陳醫師(內科):1  林醫師(外科):2");
                    System.out.print("預約醫師: ");
                    String a_doctor = scanner.nextLine();
                    //String a_patient = "1";

                    System.out.print("預約日期(ex:1999-01-01): ");  //格式01-01?
                    String a_date = scanner.nextLine();
                    String insertSQL = "INSERT INTO appointments (patient_id, doctor_id, appointment_date) VALUES (?, ?, ?)";
                    try (PreparedStatement pstmt = conn.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS)) {
                        pstmt.setInt(1, a_id);  //連接外面層級
                        pstmt.setInt(2, Integer.parseInt(a_doctor));
                        pstmt.setString(3, a_date);
                        pstmt.executeUpdate();
                    }
                    System.out.println("預約成功");
                
                } else if ("2".equals(choice)) {
                    System.out.print("輸入醫姓名: ");
                    String d_name = scanner.nextLine();
                    System.out.print("輸入科別(ex:內科): ");
                    String d_specialty = scanner.nextLine();
                    System.out.print("輸入執照號(ex:D0001): ");
                    String d_license = scanner.nextLine();


                    // 單一 SQL 自動 +1 插入  其他欄位改成非必填就可以只填入序號跟姓名
                    // 新增病人資料
                    String insertSQL = "INSERT INTO doctors (name, specialty, license_no) VALUES (?, ?, ?)";
                
                    try (PreparedStatement pstmt = conn.prepareStatement(insertSQL)) {
                        pstmt.setString(1, d_name);
                        pstmt.setString(2, d_specialty);
                        pstmt.setString(3, d_license);  //順序D000X
                        int rows = pstmt.executeUpdate();
                        System.out.println("新增成功，共 " + rows + " 筆資料。");
                    }

                } else if ("3".equals(choice)) {
                    String querySQL = "SELECT doctor_id, name, specialty, license_no FROM doctors";
                    try (PreparedStatement pstmt = conn.prepareStatement(querySQL);
                            ResultSet rs = pstmt.executeQuery()) {
                        System.out.println("所有醫師列表:");
                        java.sql.ResultSetMetaData meta = rs.getMetaData();
                        int columnCount = meta.getColumnCount();
                        //讀取結果
                        System.out.println("");
                        while (rs.next()) {
                            for (int i = 1; i <= columnCount; i++) {
                                System.out.print(rs.getString(i) + "\t");
                            }
                            System.out.println();
                        }

                    }
                
                } else if ("4".equals(choice)) {
                    String querySQL = "SELECT patient_id, national_id, name, gender, birth_date, phone FROM patients";
                    try (PreparedStatement pstmt = conn.prepareStatement(querySQL);
                            ResultSet rs = pstmt.executeQuery()) {
                        System.out.println("所有客戶列表:");
                        java.sql.ResultSetMetaData meta = rs.getMetaData();
                        int columnCount = meta.getColumnCount();
                        //讀取結果
                        System.out.println("");
                        while (rs.next()) {
                            for (int i = 1; i <= columnCount; i++) {
                                System.out.print(rs.getString(i) + "\t");
                            }
                            System.out.println();
                        }

                    }
                } else if ("5".equals(choice)){
                    String sql = "select * from report01";

                    PreparedStatement pstmt_rp01 = conn.prepareStatement(sql);
                    ResultSet rs = pstmt_rp01.executeQuery();

                    java.sql.ResultSetMetaData meta = rs.getMetaData();
                    int columnCount = meta.getColumnCount();
                    // 讀取結果
                    while (rs.next()) {
                    for (int i = 1; i <= columnCount ; i++) {
                        System.out.print(rs.getString(i) + "\t");
                    }
                    System.out.println();
                    }

                } else if ("6".equals(choice)){
                    System.out.print("輸入身分證(ex:A100000001): ");
                    String national_id = scanner.nextLine();
                    PreparedStatement ps = conn.prepareStatement("SELECT patient_id FROM patients WHERE national_id = ?");
                    ps.setString(1, national_id);
                    ResultSet rs = ps.executeQuery();
                    int a_id = -1;
                    if (rs.next()) {
                        a_id = rs.getInt("patient_id");
                        //System.out.println(" 序號ID = " + a_id);
                    } else {
                        System.out.println("?查無此人 請新增病人");
                        return; // 中止程式避免錯誤
                    }

                    System.out.print("輸入日期(ex:1999-01-01): ");
                    String a_date = scanner.nextLine();
                    //System.out.println(a_date);
                    //判斷病人是否在這天有預約
                    PreparedStatement ps2 = conn.prepareStatement("SELECT appointment_id, status FROM appointments WHERE appointment_date = ? AND patient_id = ?");
                    ps2.setString(1, a_date);
                    ps2.setInt(2, a_id);
                    ResultSet rs2 = ps2.executeQuery();
                    if (!rs2.next()) {
                        System.out.println("查無此人預約");
                        return; // 中止程式避免錯誤

                    }

                    int appId = rs2.getInt("appointment_id");
                    String oldStatus = rs2.getString("status");
                    System.out.println(" 找到預約: appointment_id = " + appId + " 目前狀態 = " + oldStatus);

                    //更新status

                    System.out.print("請輸入更新後狀態 (已預約/已看診/取消): ");
                    String newStatus = scanner.nextLine();
                    String updateSQL = "UPDATE appointments SET status = ? WHERE appointment_id = ?";
                    try (PreparedStatement pstmt = conn.prepareStatement(updateSQL)) {
                        pstmt.setString(1, newStatus);
                        pstmt.setInt(2, appId);
                        int rows = pstmt.executeUpdate();
                        System.out.println("更新成功，共 " + rows + " 筆資料。");

                    } 
                } else if ("7".equals(choice)){
                    System.out.print("輸入身分證(ex:A100000001): ");
                    String national_id = scanner.nextLine();
                    PreparedStatement ps = conn.prepareStatement("SELECT patient_id FROM patients WHERE national_id = ?");
                    ps.setString(1, national_id);
                    ResultSet rs = ps.executeQuery();
                    int a_id = -1;
                    if (rs.next()) {
                        a_id = rs.getInt("patient_id");
                        //System.out.println(" 序號ID = " + a_id);
                    } else {
                        System.out.println("?查無此人 請新增病人");
                        return; // 中止程式避免錯誤
                    }

                    System.out.print("輸入日期(ex:1999-01-01): ");
                    String a_date = scanner.nextLine();
                    //System.out.println(a_date);
                    //判斷病人是否在這天有預約
                    PreparedStatement ps2 = conn.prepareStatement("SELECT appointment_id, status FROM appointments WHERE appointment_date = ? AND patient_id = ?");
                    ps2.setString(1, a_date);
                    ps2.setInt(2, a_id);
                    ResultSet rs2 = ps2.executeQuery();
                    if (!rs2.next()) {
                        System.out.println("查無此人預約");
                        return; // 中止程式避免錯誤

                    }

                    int appId = rs2.getInt("appointment_id");
                    String oldStatus = rs2.getString("status");
                    System.out.println(" 找到預約: appointment_id = " + appId + " 目前狀態 = " + oldStatus);

                    //新增看整資料

                    System.out.print("症狀: ");
                    String m_symptom = scanner.nextLine();
                    System.out.print("疫苗ID  ex(0:無 1:流感疫苗 2:A型肝炎 3:帶狀泡疹): ");
                    String m_vaccineid = scanner.nextLine();

                    //新增至SQL
                    PreparedStatement ps3 = conn.prepareStatement("INSERT INTO medical_records (appointment_id, symptoms, vaccine_id) VALUES (?, ?, ?)"
);
                    ps3.setInt(1, appId);
                    ps3.setString(2, m_symptom);    //症狀
                    ps3.setString(3, m_vaccineid);  //疫苗ID
                    ps3.executeUpdate();
                    System.out.println("看診紀錄已新增");
                    


                    PreparedStatement ps4 = conn.prepareStatement("UPDATE appointments SET status = '已看診' WHERE appointment_id = ?");
                    ps4.setInt(1, appId);
                    ps4.executeUpdate();
                    System.out.println("預約狀態已更新為『已看診』");

                    //產生帳單

                    int record_id = -1;     //假設-1去撈資料
                    int vaccine_id = 0;     //預設0沒打疫苗
                    PreparedStatement ps_billing = conn.prepareStatement("SELECT record_id, vaccine_id FROM medical_records WHERE appointment_id = ?");
                    ps_billing.setInt(1, appId);
                    ResultSet rs_billing = ps_billing.executeQuery();
                    

                    if(rs_billing.next()){
                        record_id = rs_billing.getInt("record_id");
                        vaccine_id = rs_billing.getInt("vaccine_id");
                        
                    } else {
                        System.out.println("查無此病例 , 無法建立帳單");
                        return; // 中止程式避免錯誤
                    }
                    
                    //找到疫苗價格
                    if (vaccine_id >= 0){
                        PreparedStatement ps_va_price = conn.prepareStatement("SELECT vaccine_price FROM vaccines WHERE vaccine_id = ?");
                        ps_va_price.setInt(1, vaccine_id);
                        ResultSet rs_va_price = ps_va_price.executeQuery();
                        System.out.println("準備建立帳單...");
                        if(rs_va_price.next()){
                            int va_price = rs_va_price.getInt("vaccine_price");

                            int registration_fee = 200;                 //掛號費
                            int total = registration_fee + va_price;    //總金額

                            PreparedStatement ps_bill = conn.prepareStatement("INSERT INTO billing (records_id, registration_fee, vaccine_fee, paid) VALUES (?, ?, ?, 0)", Statement.RETURN_GENERATED_KEYS);
                            ps_bill.setInt(1, record_id);
                            ps_bill.setInt(2, registration_fee);
                            ps_bill.setInt(3, va_price);
                            //ps_bill.setInt(4, total);                 //SQL自動加總 可以不用打上去
                            int rows = ps_bill.executeUpdate();
                            
                            if (rows > 0){
                                ResultSet rs_billId = ps_bill.getGeneratedKeys();
                                if (rs_billId.next()) {
                                int billing_id = rs_billId.getInt(1);
                                System.out.println(" 帳單已成功建立！");
                                System.out.println("帳單編號: " + billing_id);
                                System.out.println("病歷編號: " + record_id);
                                System.out.println("掛號費: " + registration_fee);
                                System.out.println("疫苗費: " + va_price);
                                System.out.println("總金額: " + total);
                                }
                            }
                            
                        }    

                    }

                    

                    

                } else if ("8".equals(choice)){
                    String querySQL = "SELECT bill_id, records_id, national_id, registration_fee, vaccine_fee, total, paid, created_at, updated_at FROM report07";
                    try (PreparedStatement pstmt = conn.prepareStatement(querySQL);
                            ResultSet rs = pstmt.executeQuery()) {
                        System.out.println("所有付費帳單:");
                        java.sql.ResultSetMetaData meta = rs.getMetaData();
                        int columnCount = meta.getColumnCount();
                        //讀取結果
                        System.out.println("");
                        while (rs.next()) {
                            for (int i = 1; i <= columnCount; i++) {

                                if(meta.getColumnLabel(i).equals("paid")){
                                    int paid = rs.getInt("paid");
                                    String status = (paid == 1) ? "已付款" : "未付款";
                                    System.out.print(status + "\t");
                                } else {
                                System.out.print(rs.getString(i) + "\t");
                                }
                            }
                            System.out.println();
                        }

                    }
                } else if ("9".equals(choice)){
                    System.out.print("輸入身分證(ex:A100000001): ");
                    String national_id = scanner.nextLine();
                    //int b_paid = 0;
                    //因為用view的關係,如果名稱改成中文,java會找不到,處理方法建立2個veiw,一個改中文名稱顯示用,一個用英文別名尋找改內容用
                    PreparedStatement ps = conn.prepareStatement("SELECT bill_id, paid FROM report06 WHERE national_id = ? AND paid = 0 ORDER BY bill_id DESC LIMIT 1");
                    ps.setString(1, national_id);
                    
                    ResultSet rs = ps.executeQuery();
                    if(!rs.next()) {
                        System.out.println("沒有未付款帳單");
                        return; // 中止程式避免錯誤
                    }

                    int billId = rs.getInt("bill_id");
                    System.out.println("未付款帳單,繳費單號" + billId + "號");

                    System.out.print("請輸入更新後狀態 已付=1 未付=0：");
                    int newStatus = scanner.nextInt();
                    scanner.nextLine();
                    
                    PreparedStatement ps2 = conn.prepareStatement("UPDATE billing SET paid = ? WHERE bill_id = ?");
                    ps2.setInt(1, newStatus);
                    ps2.setInt(2, billId);
                    
                    int rows = ps2.executeUpdate();
                    System.out.println("? 成功更新 " + rows + " 筆資料！付款狀態已修改");

                } else {
                    System.out.println("無效選項，請重新輸入！");
                }
            }

        } catch (SQLException e) {
            System.out.println("? 掛號失敗 SQL Debug:");
            e.printStackTrace();
        } finally {
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
            }
            scanner.close();
        }
    }
}
