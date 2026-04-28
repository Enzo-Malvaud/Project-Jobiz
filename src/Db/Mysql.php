<?php
namespace App\Db;

class Mysql
{
    private string $dbName;
    private string $dbUser;
    private string $dbPassword;
    private string $dbPort;
    private string $dbHost;

    private ?\PDO $pdo = null;
    private static ?self $_instance = null;

        private function __construct()
    {
        $host = getenv("DB_HOST");
        $user = getenv("DB_USER");
        $pass = getenv("DB_PASSWORD");
        $name = getenv("DB_NAME");

    if (!$host) {
        // --- INFOS INFINITYFREE ---
        $this->dbHost     = 'sql100.infinityfree.com'; 
        $this->dbUser     = 'if0_41775281';      
        $this->dbPassword = 'kFln00FYn1';     
        $this->dbName     = 'if0_41775281_jobiz_db';   
        $this->dbPort     = '3306';
    } else {
        // --- INFOS DOCKER ---
        $this->dbHost     = $host;
        $this->dbUser     = $user;
        $this->dbPassword = $pass;
        $this->dbName     = $name;
        $this->dbPort     = getenv("DB_PORT") ?: '3306';
    }
    }

    public static function getInstance(): self
    {
        if (is_null(self::$_instance)) {
            self::$_instance = new self(); // Utiliser self() est plus propre
        }
        return self::$_instance;
    }

    public function getPDO(): \PDO
    {
        if (is_null($this->pdo)) {
            try {
                // On passe le USER et le PASSWORD au constructeur PDO, pas dans le DSN !
                $dsn = "mysql:host={$this->dbHost};port={$this->dbPort};dbname={$this->dbName};charset=utf8mb4";
                
                $this->pdo = new \PDO($dsn, $this->dbUser, $this->dbPassword, [
                    \PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION,
                    \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC
                ]);
            } catch (\PDOException $e) {
                // Si ça échoue ici, on a un message clair
                die("Erreur de connexion DB : " . $e->getMessage());
            }
        }
        return $this->pdo;
    }
}