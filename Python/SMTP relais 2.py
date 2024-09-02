import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

def send_email():
    smtp_server = "smtp.gmail.com"
    smtp_port = 587
    smtp_username = "adresse@mail.soure"
    smtp_password = "MDP APPLICATION"
    
    from_email = "adresse@mail.soure"
    to_email = "adresse@mail.dest"
    subject = "Test de relais SMTP"
    body = "testtt"

    msg = MIMEMultipart()
    msg['From'] = from_email
    msg['To'] = to_email
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain'))

    try:
        
        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()

        
        server.login(smtp_username, smtp_password)

        
        server.sendmail(from_email, to_email, msg.as_string())
        
        
        server.quit()
        
        print("Email envoyé avec succès !")
    except Exception as e:
        print(f"Erreur lors de l'envoi de l'email : {e}")

if __name__ == "__main__":
    send_email()
