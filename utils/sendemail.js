import fs from'fs';
import nodemailer from"nodemailer";
import multer from 'multer';
import dotenv from 'dotenv';
dotenv.config();

let upload = multer({ dest: "uploads/" })
const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST,
  port: process.env.SMTP_PORT,
  auth: {
    user: process.env.SMTP_USERNAME,
    pass: process.env.SMTP_PASSWORD
  }
});
transporter.verify().then(console.log).catch(console.error);

async function sendemails(emails, data) {
  let responses = [];
  let mails = [];
  let i = 0;
  const path = "uploads/";
  if (!emails || !data) {
    res.status(201).json("Please provide mail data");
  }
  const filenames = fs.readdirSync(path);
  const files = filenames.map(filename => fs.readFileSync(path + filename));
  const attachments = files.map(file => {
    return { filename: filenames[i++], content: file }
  });
  const from = process.env.SMTP_FROM;
  i = 0;
  mails = emails.map(to => transporter.sendMail({ from, to, subject: data[i].subject, html: data[i].body, attachments }));
  responses = await Promise.all(mails);
  return responses.length;
}

export {sendemails};