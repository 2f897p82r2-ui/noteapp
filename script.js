const passwordInput = document.getElementById('password');
const lockButton = document.getElementById('lock');
const unlockButton = document.getElementById('unlock');
const vaultContent = document.getElementById('vault-content');
const contentArea = document.getElementById('content');
const saveButton = document.getElementById('save');

let encryptionKey;

async function generateEncryptionKey() {
    return window.crypto.subtle.generateKey(
        {
            name: "AES-GCM",
            length: 256
        },
        true,
        ["encrypt", "decrypt"]
    );
}

async function encryptData(data, key) {
    const iv = window.crypto.getRandomValues(new Uint8Array(12));
    const encodedData = new TextEncoder().encode(data);
    const encryptedData = await window.crypto.subtle.encrypt(
        {
            name: "AES-GCM",
            iv: iv
        },
        key,
        encodedData
    );
    return { iv, encryptedData };
}

async function decryptData(encryptedData, key) {
    const { iv, data } = encryptedData;
    const decryptedData = await window.crypto.subtle.decrypt(
        {
            name: "AES-GCM",
            iv: iv
        },
        key,
        data
    );
    return new TextDecoder().decode(decryptedData);
}

async function saveVault() {
    if (!encryptionKey) {
        alert('Please unlock the vault first.');
        return;
    }
    const content = contentArea.value;
    const encryptedContent = await encryptData(content, encryptionKey);
    localStorage.setItem('vault', JSON.stringify(encryptedContent));
    alert('Vault saved successfully!');
}

async function loadVault() {
    if (!encryptionKey) {
        alert('Please unlock the vault first.');
        return;
    }
    const encryptedContent = JSON.parse(localStorage.getItem('vault'));
    if (encryptedContent) {
        const content = await decryptData(encryptedContent, encryptionKey);
        contentArea.value = content;
    } else {
        contentArea.value = '';
    }
}

lockButton.addEventListener('click', async () => {
    const password = passwordInput.value;
    if (!password) {
        alert('Please enter a password.');
        return;
    }
    encryptionKey = await generateEncryptionKey();
    unlockButton.disabled = false;
    vaultContent.style.display = 'block';
});

unlockButton.addEventListener('click', async () => {
    const password = passwordInput.value;
    if (!password) {
        alert('Please enter a password.');
        return;
    }
    // For simplicity, we are not using the password to derive the key.
    // In a real-world scenario, you should use a key derivation function (e.g., PBKDF2).
    loadVault();
});

saveButton.addEventListener('click', saveVault);
