import smtplib

smtp_server = "cgroupe-bzh.mail.protection.outlook.com"

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
msg = MIMEMultipart()
msg['From'] = "connecs@cgroupe.bzh"
msg['To'] = "test@cgroupe.bzh"
msg['Subject'] = "Sujet du mail"

message = "Ceci est le corps du mail."
msg.attach(MIMEText(message, 'plain'))

server = smtplib.SMTP(smtp_server, 25)

text = msg.as_string()
server.sendmail("connecs@cgroupe.bzh", "test@cgroupe.bzh", text)

server.quit()
