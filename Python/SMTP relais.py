import smtplib
from email.mime.text import MIMEText

def send_test_email():

    smtp_server = 'smtp.office365.com'
    smtp_port = 25
    from_email = 'test@cgroupe.bzh'  
    to_email = 'support@connecs-informatique.fr'  
    username = 'test@cgroupe.bzh'  
    password = 'MDP'  
    subject = 'Test envoi SMTP'
    body = 'test'


    msg = MIMEText(body)
    msg['Subject'] = subject
    msg['From'] = from_email
    msg['To'] = to_email

    try:

        server = smtplib.SMTP(smtp_server, smtp_port)
        server.ehlo()
        server.starttls()
        server.ehlo()
        server.login(username, password)

        server.sendmail(from_email, to_email, msg.as_string())
        print('mail envoyé')
    except Exception as e:
        print(f'erreur envoi mail')
    finally:
        server.quit()

if __name__ == '__main__':
    send_test_email()
