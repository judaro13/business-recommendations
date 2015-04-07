rails generate model user yid:string name:string review_count:integer average_stars:float  votes:integer  friends:string compliments:string fans:integer

rails generate  model business  yid:string name:string neighborhoods:string  full_address:string city:string state:string  stars:float review_count:integer categories:string  open:boolean hours:string yattributes:string

rails generate model review business_id:string user_id:string stars:float text:text date:string votes:string

rails generate  model tip text:text  business_id:string user_id:string date:string likes:integer