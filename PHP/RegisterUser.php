<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <body>
        <?php
        $scriptName = "RegisterUser.php";
        include("PHPprinter.php");
        include("DBQueries.php");
        $startTime = getMicroTime();
        $DBQueries = new DBQueries();

        function post_or_get($index, $description) {
            if (isset($_POST[$index])) {
                return $_POST[$index];
            } else if (isset($_GET[$index])) {
                return $_GET[$index];
            } else {
                printError($scriptName, $startTime, "Register user", "You must provide a $description!<br>");
                exit();
            }
        }

        $firstname = post_or_get('firstname', 'first name');
        $lastname = post_or_get('lastname', 'last name');
        $nickname = post_or_get('nickname', 'nick name');
        $email = post_or_get('email', 'email address');
        $password = post_or_get('password', 'password');
        $region = post_or_get('region', 'region');

        $regionId = $DBQueries->selectRegionIdWhereName($region);

        if ($regionId == -1) {
            printError($scriptName, $startTime, "Register user","Region $region does not exist in the database!<br>\n");
            exit();
        }

        // Check if the nick name already exists
        if ($DBQueries->doesNicknameExist($nickname) > 0) {
            printError($scriptName, $startTime, "Register user", "The nickname you have choosen is already taken by someone else. Please choose a new nickname.<br>\n");
            exit();
        }

        // Add user to database
        $DBQueries->insert_users($firstname, $lastname, $nickname, $password, $email, $regionId);
        
        $result = $DBQueries->selectUserByNickname($nickname);
        $row = $result[0];
        

        printHTMLheader("RUBiS: Welcome to $nickname");
        print("<h2>Your registration has been processed successfully</h2><br>\n");
        print("<h3>Welcome $nickname</h3>\n");
        print("RUBiS has stored the following information about you:<br>\n");
        print("First Name: " . $row["firstname"] . "<br>\n");
        print("Last Name: " . $row["lastname"] . "<br>\n");
        print("Nick Name: " . $row["nickname"] . "<br>\n");
        print("Email: " . $row["email"] . "<br>\n");
        print("Password: " . $row["password"] . "<br>\n");
        print("Region: $region<br>\n");
        print("<br>The following information has been automatically generated by RUBiS:<br>\n");
        print("User id: " . $row["id"] . "<br>\n");
        print("Creation date: " . $row["creation_date"] . "<br>\n");
        print("Rating: " . $row["rating"] . "<br>\n");
        print("Balance: " . $row["balance"] . "<br>\n");

        $DBQueries = null;

        printHTMLfooter($scriptName, $startTime);
        ?>
    </body>
</html>