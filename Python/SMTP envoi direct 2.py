import smtplib

smtp_server = "SMTP.SERVEUR.com"

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
msg = MIMEMultipart()
msg['From'] = "ADRESSE@MAIL.SOURCE"
msg['To'] = "ADRESSE@MAIL.DESTINATION"
msg['Subject'] = "Sujet du mail"

message = "Ceci est le corps du mail."
msg.attach(MIMEText(message, 'plain'))

server = smtplib.SMTP(smtp_server, 25)

text = msg.as_string()
server.sendmail("ADRESSE@MAIL.SOURCE", "ADRESSE@MAIL.DESTINATION", text)

server.quit()
