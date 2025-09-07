#!/bin/bash
source ~/bash/apps/flip/flip.sh
read -n1 -p "Step 1 = Copy over job decription and resume to ai_helper/job_description and ai_helper/resume respectively (press any key to continue once complete) " ready_to_start
prompt=

process_file() {
  while read -r line; do
    echo "$line"
  done
}

send_prompt() {
  read -n1 -p "Who do you want to send the prompt to? (m)ass-ai [mai], chat(g)pt, (c)lipboard (m/g/c) " prompt_subject
  echo
  case $prompt_subject in
    m)
      mai "$prompt"
      ;;
    g)
      flip -m 1 "$prompt"
      ;;
    c)
      flip -m 0 "$prompt"
      ;;
  esac
}

resume="$(cat resume | process_file)"
jd="$(cat job_description | process_file)"
prompt="$(echo -e "Given the following resume and job description, ask me the 5 most relevant questions you can think of about my experience at this and other jobs in order to make my resume AS RELEVANT AS POSSIBLE to the job description and make me look like the ideal candidate for the role: \nResume: $resume.\nJob Description: $jd.")"
send_prompt
echo

read -s -n1 -p "Step 2 = Update & answer the questions in the questions file based on AI's response (press any key to continue) " any_key
questions="$(cat questions | process_file)"
prompt="$(echo -e "Here are my answers to the questions you asked. When I send them, please give me a tailored resume based on the job description I sent earlier, and please make sure to keep the resume down to 1 page long and optimized in the best way to pass the ATS road blocks. Here are the questions and answers: $questions")"
echo
send_prompt
echo

read -s -n1 -p "Step 3 = Copy/paste AI's resume response based on my questions/answers, job description, and previous resume (press any key to continue) "
echo

echo "Step 4 = Polish my resume continuously by pasting any of the following questions (wait for it...)"
sleep 1
source ~/ai/clipboard_queue/clipboard_queue.sh
clipboard_queue "Which is the most important sentence in the Professional summary (according to the job description)?" "Which 2 core skills in the resume you just sent would be the least useful (and therefore best to remove) if you had to choose? (according to the job description)" "What are the 3 most important experience points in the BD lab technician section of the resume you just sent (and therefore most important to keep of the much) if you had to choose? (according to the job description)"

echo
read -s -n1 -p "Step 5 = Look over my polished resume and read over the job description one more time. If my resume looks ready to submit, then save a copy of the pdf, rename it to eliminate old copies, and submit it to the job application. (press any key to continue)"

echo
read -s -n1 -p "Step 6 = Save my resume to the ~/JobSearch/resumes file (press any key to continue) "

source celebrate_job_application_completion.sh
