# Note from Flare576

I exported the PDF to a .txt and wrote a little UI around the files.

## Getting Started

### Requirements

- Python 3 (check with `python3 --version`). Nothing else to install; the server uses Python's standard library.
- A modern browser.

### Option 1: One command (recommended)

From this folder:

- **macOS / Linux:** `./run.sh`
- **Windows:** double-click `run.bat`, or run it from a terminal

The script does the following:

1. Adds `127.0.0.1 aws.certification.edu` to your hosts file if it is not there yet. This asks for your sudo password (macOS/Linux) or administrator approval (Windows), and only the first time.
2. Starts a small web server on port 80 that is reachable from your own machine only.
3. Opens `http://aws.certification.edu/` in your browser. That page lists the AWS certifications; click one with questions (for now, Solutions Architect - Associate) and the viewer loads its question and answer files automatically.

Press `Ctrl+C` in the terminal to stop the server. The hosts entry stays; delete the `aws.certification.edu` line from `/etc/hosts` (or `C:\Windows\System32\drivers\etc\hosts`) to remove it.

To use a different port, set `PORT`, for example `PORT=9000 ./run.sh`; the address then becomes `http://aws.certification.edu:9000/`. On Windows, if port 80 is already used by another program, set `PORT` the same way.

### Option 2: Run the server by hand

```
python3 -m http.server --bind 127.0.0.1
```

Then open `http://127.0.0.1:8000/`. The `--bind 127.0.0.1` part keeps the server private to your machine.

The app needs a server: opening `viewer.html` directly from the disk cannot load the question files, because browsers block that. The question and answer files are chosen automatically from `assets/<certification>/`; there is no file picker.

### Troubleshooting

- **The page cannot be reached:** make sure the script is still running in its terminal, and that the `aws.certification.edu` line exists in the hosts file.
- **"Permission denied" or the port is busy:** another program may be using the port; use Option 1 with a different `PORT`.
- **"Could not load the exam":** the page was opened without the server (for example straight from the disk), or `assets/<certification>/` is missing `questions.txt` or `solutions.txt`.

### How to Use

Pick your answer (radio buttons for single-answer questions, checkboxes for "Choose two/three"), then press Submit Answer. The answer is checked against the solutions file, scored, and the explanation is shown. Questions without an answer key are not scored.

Progress is saved in the browser. Use "Random" to jump to an unanswered question, the question map to navigate, and "Finish & Score" for a summary. The summary is a practice percentage, not an AWS score.

#### Mock exam

Click "Mock exam (65)" for a random set of 65 questions, like the real exam. Only 50 of them count; the other 15 are hidden unscored items, as on the real exam, and are revealed when you finish. Unanswered questions count as wrong, and wrong answers cost nothing extra. The result is an estimated score out of 1000. It is an unofficial linear estimate, because AWS does not publish its conversion; the real passing score is 720. Use "New mock exam" for another set and "Full question bank" to go back to all questions.

## Adding Another Certification

Each certification keeps its data in its own folder under `assets/`:

```
assets/
└── SAA-03/
    ├── questions.txt
    └── solutions.txt
```

To add one, create `assets/<ID>/` with the same two file names, then give the matching entry in the `CERTS` list at the top of the script in `index.html` that `id` (for example `id: 'DVA-02'`). Its card on the catalog page then becomes clickable and opens `viewer.html?cert=<ID>`. The `id` may only contain letters, digits and `-`.

## Some of the Questions Don't Have Answers

Correct, I didn't augment any of the answers - I just fixed formatting enough for the UI to function

## Some of the Answers Seem Wrong

Agreed - I didn't augment any of the answers, and some (i.e., 291) seem wrong, but I'm leaving them as-is for now

## Do You Guarantee My Success?

I don't even guarantee **MY** success, so no.

# Prior README.md notes:

# AWS-Certified-Solutions-Architect-Associate-SAA-C03-Exam-Dump-With-Solution
 Comprehensive collection of study materials, practice exams Question, and Personally Solved Mcq to help you prepare for the AWS Certified Solutions Architect – Associate (SAA-C03) exam.

Welcome to the AWS SAA-C03 Exam Preparation Repository! This repository is designed to help you prepare for the AWS Certified Solutions Architect - Associate (SAA-C03) exam by providing a comprehensive set of Multiple Choice Questions (MCQs) along with their solutions. Please note that while this resource can be a valuable part of your preparation, it's crucial to cross-check the solutions and not solely rely on them.

## Contents

- **650+ MCQs:** This repository includes a diverse set of over 650 multiple-choice questions covering various aspects of the AWS SAA-C03 exam.

- **Detailed Solutions:** Each question is accompanied by a detailed solution, providing explanations and insights to help you understand the concepts thoroughly.

## Important Considerations

- **Stay Updated:** AWS services and features are subject to change. Always cross-check the provided solutions and be aware that AWS might update its services, affecting the correctness of the answers.

- **Use as a Supplement:** This repository should be used as a supplementary resource in conjunction with other study materials. It is not a replacement for hands-on experience and in-depth understanding of AWS services.

## How to Contribute

If you find any errors or have suggestions for improvement, feel free to contribute to this repository. Please use the standard GitHub workflow for making contributions.

## Star the Repository

If you find this repository useful, please consider starring it. Your support helps make this resource more visible to others, aiding them in their exam preparation.

## Disclaimer

While this repository aims to assist you in your exam preparation, it is not a guarantee of success. The best way to prepare is to combine various resources, hands-on experience, and thorough understanding of AWS services.

Good luck with your AWS SAA-C03 exam preparation!
