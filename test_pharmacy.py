from pathlib import Path

SQL_FILE = Path(__file__).with_name("pharmacy.sql")

def read_sql():
    assert SQL_FILE.exists(), "pharmacy.sql does not exist"
    return SQL_FILE.read_text(encoding="utf-8").lower()

def test_pharmacy_table_created():
    sql = read_sql()
    assert "create table dbo.medicine" in sql
    assert "medicineid" in sql
    assert "medicinename" in sql
    assert "stock" in sql
    assert "expirydate" in sql

def test_expiring_before_2025():
    sql = read_sql()
    assert "expirydate < '2025-01-01'" in sql

def test_paracetamol_updated_to_80():
    sql = read_sql()
    assert "update dbo.medicine" in sql
    assert "set stock = 80" in sql
    assert "paracetamol" in sql

def test_inventory_ordered_by_expiry():
    sql = read_sql()
    assert "order by expirydate" in sql
