# Installation Guide
## Check OS
```
root@worker3:~# cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.5 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.5 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

## Python Development Dependency
```
sudo apt update
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev \
    libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev \
    wget libbz2-dev -y
```

## Python latest 3.14.3
```
root@worker3:~# cd /tmp
root@worker3:/tmp# wget https://www.python.org/ftp/python/3.14.3/Python-3.14.3.tgz
root@worker3:/tmp# tar -xf Python-3.14.3.tgz
root@worker3:/tmp# cd Python-3.14.3/
root@worker3:/tmp/Python-3.14.3# ./configure --enable-optimizations
root@worker3:/tmp/Python-3.14.3# make -j $(nproc)
root@worker3:/tmp/Python-3.14.3# sudo make altinstall  # Use altinstall to avoid overwriting system python3
root@worker3:/tmp/Python-3.14.3# python3.14 --verion
```

## uv package manager
```
root@worker3:~# curl -LsSf https://astral.sh/uv/install.sh | sh
root@worker3:~# source $HOME/.local/bin/env
root@worker3:~# echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
root@worker3:~# source ~/.bashrc
root@worker3:~# uv --version
root@worker3:~# uv pip --help
```

## Virtual environment setup
```
root@worker3:/nms_app/aditya# uv venv .venv --python python3.14
root@worker3:/nms_app/aditya# source .venv/bin/activate
```

## Pytorch
```
(.venv) nms@worker3:/nms_app/aditya$ nvidia-smi

+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 590.48.01              Driver Version: 590.48.01      CUDA Version: 13.1     |
+-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA RTX PRO 4500 Blac...    Off |   00000000:09:00.0 Off |                  Off |
| 30%   28C    P8              6W /  200W |     499MiB /  32623MiB |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+

+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI              PID   Type   Process name                        GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A            1498      G   /usr/lib/xorg/Xorg                        4MiB |
|    0   N/A  N/A           18151      C   ...nv_uni_nlp_bot/bin/python3.10        476MiB |
+-----------------------------------------------------------------------------------------+
```

PyTorch doesn't have pre-built binaries for CUDA 13.1 yet.
CUDA 12.4 binaries will work with your CUDA 13.1 driver thanks to forward compatibility:
(.venv) root@worker3:/nms_app/aditya# nano ml_dependency.sh
```bash
# Activate venv first
source .venv/bin/activate

# Set link mode to avoid warnings
export UV_LINK_MODE=copy

# Core ML
uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu130
uv pip install transformers datasets accelerate peft trl

# LangChain ecosystem
uv pip install langchain langgraph langchain-community langchain-openai

# API & validation
uv pip install pydantic httpx fastapi uvicorn

# Embeddings
uv pip install tiktoken sentence-transformers

# Vector DBs (one by one)
uv pip install qdrant-client
uv pip install chromadb
uv pip install weaviate-client

# Evaluation
uv pip install ragas deepeval

# LLM utilities
uv pip install litellm instructor

# Verify installation
python -c "import torch; print(f'PyTorch: {torch.__version__}, CUDA: {torch.cuda.is_available()}')"
```

```
(.venv) root@worker3:/nms_app/aditya# chmod +x ml_dependency.sh
(.venv) root@worker3:/nms_app/aditya# ./ml_dependency.sh
```

## Ollama Setup (Alternative vLLM, TGI)
```
(.venv) root@worker3:/nms_app/aditya# curl -fsSL https://ollama.com/install.sh | sh
(.venv) root@worker3:/nms_app/aditya# ollama --version
(.venv) root@worker3:/nms_app/aditya# sudo systemctl start ollama # Start Ollama service
(.venv) root@worker3:/nms_app/aditya# sudo systemctl enable ollama # Bind it to on-start
(.venv) root@worker3:/nms_app/aditya# ollama list # List installed models
(.venv) root@worker3:/nms_app/aditya# ollama pull qwen3.5:0.8b # Pull model
(.venv) root@worker3:/nms_app/aditya# ollama run qwen3.5:0.8b # Run model
(.venv) root@worker3:/nms_app/aditya# curl http://localhost:11434/api/chat \
  -d '{
    "model": "qwen3.5:0.8b",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
(.venv) root@worker3:/nms_app/aditya# curl http://localhost:11434/api/generate -d '{
  "model": "qwen3.5:0.8b",
  "prompt": "Why is the sky blue?"
}'
```
