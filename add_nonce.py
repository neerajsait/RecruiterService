import os

dir_path = r'D:\SDPProject\RecruiterService\src\main\webapp'

for root, _, files in os.walk(dir_path):
    for file in files:
        if file.endswith('.jsp'):
            path = os.path.join(root, file)
            with open(path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Use exact replacements for the opening tags
            content = content.replace('<style>', '<style nonce="<%= request.getAttribute(\\"cspNonce\\") %>">')
            content = content.replace('<script>', '<script nonce="<%= request.getAttribute(\\"cspNonce\\") %>">')
            
            with open(path, 'w', encoding='utf-8') as f:
                f.write(content)
