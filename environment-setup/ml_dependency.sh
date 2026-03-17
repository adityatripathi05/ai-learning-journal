#!/bin/bash

# Activate venv first
source .venv/bin/activate

# Set link mode to avoid warnings
export UV_LINK_MODE=copy

# Core ML
uv pip install torch  --index-url https://download.pytorch.org/whl/cu130
uv pip install torchvision torchaudio --index-url https://download.pytorch.org/whl/cu130
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
