DO $$ 
DECLARE
    i INT;
    token TEXT;
    dynamic_image TEXT;
BEGIN
    dynamic_image := 'https://payx-s3.s3.ap-south-1.amazonaws.com/ocean.jpg';
    token := '{{token}}';

    -- Truncate all tables
    TRUNCATE TABLE ticket_category,ticket,faq,users, plan_history, teamrole, project, plan, product, plan_product, team_member, invite, task,task_member, campaign, template, type, tolist, tos, attachment, email,expense,category RESTART IDENTITY CASCADE;

    -- Insert data into the 'faq' table
    FOR i IN 1..10 LOOP
    INSERT INTO faq (question, answer, created_on, modified_on)
    VALUES
        ('Question ' || i, 'Answer ' || i, current_timestamp, current_timestamp);
    END LOOP;
	
	-- Insert data into the 'plan' table
    FOR i IN 1..3 LOOP
    INSERT INTO plan (name, description, price, created_on, modified_on)
    VALUES
        ('Plan' || i, 'Description ' || i, floor(random() * 1000) + 50, current_timestamp, current_timestamp);
    END LOOP;

    -- Insert data into the 'user' table
    FOR i IN 1..50 LOOP
    INSERT INTO users (id,name,email,address,profile_pic,token,passcode,plan_id,status,subscribed_on,unsubscribed_on,deleted_on, created_on, modified_on)
    VALUES
        (i,'shiva','shiva'||i||'@gmail.com','Address ' || i, dynamic_image,token,'1234',1,true, current_timestamp,null,null,current_timestamp, current_timestamp),
        (i+50,'shiva','shiva'||i+50||'@gmail.com','Address ' || i, dynamic_image,token,'1234',1,true, current_timestamp,null,null,current_timestamp, current_timestamp),
        (i+100,'shiva','shiva'||i+100||'@gmail.com','Address ' || i, dynamic_image,token,'1234',2,true, current_timestamp,null,null,current_timestamp, current_timestamp),
        (i+150,'shiva','shiva'||i+150||'@gmail.com','Address ' || i, dynamic_image,token,'1234',3,true, current_timestamp,null,null,current_timestamp, current_timestamp);
    END LOOP;

    -- Insert data into the 'plan_history' table
    FOR i IN 1..10 LOOP
        FOR j IN 1..3 LOOP
            INSERT INTO plan_history (user_id, plan_id, created_on, modified_on)
            VALUES(i+100,j, current_timestamp, current_timestamp);
        END LOOP;
    END LOOP;

    -- Insert data into the 'teamrole' table
    FOR i IN 1..10 LOOP
    INSERT INTO teamrole (name, created_on, modified_on)
    VALUES
        ('TeamRole' || i, current_timestamp, current_timestamp);
    END LOOP;

    -- Insert data into the 'project' table
    FOR i IN 1..50 LOOP
    INSERT INTO project (name, description, creator_id, created_on, modified_on)
    VALUES
        ('Project' || i, 'Description ' || i,(i%10)+101, current_timestamp, current_timestamp);
    END LOOP;

    -- Insert data into the 'team' table
    FOR i IN 1..5 LOOP
        FOR j IN 1..50 LOOP
            INSERT INTO team (name,type,creator_id, project_id, created_on, modified_on)
            VALUES ('Team' || j, 'Type' || i, j, j, current_timestamp, current_timestamp);
        END LOOP;
    END LOOP;

    -- Insert data into the 'product' table
    FOR i IN 1..30 LOOP
    INSERT INTO product (name, description, price, created_on, modified_on)
    VALUES
        ('Product' || i, 'Description ' || i, floor(random() * 100) + 20, current_timestamp, current_timestamp);
    END LOOP;

    -- Insert data into the 'plan_product' table
    FOR i IN 1..10 LOOP
    INSERT INTO plan_product (plan_id, product_id, created_on, modified_on)
    VALUES
        (1,i, current_timestamp, current_timestamp),
        (2,2*i, current_timestamp, current_timestamp),
        (3,3*i, current_timestamp, current_timestamp);
    END LOOP;

    -- Insert data into the 'team_member' table
    FOR i IN 1..10 LOOP
        FOR j IN 1..50 LOOP
            INSERT INTO team_member (user_id, team_id,project_id, created_on, modified_on, teamrole_id)
            VALUES (i+100,j,j, current_timestamp, current_timestamp, floor(random() * 10) + 1);
        END LOOP;
    END LOOP;

    -- Insert data into the 'invite' table
    FOR i IN 1..50 LOOP
    INSERT INTO invite (email, joined, team_id, created_on, modified_on)
    VALUES
        ('invite' || i || '@example.com', false,i, current_timestamp, current_timestamp);
    END LOOP;

    -- Insert data into the 'task' table
    FOR i IN 1..50 LOOP
    INSERT INTO task (name, description, start_time, end_time, status, team_id,project_id, created_on, modified_on)
    VALUES
        ('Task' || i, 'Description ' || i, current_timestamp, current_timestamp, 'NEW',i,i, current_timestamp, current_timestamp),
        ('Task' || i, 'Description ' || i, current_timestamp, current_timestamp, 'ONCOMING',i,i, current_timestamp, current_timestamp),
        ('Task' || i, 'Description ' || i, current_timestamp, current_timestamp, 'COMPLETED',i,i, current_timestamp, current_timestamp);
    END LOOP;

    -- Insert data into the 'taskmember' table
    FOR i IN 1..50 LOOP
        FOR j IN 1..10 LOOP
            INSERT INTO task_member (task_id, team_member_id, created_on, modified_on)
            VALUES
            (i,j, current_timestamp, current_timestamp);
        END LOOP;
    END LOOP;

	-- Insert data into the 'ticket_category' table
    FOR i IN 1..10 LOOP
    INSERT INTO ticket_category (name, created_on, modified_on)
    VALUES
        ('Category' || i, current_timestamp, current_timestamp);
    END LOOP;

    -- Insert data into the 'ticket' table
    FOR i IN 1..50 LOOP
    INSERT INTO ticket (title, description, status, category_id,user_id,project_id, created_on, modified_on)
    VALUES
        ('Ticket' || i, 'Description ' || i, 'OPEN', floor(i % 10) + 1,floor(i % 10)+101,i, current_timestamp, current_timestamp),
        ('Ticket' || i, 'Description ' || i, 'CLOSED', floor(i % 10) + 1,floor(i % 10)+101,i, current_timestamp, current_timestamp);
    END LOOP;


    --Expense----------------------------------

    -- Insert data into the 'expense_category' table
    INSERT INTO category (name, created_on, modified_on)
    VALUES
        ('Fixed Expenses', current_timestamp, current_timestamp),
        ('Variable Expenses', current_timestamp, current_timestamp),
        ('Transportation', current_timestamp, current_timestamp);

    INSERT INTO budget (title, description, amount, currency, symbol, period,image, priority, project_id, creator_id, created_on) 
    VALUES
        ('Digital Marketing Campaign', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 1, 101, current_timestamp),
        ('Social Media Ad Spend', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 2, 102, current_timestamp),
        ('Influencer Partnership Funds', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 3, 103, current_timestamp),
        ('Content Creation Expenses', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 4, 104, current_timestamp),
        ('Email Marketing', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 5, 105, current_timestamp),
        ('SEO Optimization Costs', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 6, 101, current_timestamp),
        ('PPC Advertising', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 7, 101, current_timestamp),
        ('Website Development', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 8, 101, current_timestamp),
        ('Video Production Expenses', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 9, 101, current_timestamp),
        ('Graphic Design Costs', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 10, 101, current_timestamp),
        ('Facebook Ad Campaign', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 11, 101, current_timestamp),
        ('Instagram Influencer Collaboration Funds', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 12, 101, current_timestamp),
        ('Blog Post Promotion', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 13, 101, current_timestamp),
        ('Podcast Sponsorship', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 14, 101, current_timestamp),
        ('Event Marketing Expenses', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 15, 101, current_timestamp),
        ('Webinar Production Costs', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 16, 101, current_timestamp),
        ('LinkedIn Advertising', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 17, 101, current_timestamp),
        ('Twitter Engagement', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 18, 101, current_timestamp),
        ('Pinterest Promoted Pins', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 19, 101, current_timestamp),
        ('TikTok Influencer Partnership Funds', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 20, 101, current_timestamp),
        ('Snapchat Geofilter Campaign', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 21, 101, current_timestamp),
        ('YouTube Ad Spend', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 22, 101, current_timestamp),
        ('Display Advertising', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 23, 101, current_timestamp),
        ('Mobile App Install Campaign', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 24, 101, current_timestamp),
        ('Affiliate Marketing Costs', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 25, 101, current_timestamp),
        ('SMS Marketing', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 26, 101, current_timestamp),
        ('Influencer Gift', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 27, 101, current_timestamp),
        ('User-Generated Content Incentives', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 28, 101, current_timestamp),
        ('PR Outreach Expenses', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 29, 101, current_timestamp),
        ('Brand Ambassador Program Costs', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 30, 101, current_timestamp),
        ('Community Management', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 31, 101, current_timestamp),
        ('Brand Partnership Funds', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 32, 101, current_timestamp),
        ('Virtual Event Production Costs', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 33, 101, current_timestamp),
        ('Augmented Reality Campaign', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 34, 101, current_timestamp),
        ('Native Advertising Expenses', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 35, 101, current_timestamp),
        ('Interactive Content Development', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 36, 101, current_timestamp),
        ('Gamification Campaign Funds', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 37, 101, current_timestamp),
        ('AR Filters Development', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 38, 101, current_timestamp),
        ('VR Experience Production Costs', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 39, 101, current_timestamp),
        ('Loyalty Program Rewards', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 40, 101, current_timestamp),
        ('Customer Retention Incentives', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 41, 101, current_timestamp),
        ('Lead Generation Campaign', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 42, 101, current_timestamp),
        ('Omnichannel Marketing Costs', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 43, 101, current_timestamp),
        ('Customer Acquisition', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 44, 101, current_timestamp),
        ('Niche Market Campaign Funds', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 45, 101, current_timestamp),
        ('Localized Marketing Expenses', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 46, 101, current_timestamp),
        ('Seasonal Promotion', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 47, 101, current_timestamp),
        ('Product Launch Marketing Costs', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 48, 101, current_timestamp),
        ('Market Research and Analysis', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 49, 101, current_timestamp),
        ('Competitive Intelligence Expenses', 'Description for Budget', 1000000, 'DOLLAR', '$', 'MONTHLY',dynamic_image, 1, 50, 101, current_timestamp);

    -- Insert data into the 'expense' table
    FOR j IN 1..50 LOOP
        INSERT INTO expense (note, amount,currency,type,transaction_id,payment_method,budget_id, project_id,category_id, created_on)
        VALUES
        ('Rent',10000,'INR','CREDIT','1','CASH',j,j,1, current_timestamp),
        ('Insurance Premiums',10000,'INR','CREDIT','1','UPI',j,j,1, current_timestamp),
        ('Loan Payment',10000,'INR','CREDIT','1','ONLINE',j,j,1, current_timestamp),
        ('Groceries',10000,'INR','CREDIT','1','ONLINE',j,j,2, current_timestamp),
        ('Utilities',10000,'INR','CREDIT','1','ONLINE',j,j,2, current_timestamp),
        ('Entertainment',10000,'INR','CREDIT','1','ONLINE',j,j,2, current_timestamp),
        ('Fuel',10000,'INR','CREDIT','1','ONLINE',j,j,3, current_timestamp),
        ('Maintenance',10000,'INR','CREDIT','1','ONLINE',j,j,3, current_timestamp),
        ('Public Transport',10000,'INR','CREDIT','1','ONLINE',j,j,3, current_timestamp);
    END LOOP;




    --Mail-----------------------------------------------

    -- -- Insert data into the 'template' table
    -- FOR i IN 1..50 LOOP
    -- INSERT INTO template (name, sender, subject, body, created_on, modified_on)
    -- VALUES
    --     ('Template' || i, 'from@example.com', 'Subject ' || i, 'Body ' || i, current_timestamp, current_timestamp);
    -- END LOOP;
    -- -- Insert data into the 'type' table
    -- FOR i IN 1..10 LOOP
    -- INSERT INTO type (name, description, created_on, modified_on)
    -- VALUES
    --     ('Type' || i, 'Description ' || i, current_timestamp, current_timestamp);
    -- END LOOP;

    -- -- Insert data into the 'tolist' table
    -- FOR i IN 1..10 LOOP
    -- INSERT INTO tolist (name, created_on, modified_on)
    -- VALUES
    --     ('ToList' || i, current_timestamp, current_timestamp);
    -- END LOOP;

    -- -- Insert data into the 'to' table
    -- FOR i IN 1..50 LOOP
    -- INSERT INTO tos (name, email, tolist_id)
    -- VALUES
    --     ('To' || i, 'to' || i || '@example.com', floor(random() * 10) + 1);
    -- END LOOP;

	-- -- Insert data into the 'campaign' table
    -- FOR i IN 1..50 LOOP
    -- INSERT INTO campaign (name, type_id, template_id, tolist_id, user_id, created_on, modified_on)
    -- VALUES
    --     ('Campaign' || i, floor(random() * 10) + 1, floor(random() * 50) + 1, floor(random() * 10) + 1, floor(random() * 100) + 1, current_timestamp, current_timestamp);
    -- END LOOP;

    -- -- Insert data into the 'email' table
    -- FOR i IN 1..50 LOOP
    -- INSERT INTO email (sender, subject, body, receiver, campaign_id, sentat)
    -- VALUES
    --     ('from@example.com', 'Subject ' || i, 'Body ' || i, 'to@example.com', floor(random() * 50) + 1, current_timestamp);
    -- END LOOP;
	
    -- -- Insert data into the 'attachment' table
    -- FOR i IN 1..50 LOOP
    -- INSERT INTO attachment (name, url, type, size, email_id)
    -- VALUES
    --     ('Attachment' || i, 'url' || i, 'Type' || i, floor(random() * 100) + 50, floor(random() * 50) + 1);
    -- END LOOP;

END $$;