#!/bin/bash

# Run this to verify all major components
python -c "
import torch
import transformers
import langchain
import qdrant_client
import chromadb

print(f'✅ PyTorch: {torch.__version__}')
print(f'✅ CUDA Available: {torch.cuda.is_available()}')
print(f'✅ GPU: {torch.cuda.get_device_name(0) if torch.cuda.is_available() else \"N/A\"}')
print(f'✅ Transformers: {transformers.__version__}')
print(f'✅ LangChain installed')
print(f'✅ Vector DBs ready')
"
