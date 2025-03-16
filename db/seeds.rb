# db/seeds.rb

require 'securerandom'

# -------------------------------------
# 1) Create Users (along with roles)
# -------------------------------------
# admin_user = User.find_or_create_by!(email: 'davidvanderklay@tamu.edu') do |u|
#   u.name     = 'Admin User'
#   u.provider = 'google_oauth2'
#   u.uid      = '123' # A real UID in a real app
# end
#
# faculty_user = User.find_or_create_by!(email: 'davidvanderklay@gmail.com') do |u|
#   u.name     = 'Faculty User'
#   u.provider = 'google_oauth2'
#   u.uid      = '456'
# end
#
# student_user = User.find_or_create_by!(email: 'georgelantin@gmail.com') do |u|
#   u.name     = 'Student User'
#   u.provider = 'google_oauth2'
#   u.uid      = '789'
# end
#
# # If your admin/faculty/student models are just
# # single-table roles, you can do:
# admin_user.create_admin!
# faculty_user.create_faculty!(department: "CSCE")
# student_user.create_student!(year: 2024, major: "Computer Science")

puts "Users & Roles created or found."


# -------------------------------------
# 2) Create Projects
# -------------------------------------
project_list = [
  {
    name: "Nitesh Saxena",
    email: "nsaxena@tamu.edu",
    num_positions: 2,
    areas_of_research: "Cybersecurity and privacy (broadly defined)",
    start_semester: "Spring 2025",
    description: "We have a wide variety of projects that honors students can get involved with. For more info, please take a look at our lab's website: https://spies.engr.tamu.edu/",
    prefered_class: "Junior/Senior; Others with exceptional motivation",
    other_comments: ""
  },
  {
    name: "Guofei Gu",
    email: "guofei@cse.tamu.edu",
    num_positions: 2,
    areas_of_research: "Cybersecurity",
    start_semester: "Fall 2023",
    description: "Come to SUCCESS. Achieve Your Success!",
    prefered_class: "Junior/Senior",
    other_comments: "SUCCESS Lab: https://success.cse.tamu.edu/"
  },
  {
    name: "Ricardo Gutierrez",
    email: "rgutier@tamu.edu",
    num_positions: 2,
    areas_of_research: "Deep learning / digital health",
    start_semester: "Fall 2023",
    description: "Predicting health parameters from wearable sensors",
    prefered_class: "Junior/senior",
    other_comments: "Related pubs: 1, 2, 3 https://www.nature.com/articles/s41598-019-56927-5"
  },
  {
    name: "Ricardo Gutierrez",
    email: "rgutier@tamu.edu",
    num_positions: 2,
    areas_of_research: "Biofeedback games",
    start_semester: "Fall 2023",
    description: "Integrating wearable sensors with videogames",
    prefered_class: "Junior/senior",
    other_comments: "Related pubs: 1, 2, 3 https://psi.engr.tamu.edu/wp-content/uploads/2021/12/nitin2021frontiers.pdf"
  },
  {
    name: "Aakash Tyagi",
    email: "tyagi@cse.tamu.edu",
    num_positions: "varies",
    areas_of_research: "Machine Learning, Chip Design",
    start_semester: "Fall 2023",
    description: "ML application in Physical Design and Functional Verification of CHIPS.",
    prefered_class: "Junior",
    other_comments: "Must have done 1-2 courses in ML, DL. Some NLP awareness is a plus. Send mail to tyagi@tamu.edu."
  },
  {
    name: "Bobak Mortazavi",
    email: "bobakm@tamu.edu",
    num_positions: 1,
    areas_of_research: "Health Analytics / machine learning",
    start_semester: "Fall 2023",
    description: "Applications of machine learning analytics for health data",
    prefered_class: "Any level",
    other_comments: ""
  },
  {
    name: "Drew Hamilton",
    email: "hamilton@tamu.edu",
    num_positions: 2,
    areas_of_research: "SCADA Security Lab, Texas Cyber Range",
    start_semester: "Fall 2023",
    description: "Hands on work with our lab equipment",
    prefered_class: "Any Level",
    other_comments: "Send email to Justin Leiden for SCADA leiden@tamu.edu. Send email to John Romero for Cyber Range john.romero@tamu.edu"
  },
  {
    name: "Marcus Botacin",
    email: "botacin@tamu.edu",
    num_positions: 1,
    areas_of_research: "Cybersecurity",
    start_semester: "Spring 2025",
    description: "Break defenses. Build better ones!",
    prefered_class: "Any Level",
    other_comments: "Send email to schedule a meeting."
  },
  {
    name: "Tim Davis",
    email: "davis@tamu.edu",
    num_positions: "varies",
    areas_of_research: "Graph algorithms, sparse matrix methods",
    start_semester: "Fall 2024",
    description: "Graph algorithms based on semirings and sparse linear algebra",
    prefered_class: "Junior/senior",
    other_comments: "A short intro: https://youtu.be/wqjRzC2fPUo, playlist: https://youtube.com/playlist?list=PL5EvFKC69QIw3FqXj7UmiN1p-a-qYnZVK&si=-EqhghKhTRXQnWZj. The projects I have available are for writing graph algorithms for LAGraph that use GraphBLAS."
  },
  {
    name: "Martin Carlisle",
    email: "carlislem@tamu.edu",
    num_positions: 1,
    areas_of_research: "Cybersecurity",
    start_semester: "Spring 2025",
    description: "Applying machine learning to cybersecurity problems",
    prefered_class: "Junior/senior",
    other_comments: ""
  },
  {
    name: "Philip Ritchey",
    email: "pcr@tamu.edu",
    num_positions: 1,
    areas_of_research: "Software Engineering",
    start_semester: "Spring 2024",
    description: "Automated code generation from test cases",
    prefered_class: "Junior/senior",
    other_comments: "CSCE 314 and CSCE 315 a plus, CSCE 431 even bigger plus."
  },
  {
    name: "Chia-Che Tsai",
    email: "chiache@tamu.edu",
    num_positions: 1,
    areas_of_research: "Cloud computing",
    start_semester: "Spring 2024",
    description: "Exploring system trade-offs for next-generation serverless computing",
    prefered_class: "Junior/senior",
    other_comments: "Recommended to have taken CSCE 410."
  },
  {
    name: "Tracy Hammond",
    email: "hammond@tamu.edu",
    num_positions: "Any",
    areas_of_research: "Human AI, Eyetracking, Sketch Recognition, Activity Recognition, HCI, Accessibility, Belonging, Health during cognitive decline, child fine motor skills, inequality",
    start_semester: "Spring 2024",
    description: "Recognition messy human activities, creating new metrics, helping those with cognitive decline",
    prefered_class: "Any Level",
    other_comments: "Email Hammond@tamu.edu. Attend lab meeting."
  },
  {
    name: "Shuiwang Ji",
    email: "sji@tamu.edu",
    num_positions: "Any",
    areas_of_research: "Machine learning, deep learning, language models and agents",
    start_semester: "anytime",
    description: "https://khhuang.me/group.html#",
    prefered_class: "Any level, but early-stage undergrads are preferred, as I expect students to do significant work that might not be done within 1-2 semesters",
    other_comments: "Email sji@tamu.edu with resume and transcript"
  },
  {
    name: "Frank Shipman",
    email: "shipman@tamu.edu",
    num_positions: "Any",
    areas_of_research: "Human-computer interaction, AI, multimedia",
    start_semester: "anytime",
    description: "Examples include: social media tools and practices, educational games, crowdsourcing data quality, support for human expression and editing of knowledge graphs, AI explanation techniques and interfaces",
    prefered_class: "Any level",
    other_comments: "Email shipman@tamu.edu with resume and your interests (if topic already known)"
  },
  {
    name: "Robert Lightfoot",
    email: "rob.light@tamu.edu",
    num_positions: 1,
    areas_of_research: "Use of AI as tools in Software Engineering, cloud computing classrooms",
    start_semester: "anytime",
    description: "Computer science education, engineering education, AI as a tool",
    prefered_class: "jr/Sr",
    other_comments: "Email rob.light@tamu.edu"
  },
  {
    name: "Jeff Huang",
    email: "jeff@cse.tamu.edu",
    num_positions: 1,
    areas_of_research: "Programming Languages",
    start_semester: "Fall 2024/Spring 2025",
    description: "Rust, AI, and browser security",
    prefered_class: "Any level",
    other_comments: "Email jeff@cse.tamu.edu with subject 'pokemon'. Please attach your resume"
  },
  {
    name: "Tianbao Yang",
    email: "tianbao-yang@tamu.edu",
    num_positions: "Any",
    areas_of_research: "Machine learning, artificial intelligence, deep learning",
    start_semester: "anytime",
    description: "My lab is conducting research on foundational AI and machine learning. We are improving AI from various perspectives, from representation learning to generative models, from foundational AI to applied AI. I have supervised an honor's student in 2023-2024 and the student has been admitted to the master program of University of Cambridge.",
    prefered_class: "Any level",
    other_comments: "Email tianbao-yang@tamu.edu with resume and transcript"
  },
  {
    name: "Kuan-Hao Huang",
    email: "khhuang@tamu.edu",
    num_positions: 1,
    areas_of_research: "Natural language processing, large language models, multimodal learning",
    start_semester: "anytime",
    description: "We have several projects focusing on evaluating and improving the robustness and capabilities of large (vision-)language models in domains such as logical reasoning, image-text understanding, mathematics, and various other applications.",
    prefered_class: "Any level, but please keep it in mind that significant work in our field might take at least 2 semesters",
    other_comments: "Please take the undergrad-level NLP course first and email khhuang@tamu.edu with resume and transcript"
  },
  {
    name: "Cheng Zhang",
    email: "chzhang@tamu.edu",
    num_positions: "Any",
    areas_of_research: "Human-centered computer vision, responsible AI and generative AI, multimodal (vision + language)",
    start_semester: "anytime",
    description: "- [vision, graphics] understand and reconstruct human and scenes\n- [vision, machine learning] reliability and inclusiveness-driven generative AI\n- [vision, language, action] language as a scaffold for visual and robot intelligence",
    prefered_class: "Any level",
    other_comments: "Email chzhang@tamu.edu with resume and transcript"
  },
  {
    name: "Ruihong Huang",
    email: "huangrh@tamu.edu",
    num_positions: 2,
    areas_of_research: "Natural Language Processing",
    start_semester: "anytime",
    description: "Detecting and mitigating social biases of large language models; video understanding and captioning",
    prefered_class: "Any level",
    other_comments: ""
  },
  {
    name: "Shreyas Kumar",
    email: "shreyas.kumar@tamu.edu",
    num_positions: 4,
    areas_of_research: "Applied Cybersecurity, Cyber Warfare",
    start_semester: "Spring 2025",
    description: "Cybersecurity to secure daily life, Cyber Warfare, Cyber Risk, Law & Privacy",
    prefered_class: "Any level",
    other_comments: "Email with subject 'INTEREST IN RESEARCH' with resume, transcripts, and your interests"
  },
  {
    name: "Wenping Wang",
    email: "wenping@tamu.edu",
    num_positions: 4,
    areas_of_research: "Shape modeling and computer vision",
    start_semester: "Spring 2025",
    description: "Surface representation, 3D reconstruction, mesh generation",
    prefered_class: "Junior or Senior",
    other_comments: ""
  },
  {
    name: "Roger Pearce",
    email: "rpearce@tamu.edu",
    num_positions: 1,
    areas_of_research: "High Performance Computing, Graph Analytics",
    start_semester: "anytime",
    description: "Variety of projects related to large scale data analytics for HPC",
    prefered_class: "Junior/Senior",
    other_comments: ""
  },
  {
    name: "Samson Zhou",
    email: "samsonzhou@tamu.edu",
    num_positions: 1,
    areas_of_research: "Theory",
    start_semester: "Spring 2025",
    description: "Design and analysis of algorithms",
    prefered_class: "Junior/Senior",
    other_comments: "CSCE 411 and/or mathematical maturity a plus. E-mail samsonzhou@tamu.edu with resume and transcript."
  },
  {
    name: "Dmitri Loguinov",
    email: "dmitri@tamu.edu",
    num_positions: 1,
    areas_of_research: "High performance computing, systems, optimization",
    start_semester: "anytime",
    description: "Algorithms for sorting, big-data frameworks, external-memory computing, graphs, multi-threading and parallelization",
    prefered_class: "Any",
    other_comments: "Strong coding ability in C/C++; CSCE 313 (honors) is a plus"
  },
  {
    name: "Yang Shen",
    email: "yshen@tamu.edu",
    num_positions: "Any",
    areas_of_research: "Multimodal machine learning for bioinformatics",
    start_semester: "anytime",
    description: "Multimodal representation learning, generation, explainability, generalizability, and uncertainty quantification for text, image, graph, and geometry, with applications to designing therapeutic molecules and predicting genetic-variant effects.",
    prefered_class: "Any",
    other_comments: "Email yshen@tamu.edu with resume and transcript. See the playlist for some of our past undergrad projects: https://www.youtube.com/playlist?list=PLOPwZv_49GaRRuMIHPHpX3viq4-ldpBWc"
  },
  {
    name: "Tracy Hammond",
    email: "hammond@tamu.edu",
    num_positions: "Any",
    areas_of_research: "AI/ML/HCI/Eng Ed/Haptics/Blind/Recognizing Human Actions",
    start_semester: "anytime",
    description: "Topics: Sketch Recognition, Human Activity Recognition, Eye-tracking, Haptics, Intelligent User Interfaces, Artificial Intelligence, Machine Learning, Deep Learning, Generative AI, Data Science, Explainable AI, Human-Computer Interaction, Computer Vision, Accessibility, Technologies for the Blind, Child Development Assessment, Health Based Wearable Interfaces and Solutions for Cognitive Decline & Other Neurological Conditions, Engineering Education, Computer Education.",
    prefered_class: "Any",
    other_comments: "Students of any year or major can participate. Expectations: Students should register for 491/291 credits. (1 credit of 291 for First/Second years). Students are expected to complete an undergraduate thesis. How to get Involved: Send a note to https://srltamu.com/contact.php, Email Dr. Hammond or Email or contact any of the graduate students, Attend a lab meeting to meet other students. Note that if you don't receive a response back, please email again to get to the top of the email chain."
  }
]

project_list.each do |data|
  # Make or find the user (Faculty).
  user = User.find_or_create_by!(email: data[:email]) do |u|
    u.name     = data[:name]
    u.uid      = SecureRandom.uuid
    u.provider = "manual"
  end


# Ensure this user has a Faculty record.
# If your logic is that every user with
# these emails should be faculty, do so:
faculty = Faculty.find_or_create_by!(user: user) do |f|
  f.department = "CSCE"  # Set default department
end


project = Project.create!(
  title: "#{data[:name]} Research",
  description: data[:description],
  num_positions: data[:num_positions] || 0,
  areas_of_research: data[:areas_of_research],
  start_semester: data[:start_semester],
  prefered_class: data[:prefered_class],
  other_comments: data[:other_comments]
)

  # Link project <-> faculty in the join table
  project.faculties << faculty unless project.faculties.include?(faculty)
end

puts "Seeded #{project_list.size} projects successfully!"


FACULTY_EMAILS = %w[
  ergun.akleman@gmail.com
  flandersen@TAMU.EDU
  wja@tamu.edu
  ariful@tamu.edu
  taffie@tamu.edu
  beideman@tamu.edu
  andreabernal@tamu.edu
  kim.betancourt@tamu.edu
  bettati@tamu.edu
  mblandon@tamu.edu
  botacin@tamu.edu
  karrie.bourquin@tamu.edu
  zoran@tamu.edu
  allison.carline@tamu.edu
  carlislem@tamu.edu
  caverlee@tamu.edu
  j-chen3@tamu.edu
  choe@tamu.edu
  chuw1@tamu.edu
  dave.cote@tamu.edu
  vcrawford@tamu.edu
  Dilma@tamu.edu
  davis@tamu.edu
  paula.dewitte@tamu.edu
  duffieldng@tamu.edu
  dalvindunn@tamu.edu
  aduysak03@tamu.edu
  jencarnacion@tamu.edu
  galanti@tamu.edu
  garay@tamu.edu
  ugoktas@tamu.edu
  pgratz@tamu.edu
  guofei@tamu.edu
  rgutier@tamu.edu
  hamilton@tamu.edu
  hammond@tamu.edu
  doug@tamu.edu
  jenniferh@tamu.edu
  davidkebo@tamu.edu
  jianghu@tamu.edu
  khhuang@tamu.edu
  jeffhuang@tamu.edu
  huangrh@tamu.edu
  ioerger@tamu.edu
  iiyoke@tamu.edu
  sji@tamu.edu
  ajiang@tamu.edu
  djimenez@tamu.edu
  beverly.joseph@tamu.edu
  nimak@tamu.edu
  charlie.kaufman@tamu.edu
  keyser@tamu.edu
  irfankhan@tamu.edu
  jeeeun.kim@tamu.edu
  ejkim@tamu.edu
  andreas-klappenecker@tamu.edu
  vinayak@tamu.edu
  kuhnle@tamu.edu
  kum@tamu.edu
  sandeep.kumar@tamu.edu
  shreyas.kumar@tamu.edu
  hlee42@tamu.edu
  rlleveridge@tamu.edu
  teresa19@tamu.edu
  zleyk@tamu.edu
  xinli@tamu.edu
  rob.light@tamu.edu
  jcliu@tamu.edu
  dmitri@tamu.edu
  slupoli@tamu.edu
  rabi@tamu.edu
  suleman.mahmood@tamu.edu
  ann@tamu.edu
  amit.merchant@tamu.edu
  jmichael@tamu.edu
  bobakm@tamu.edu
  robin.r.murphy@tamu.edu
  abdullah.muzahid@tamu.edu
  khanhtn@tamu.edu
  tung@tamu.edu
  amanda.norvelle@tamu.edu
  brendanchaseo@exchange.tamu.edu
  jokane@tamu.edu
  b.ontiveros@tamu.edu
  azowens@tamu.edu
  olgap@tamu.edu
  rpearce@tamu.edu
  radiaperlman@tamu.edu
  ayanna@tamu.edu
  xqian@tamu.edu
  srathinam@exchange.tamu.edu
  korok@tamu.edu
  james.reyes@tamu.edu
  philip.ritchey@gmail.com
  jrunnels@tamu.edu
  sarin@tamu.edu
  nsaxena@tamu.edu
  schaefer@tamu.edu
  sshakkot@tamu.edu
  guni@tamu.edu
  dshell@tamu.edu
  grace.shelton@tamu.edu
  yshen@tamu.edu
  shipman@tamu.edu
  dzsong@tamu.edu
  anna_stepanova@tamu.edu
  stoleru@tamu.edu
  sueda@tamu.edu
  shsze@tamu.edu
  ptaele@tamu.edu
  sthomas@tamu.edu
  ktorrez@tamu.edu
  hantran@tamu.edu
  chiache@tamu.edu
  tzz@tamu.edu
  tyagi@tamu.edu
  nveldt@tamu.edu
  stephanie.vilas@tamu.edu
  paulinewade@tamu.edu
  d-walker@tamu.edu
  swall108@tamu.edu
  ya.wang@tamu.edu
  wenping@tamu.edu
  k-waskom@tamu.edu
  christie.wiese@tamu.edu
  mengxia@tamu.edu
  davidyacoub@tamu.edu
  tianbao-yang@tamu.edu
  xinyue.ye@tamu.edu
  khyum107@tamu.edu
  chzhang@tamu.edu
  yuzhang@tamu.edu
  samsonzhou@tamu.edu
  yizhou_tamu@tamu.edu
]

puts "Seeding faculties..."

FACULTY_EMAILS.each do |email|
  begin
    # Normalize email (lowercase, etc.) if desired
    normalized = email.strip.downcase
    user = User.find_or_initialize_by(email: normalized)
    if user.new_record?
      user.provider = "manual"
      user.uid      = SecureRandom.uuid
      user.save!
      puts "Created new User with email: #{normalized}"
    else
      puts "User already exists with email: #{normalized}"
    end

    # Create faculty if none associated
    if user.faculty.nil?
      Faculty.create!(user: user)  # department and name are optional
      puts " -> Created Faculty for that user"
    else
      puts " -> Already has a Faculty record"
    end
  rescue ActiveRecord::RecordInvalid => e
    puts "Error creating user/faculty for #{email}: #{e.message}"
  end
end

puts "Seeding faculties done!"

STUDENT_EMAILS = %w[
sami.k.abouelnaaj@email.tamu.edu
gauriagrawal@email.tamu.edu
npalwar@email.tamu.edu
david.ambriz04@email.tamu.edu
suaxbae@email.tamu.edu
cbakker207@email.tamu.edu
mb77@email.tamu.edu
saibarath@email.tamu.edu
abelhe8900@email.tamu.edu
javibetancourt@email.tamu.edu
kbhagat@email.tamu.edu
karanbhalla204@email.tamu.edu
fontejam@email.tamu.edu
carolgeng@email.tamu.edu
mbohde2015@email.tamu.edu
lbohsali@email.tamu.edu
sayokbose@email.tamu.edu
mb22@email.tamu.edu
nhatthinh5678@email.tamu.edu
alexburris@email.tamu.edu
burton78@email.tamu.edu
aiden.carr@email.tamu.edu
macsencasaus@email.tamu.edu
anjali_hole@email.tamu.edu
lucian@email.tamu.edu
dc1@email.tamu.edu
dzc335@email.tamu.edu
kimcchen@email.tamu.edu
schin@email.tamu.edu
kschitta@email.tamu.edu
yohancho1004@email.tamu.edu
ethanchoe@email.tamu.edu
jackfc@email.tamu.edu
coffelt.jonah@email.tamu.edu
lukeconran@email.tamu.edu
ethan.curb@email.tamu.edu
leocuzela@email.tamu.edu
georgedai@email.tamu.edu
dedhiadev@email.tamu.edu
praket.desai723@email.tamu.edu
abhidev979@email.tamu.edu
keshavdharshan2021@email.tamu.edu
irened22@email.tamu.edu
nicholasdienstbier@email.tamu.edu
joseph_dillard4@email.tamu.edu
zelunliu@email.tamu.edu
evanrevvin295@email.tamu.edu
keeley2403@email.tamu.edu
mkf824@email.tamu.edu
francistre@email.tamu.edu
yotamfreund2005@email.tamu.edu
marfung37@email.tamu.edu
alexander.gaidarov@email.tamu.edu
mac2.morrison@email.tamu.edu
zhihangan@email.tamu.edu
nishanth.gandhe05@email.tamu.edu
harsh_g@email.tamu.edu
aayushg1414@email.tamu.edu
hmukesh@email.tamu.edu
narayan_rohit14@email.tamu.edu
m_ghebranious@email.tamu.edu
blakeolson@email.tamu.edu
cerebraldatabank@email.tamu.edu
austinglander@email.tamu.edu
neerajgogate@email.tamu.edu
pallavigok@email.tamu.edu
gomezg@email.tamu.edu
d_pandyan@email.tamu.edu
tjg@email.tamu.edu
caseypei@email.tamu.edu
jaxonjg123@email.tamu.edu
alex.greene@email.tamu.edu
nicholasg@email.tamu.edu
lukegu03@email.tamu.edu
thajiyev@email.tamu.edu
ahalbesleben@email.tamu.edu
john_harding04@email.tamu.edu
hanharm@email.tamu.edu
cassidy.hassell@email.tamu.edu
hawkes@email.tamu.edu
b.pettit@email.tamu.edu
phhedman65@email.tamu.edu
piyush11@email.tamu.edu
mh01@email.tamu.edu
david.hunt4@email.tamu.edu
rhuynh0@email.tamu.edu
ahmedlol445@email.tamu.edu
annairmetova@email.tamu.edu
ishitajaggi22@email.tamu.edu
kjain@email.tamu.edu
jain.nikhil1005@email.tamu.edu
mgjeffery22@email.tamu.edu
matthew.jones6736@email.tamu.edu
kkabbani@email.tamu.edu
arjunkale@email.tamu.edu
tejas@email.tamu.edu
mckelley@email.tamu.edu
nikita.kelwada@email.tamu.edu
thomas.kerr@email.tamu.edu
emilyk0825@email.tamu.edu
kimlarissa@email.tamu.edu
lucus.kim@email.tamu.edu
varish.kongara@email.tamu.edu
evankostov@email.tamu.edu
santosh_kota@email.tamu.edu
dave25639@email.tamu.edu
kevintang7215@email.tamu.edu
arpsku17@email.tamu.edu
diegol3@email.tamu.edu
kevtom2003@email.tamu.edu
jclanting@email.tamu.edu
balarson@email.tamu.edu
duckling@email.tamu.edu
pleblanc05@email.tamu.edu
oliviafrancislee@email.tamu.edu
carlos.v@email.tamu.edu
kevinlei@email.tamu.edu
jacklewicki@email.tamu.edu
andrewli620@email.tamu.edu
draydere@email.tamu.edu
tiernanlind@email.tamu.edu
grantlipham@email.tamu.edu
sallure12345@email.tamu.edu
torenlong@email.tamu.edu
robertl.themechanic@email.tamu.edu
colincloudan@email.tamu.edu
arjunmadana@email.tamu.edu
sean.mahon78@email.tamu.edu
aaronjmai@email.tamu.edu
hussammakhoul@email.tamu.edu
nitishmalluru@email.tamu.edu
rahifmansoor@email.tamu.edu
aaronmathews@email.tamu.edu
jmayhugh@email.tamu.edu
irondan99@email.tamu.edu
rrmereddy@email.tamu.edu
jr.miller083@email.tamu.edu
priyadarsimishra@email.tamu.edu
masonmock@email.tamu.edu
athul.mohanram05@email.tamu.edu
erinmok@email.tamu.edu
alimmomin_04@email.tamu.edu
tmsparklefox@email.tamu.edu
jmoy@email.tamu.edu
jmueck@email.tamu.edu
saketmugunda123@email.tamu.edu
sulaiman_1@email.tamu.edu
murphymy@email.tamu.edu
noahmustoe@email.tamu.edu
zaydn@email.tamu.edu
ndsoham@email.tamu.edu
rkn3743@email.tamu.edu
arun.annamalai4@email.tamu.edu
vrnayak20@email.tamu.edu
arthur.nguyen0629@email.tamu.edu
bn6687@email.tamu.edu
brin.07@email.tamu.edu
d722389@email.tamu.edu
vin.ce@email.tamu.edu
andrewdnielsen@email.tamu.edu
anukala@email.tamu.edu
shruti_oruganti@email.tamu.edu
nandinip@email.tamu.edu
srikar_palepu@email.tamu.edu
pan.evan@email.tamu.edu
ashwinrp03@email.tamu.edu
par7646@email.tamu.edu
romanp@email.tamu.edu
aarya.patel@email.tamu.edu
victoria.c6140@email.tamu.edu
p1401741@email.tamu.edu
abhi2022@email.tamu.edu
sp47864@email.tamu.edu
josh_pop@email.tamu.edu
mqian01@email.tamu.edu
sr613416@email.tamu.edu
nethra04@email.tamu.edu
rahulrajendran@email.tamu.edu
arjun.rajesh@email.tamu.edu
bjroesler21@email.tamu.edu
anishkarthik@email.tamu.edu
salembsaleh@email.tamu.edu
lucassauvage@email.tamu.edu
suhu.lavu@email.tamu.edu
sten_engin.gladiator@email.tamu.edu
andrewleachtx@email.tamu.edu
aaditshah@email.tamu.edu
ayushshah@email.tamu.edu
hiya.sharma@email.tamu.edu
prisha08@email.tamu.edu
ashatby@email.tamu.edu
zacharyshewbart@email.tamu.edu
brandonshim@email.tamu.edu
sangkarshansingh@email.tamu.edu
arjunsom@email.tamu.edu
vivek.somarapu@email.tamu.edu
jasonsomervell@email.tamu.edu
cespringer@email.tamu.edu
sandalis05@email.tamu.edu
allensun101@email.tamu.edu
andysun1104@email.tamu.edu
hdsung@email.tamu.edu
rprasad02@email.tamu.edu
timtaktamu@email.tamu.edu
david.roh@email.tamu.edu
peterschlenker@email.tamu.edu
adamt321@email.tamu.edu
risha.thimmancherla@email.tamu.edu
janicethomas@email.tamu.edu
ittiyanam@email.tamu.edu
kevinn.tran15@email.tamu.edu
theresa_tran24@email.tamu.edu
malcolmtroy01@email.tamu.edu
ntserng@email.tamu.edu
mayashah.tam@email.tamu.edu
nrs2586@email.tamu.edu
davidvanderklay@email.tamu.edu
aidan.veselka@email.tamu.edu
aditav0630@email.tamu.edu
zachwaldbusser@email.tamu.edu
jcwtexasanm@email.tamu.edu
maw2025@email.tamu.edu
yuanw1010@email.tamu.edu
daniel.warren@email.tamu.edu
mcwarren922@email.tamu.edu
sebastianwarren257@email.tamu.edu
timwng@email.tamu.edu
joshuawu@email.tamu.edu
srikaryalam@email.tamu.edu
stella@email.tamu.edu
chun_yeung@email.tamu.edu
ashlxyzhang@email.tamu.edu
zhangdavid275@email.tamu.edu
ericpangzhang@email.tamu.edu
n1v3x@email.tamu.edu
szheng08@email.tamu.edu
runyanzhou@email.tamu.edu
smrithika@email.tamu.edu
vedarth.atreya@email.tamu.edu
alexbeamer@email.tamu.edu
pranjol@email.tamu.edu
pharwadekar@email.tamu.edu
suryajasper@email.tamu.edu
coby-amu1@email.tamu.edu
joannechanliu@email.tamu.edu
alisayiranlu@email.tamu.edu
anambi@email.tamu.edu
sophiaaphu@email.tamu.edu
yahiaramadan@email.tamu.edu
shreyan04@email.tamu.edu
fadys@email.tamu.edu
edstone26@email.tamu.edu
danielbaowen@email.tamu.edu
miku@email.tamu.edu
waaangyi@email.tamu.edu
aaronzz10@email.tamu.edu
a11155@email.tamu.edu
pratha05@email.tamu.edu
tristanaujong@email.tamu.edu
evanye1202@email.tamu.edu
aniketshirodkar@email.tamu.edu
shri21.0408@email.tamu.edu
bari.vadaria@email.tamu.edu
nikhil_inja@email.tamu.edu
jmcclary23@email.tamu.edu
dreweldridge@email.tamu.edu
sdhulipala05@email.tamu.edu
obinwakwue10squared@email.tamu.edu
timothyzhang2023@email.tamu.edu
williamclymire@email.tamu.edu
zts493@email.tamu.edu
raheem05@email.tamu.edu
shadbowne@email.tamu.edu
aaditya.srini@email.tamu.edu
alejolaverde0927@email.tamu.edu
justin.cam@email.tamu.edu
brandonyuan@email.tamu.edu
abhivur@email.tamu.edu
ikaika@email.tamu.edu
surada@email.tamu.edu
arkumar@email.tamu.edu
dondischj@email.tamu.edu
ekansh2023@email.tamu.edu
mimict@email.tamu.edu
aneykanji_tamu@email.tamu.edu
bkumar1@email.tamu.edu
susanhamilton@email.tamu.edu
junweilao@email.tamu.edu
leonn@email.tamu.edu
sriya.param@email.tamu.edu
kemurdock@email.tamu.edu
nishit25@email.tamu.edu
jyoshitha.m@email.tamu.edu
namiyer@email.tamu.edu
kademertins@email.tamu.edu
]

puts "Seeding students..."

STUDENT_EMAILS.each do |raw_email|
  begin
    email = raw_email.strip.downcase
    user = User.find_or_initialize_by(email: email)
    if user.new_record?
      user.provider = "manual"
      user.uid      = SecureRandom.uuid
      # name is optional, so we won't set it
      user.save!
      puts "Created new User with email: #{email}"
    else
      puts "User already exists: #{email}"
    end

    if user.student.nil?
      Student.create!(user: user)  # year, major optional
      puts " -> Created Student record"
    else
      puts " -> Student record already exists for that user"
    end

  rescue ActiveRecord::RecordInvalid => e
    puts "Error creating user/student for #{email}: #{e.message}"
  end
end

puts "Student seeding done!"
