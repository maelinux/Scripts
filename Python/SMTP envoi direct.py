import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart


smtp_server = 'smtp.office365.com'
smtp_port = 587
from_email = 'adresse@mail.soure'  
to_email = 'adresse@mail.soure'  


msg = MIMEMultipart()
msg['From'] = from_email
msg['To'] = to_email
msg['Subject'] = 'Test de configuration SMTP'

body = 'test'
msg.attach(MIMEText(body, 'plain'))


try:
    server = smtplib.SMTP(smtp_server, smtp_port)
    server.starttls()  # Démarrer TLS si nécessaire
    server.sendmail(from_email, to_email, msg.as_string())
    server.quit()
    print('Email envoyé avec succès')
except Exception as e:
    print(f'Erreur: {e}')
