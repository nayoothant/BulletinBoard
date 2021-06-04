module Messages
    
    #messages for login validations
    EMAIL_AND_PASSWORD_REQUIRE_VALIDATION = "Both Email and Password are required"
    EMAIL_REQUIRE_VALIDATION = "Email is required"
    PASSWORD_REQUIRE_VALIDATION = "Password is required"
    SUCCESSFUL_LOG_IN = "Logged in successfully!"
    INVALID_EMAIL_OR_PASSWORD = "Email or password is invalid"
    SUCCESSFUL_SIGN_UP = "Signed up successfully!"

    #messages for post csv validations
    REQUIRE_FILE_VALIDATION = "Please select a file"  
    INCORRECT_HEADER_VALIDATION = "The Header is incorrect"
    UPLOAD_SUCCESSFUL = "CSV file is uploaded successfully"
    WRONG_HEADER = "The header is wrong"
    WRONG_COLUMN = "The Column is wrong"
    WRONG_FILE_TYPE = "Please select CSV file"

    #messages for user validations
    CREATE_SUCCESSFUL = "User is created successfully"
    INCORRECT_PASSWORD = "The Password is incorrect"
    INCORRECT_PASSWORD_CONFIRM = "New password confirmation is not matched"

    #messages for password reset validations
    EMAIL_IS_SENT = "Email sent with password reset instructions."
    USER_NOT_EXIST = "The user does not exist"
    PASSWORD_RESET_EXPIRED = "Password reset has expired."
    PASSWORD_RESET_NOT_MATCH = "Passwords are not match."
    RESET_PASSWORD = "Password has been reset!"

end