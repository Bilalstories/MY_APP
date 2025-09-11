import '../models/category.dart';

// Sample category list for testing
final List<Category> categories = [
	Category(
		name: 'Aadhaar',
		iconUrl: '',
		services: [
			Service(name: 'New Aadhaar Enrollment', formUrl: '', fee: 50, fields: [
				{'key':'name','label':'Applicant name','type':'text'},
				{'key':'dob','label':'Date of Birth','type':'date'},
				{'key':'address','label':'Address','type':'multiline'},
			]),
			Service(name: 'Aadhaar Update', formUrl: '', fee: 30, fields: [
				{'key':'name','label':'Name on Aadhaar','type':'text'},
				{'key':'update_type','label':'What to update?','type':'select','options':['Name','Address','DOB','Mobile']},
				{'key':'details','label':'Details of correction','type':'multiline'},
			]),
			Service(name: 'Aadhaar PVC Card', formUrl: '', fee: 50, fields: [
				{'key':'aadhaar','label':'Aadhaar number','type':'text'},
			]),
			Service(name: 'Aadhaar Print', formUrl: '', fee: 10, fields: [
				{'key':'aadhaar','label':'Aadhaar number','type':'text'},
			]),
		],
	),
	Category(
		name: 'PAN',
		iconUrl: '',
		services: [
			Service(name: 'New PAN Card', formUrl: '', fee: 120, fields: [
				{'key':'name','label':'Applicant name','type':'text'},
				{'key':'dob','label':'Date of Birth','type':'date'},
			]),
			Service(name: 'PAN Correction', formUrl: '', fee: 120, fields: [
				{'key':'pan','label':'Existing PAN (if any)','type':'text'},
				{'key':'correction','label':'What needs correction?','type':'multiline'},
			]),
			Service(name: 'PAN Print', formUrl: '', fee: 20, fields: [
				{'key':'pan','label':'PAN number','type':'text'},
			]),
		],
	),
	Category(
		name: 'Ration',
		iconUrl: '',
		services: [
			Service(name: 'New Ration Card', formUrl: '', fee: 100, fields: [
				{'key':'head_name','label':'Head of family name','type':'text'},
				{'key':'members','label':'Number of family members','type':'number'},
			]),
			Service(name: 'Ration Card Update', formUrl: '', fee: 50, fields: [
				{'key':'update_type','label':'Update type','type':'select','options':['Add member','Remove member','Change address']},
				{'key':'details','label':'Details','type':'multiline'},
			]),
			Service(name: 'Ration Card Print', formUrl: '', fee: 20, fields: [
				{'key':'ration_no','label':'Ration card number','type':'text'},
			]),
		],
	),
	Category(
		name: 'PF',
		iconUrl: '',
		services: [
			Service(name: 'PF Withdrawal', formUrl: '', fee: 150, fields: [
				{'key':'epf','label':'EPF account number','type':'text'},
				{'key':'reason','label':'Reason for withdrawal','type':'multiline'},
			]),
			Service(name: 'PF KYC Update', formUrl: '', fee: 80, fields: [
				{'key':'kyc_field','label':'KYC field to update','type':'text'},
			]),
			Service(name: 'PF Passbook Print', formUrl: '', fee: 20, fields: [
				{'key':'epf','label':'EPF account number','type':'text'},
			]),
		],
	),
	Category(
		name: 'Health',
		iconUrl: '',
		services: [
			Service(name: 'Ayushman Card', formUrl: '', fee: 60, fields: [
				{'key':'name','label':'Name','type':'text'},
				{'key':'dob','label':'DOB','type':'date'},
			]),
			Service(name: 'Health Insurance', formUrl: '', fee: 200, fields: [
				{'key':'plan','label':'Preferred plan','type':'select','options':['Basic','Standard','Premium']},
			]),
		],
	),
	Category(
		name: 'Education',
		iconUrl: '',
		services: [
			Service(name: 'Scholarship Form', formUrl: '', fee: 30, fields: [
				{'key':'student_name','label':'Student name','type':'text'},
				{'key':'college','label':'College/Institute','type':'text'},
			]),
			Service(name: 'Marksheet Print', formUrl: '', fee: 20, fields: [
				{'key':'reg_no','label':'Registration number','type':'text'},
			]),
			Service(name: 'Certificate Correction', formUrl: '', fee: 50, fields: [
				{'key':'certificate','label':'Certificate name','type':'text'},
				{'key':'correction','label':'Correction details','type':'multiline'},
			]),
		],
	),
	Category(
		name: 'Voter',
		iconUrl: '',
		services: [
			Service(name: 'New Voter ID', formUrl: '', fee: 50, fields: [
				{'key':'name','label':'Full name','type':'text'},
				{'key':'address','label':'Address','type':'multiline'},
			]),
			Service(name: 'Voter ID Correction', formUrl: '', fee: 40, fields: [
				{'key':'correction','label':'What to correct?','type':'multiline'},
			]),
			Service(name: 'Voter ID Print', formUrl: '', fee: 10, fields: [
				{'key':'voter_no','label':'Voter number','type':'text'},
			]),
		],
	),
	Category(
		name: 'License',
		iconUrl: '',
		services: [
			Service(name: 'New License', formUrl: '', fee: 300, fields: [
				{'key':'name','label':'Name','type':'text'},
				{'key':'dob','label':'DOB','type':'date'},
			]),
			Service(name: 'License Renewal', formUrl: '', fee: 200, fields: [
				{'key':'license_no','label':'License number','type':'text'},
			]),
			Service(name: 'License Print', formUrl: '', fee: 30, fields: [
				{'key':'license_no','label':'License number','type':'text'},
			]),
		],
	),
	Category(
		name: 'Bank',
		iconUrl: '',
		services: [
			Service(name: 'New Account Opening', formUrl: '', fee: 100, fields: [
				{'key':'name','label':'Account holder name','type':'text'},
				{'key':'aadhar','label':'Aadhaar number','type':'text'},
			]),
			Service(name: 'Passbook Print', formUrl: '', fee: 20, fields: [
				{'key':'acc_no','label':'Account number','type':'text'},
			]),
			Service(name: 'Cheque Book Request', formUrl: '', fee: 30, fields: [
				{'key':'acc_no','label':'Account number','type':'text'},
				{'key':'cheques','label':'Number of leaves','type':'number'},
			]),
		],
	),
	Category(
		name: 'Scheme',
		iconUrl: '',
		services: [
			Service(name: 'PM Kisan Registration', formUrl: '', fee: 30, fields: [
				{'key':'farmer_name','label':'Farmer name','type':'text'},
				{'key':'land_area','label':'Land area (acre)','type':'number'},
			]),
			Service(name: 'PMAY Form', formUrl: '', fee: 40, fields: [
				{'key':'applicant_name','label':'Applicant name','type':'text'},
			]),
			Service(name: 'Pension Yojana', formUrl: '', fee: 50, fields: [
				{'key':'age','label':'Age','type':'number'},
				{'key':'pension_type','label':'Pension type','type':'select','options':['Old age','Disability','Widow']},
			]),
		],
	),
	Category(
		name: 'Mobile Recharge',
		iconUrl: '',
		services: [
			Service(name: 'Prepaid Recharge', formUrl: '', fee: 10),
			Service(name: 'Postpaid Bill Payment', formUrl: '', fee: 10),
		],
	),
	Category(
		name: 'Bill Payment',
		iconUrl: '',
		services: [
			Service(name: 'Electricity Bill', formUrl: '', fee: 10),
			Service(name: 'Water Bill', formUrl: '', fee: 10),
			Service(name: 'Gas Bill', formUrl: '', fee: 10),
		],
	),
    // --- New categories requested by user ---
	Category(
		name: 'Taxation',
		iconUrl: '',
		services: [
			Service(name: 'GST Registration', formUrl: '', fee: 1000, fields: [
				{'key':'business_name','label':'Business / Trade name','type':'text'},
				{'key':'pan','label':'PAN number','type':'text'},
				{'key':'address','label':'Business address','type':'multiline'},
			]),
			Service(name: 'Income Tax Filing', formUrl: '', fee: 1000, fields: [
				{'key':'assesse_name','label':'Assessee name','type':'text'},
				{'key':'pan','label':'PAN number','type':'text'},
				{'key':'fy','label':'Financial year','type':'text'},
			]),
			// PTRC/PTEC split into discrete actions per request
			Service(name: 'PTRC Registration', formUrl: '', fee: 250, fields: [
				{'key':'property_id','label':'Property / PTRC ID (if any)','type':'text'},
				{'key':'owner_name','label':'Owner name','type':'text'},
			]),
			Service(name: 'PTRC Payment', formUrl: '', fee: 100, fields: [
				{'key':'property_id','label':'Property ID','type':'text'},
				{'key':'amount','label':'Amount being paid','type':'number'},
			]),
			Service(name: 'PTRC Return', formUrl: '', fee: 150, fields: [
				{'key':'property_id','label':'Property ID','type':'text'},
				{'key':'reason','label':'Return reason/details','type':'multiline'},
			]),
			Service(name: 'PTEC Registration', formUrl: '', fee: 200, fields: [
				{'key':'entity_name','label':'Entity name','type':'text'},
				{'key':'id_no','label':'PTEC identifier (if any)','type':'text'},
			]),
			Service(name: 'PTEC Payment', formUrl: '', fee: 100, fields: [
				{'key':'ptec_id','label':'PTEC ID','type':'text'},
				{'key':'amount','label':'Amount','type':'number'},
			]),
		],
	),
	Category(
		name: 'Certificates',
		iconUrl: '',
		services: [
			Service(name: 'Birth Certificate', formUrl: '', fee: 1000, fields: [
				{'key':'child_name','label':'Child name','type':'text'},
				{'key':'dob','label':'Date of Birth','type':'date'},
				{'key':'place','label':'Place of birth','type':'text'},
			]),
			Service(name: 'Death Certificate', formUrl: '', fee: 500, fields: [
				{'key':'deceased_name','label':'Deceased name','type':'text'},
				{'key':'dod','label':'Date of death','type':'date'},
				{'key':'place','label':'Place of death','type':'text'},
			]),
			Service(name: 'Marriage Certificate', formUrl: '', fee: 4000, fields: [
				{'key':'spouse1','label':'Spouse 1 name','type':'text'},
				{'key':'spouse2','label':'Spouse 2 name','type':'text'},
				{'key':'marriage_date','label':'Marriage date','type':'date'},
			]),
		],
	),
	Category(
		name: 'Police Verification',
		iconUrl: '',
		services: [
			Service(name: 'Police Verification', formUrl: '', fee: 200, fields: [
				{'key':'applicant_name','label':'Applicant name','type':'text'},
				{'key':'address','label':'Address','type':'multiline'},
			]),
			Service(name: 'Police Clearance Certificate', formUrl: '', fee: 200, fields: [
				{'key':'applicant_name','label':'Applicant name','type':'text'},
				{'key':'passport_no','label':'Passport number (if any)','type':'text'},
			]),
			Service(name: 'Security Guard Verification', formUrl: '', fee: 300, fields: [
				{'key':'guard_name','label':'Guard name','type':'text'},
				{'key':'employer','label':'Employer details','type':'text'},
			]),
		],
	),
	Category(
		name: 'Local Taxes',
		iconUrl: '',
		services: [
			Service(name: 'House Tax (Ghar Tax)', formUrl: '', fee: 100, fields: [
				{'key':'property_id','label':'Property ID','type':'text'},
				{'key':'owner_name','label':'Owner name','type':'text'},
			]),
			Service(name: 'Water Tax (Nal Tax)', formUrl: '', fee: 50, fields: [
				{'key':'connection_no','label':'Connection / consumer number','type':'text'},
				{'key':'amount','label':'Amount','type':'number'},
			]),
		],
	),
	Category(
		name: 'Bond / Affidavit',
		iconUrl: '',
		services: [
			Service(name: 'Bond / Affidavit', formUrl: '', fee: 300, fields: [
				{'key':'applicant_name','label':'Applicant name','type':'text'},
				{'key':'purpose','label':'Purpose / short description','type':'multiline'},
			]),
			Service(name: 'Bond / Affidavit with Notary', formUrl: '', fee: 400, fields: [
				{'key':'applicant_name','label':'Applicant name','type':'text'},
				{'key':'purpose','label':'Purpose / short description','type':'multiline'},
			]),
		],
	),
];

