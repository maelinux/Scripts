import smtplib
from email.mime.text import MIMEText

# Configuration du serveur SMTP
smtp_server = "smtp.gmail.com" #"smtp.office365.com"
smtp_port = 465
from_address = "adresse@mail.soure"
to_address = "adresse@mail.dest"

# Création du message
msg = MIMEText("test envoi direct + TLS")
msg["Subject"] = "Test Envoi Direct TLS"
msg["From"] = from_address
msg["To"] = to_address

# Envoi de l'email
try:
    with smtplib.SMTP(smtp_server, smtp_port) as server:
        server.starttls()  # Initiate TLS
        server.sendmail(from_address, [to_address], msg.as_string())
    print("Email envoyé avec succès.")
except Exception as e:
    print(f"Erreur lors de l'envoi de l'email: {e}")
