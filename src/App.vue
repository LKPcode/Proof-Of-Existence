<template>
	<div id="">
		<div class="nav-bar">
			<div class="company-name">
				<div>Solid_Proof</div>
			</div>
			<div class="nav-links">
				<a class="nav-link" href="#"> Home </a>
				<!-- <a class="nav-link bold" href=""> Home </a> -->
				<a class="nav-link" href="#level2"> Upload </a>
				<a class="nav-link" href="#level3"> Verify </a>
				<a class="nav-link" href="#"> About Us </a>
				<button v-if="testAddress == undefined" class="nav-link connect-wallet-btn"
					v-on:click="connectWallet()"> Connect Wallet </button>
				<button v-else class="nav-link connect-wallet-btn" v-on:click="connectWallet()"> {{
					shortenHash(this.testAddress) }} </button>

			</div>
		</div>


		<div class="content">
			<div class="level">

				<div class="main-info left">


					<h1> Proof of </h1>
					<h1 class="yellow-text"> Existence </h1>
					<p> Proof of ownership is the key to maintaining the authenticity to any of your most important
						documents. Secure any file on the blockchain following these simple steps.
						The smart contract has been deployed on the Polygon Network.
					</p>
					<div class="buttons">
						<a class="btn" href="#level2"> Upload </a>
						<button class="gray-bg"> Learn More </button>
					</div>
				</div>
				<div class="dotted-line"></div>
				<div class="main-image">
					<img class="first-img" src="./assets/jar-st.png" alt="">
				</div>
			</div>

			<div class="level seccond-level" id="level2">
				<!-- <div class="main-image">
					<img class="seccond-img" src="./assets/bottle-st.png" alt="">
				</div> -->
				<div class="proof-info upload-info">
					<div class="upload-info-line"> Document Hash: </div>
					<textarea v-model="doc_to_upload._hash" name="" id="hash-textarea" cols="30" rows="10"
						placeholder="SHA256"></textarea>

					<div class="upload-info-line"> Optional Message: </div>
					<textarea v-model="doc_to_upload.message" name="" id="" cols="30" rows="10"
						placeholder="Legal Contract about cholesterol levels of primates."></textarea>
					<div class="upload-info-line"> Estimated Datetime: <span
							style="font-weight:bold;font-size:medium;margin-left:20px;">{{ this.doc_to_upload.est_datetime }}</span>
					</div>

					<button @click="uploadDocData()" class="make-permanent-btn">Make Permanent</button>

				</div>
				<!-- <div class="dotted-line"></div> -->

				<div class="main-info right">
					<h1 class="yellow-text"> Upload </h1>
					<h1> a file to the </h1>
					<h1> ether</h1>
					<p> <span style="width:100px;">
							Create a permanent record of the existance of the file by uploading the hash to the
							blockchain.

							Select the file you wish to create a permanent record of.
							Write an an optional message and finally
							Select make permanent to execute the transaction.
						</span>
					</p>
					<!-- <img id="arrow-upload" src="./assets/arrow-upload.png" alt=""> -->
					<div class="buttons btns-right">
						<label class="make-permanent-btn select-file" @change="uploadFile()">
							<input class="file-upload" type="file" ref="file">
							Select File
						</label>

						<!-- <button> Select File</button> -->
					</div>
				</div>

			</div>

			<div v-if="documents.length > 0" class="proof-info">
				<div class="table-title">Your Uploaded Documents</div>
				<table>
					<tr>
						<th class="list-id">#</th>
						<th>Hash (SHA256)</th>
						<th>Message</th>
						<th>Datetime</th>
					</tr>
					<tr v-for="doc, i in this.documents" :key="i">
						<td class="list-id"> {{ i }} </td>
						<td>
							<div class="tooltip">
								{{ shortenHash(doc._hash) }}
								<div class="tooltiptext">{{ doc._hash }}</div>
							</div>
						</td>
						<td>
							<div class="tooltip">
								{{ doc.message.slice(0, 60) }}
								<div class="tooltiptext">{{ doc.message }}</div>
							</div>
						</td>

						<td> {{ epochToHumanReadable(doc.datetime) }} </td>
					</tr>

				</table>

			</div>

			<div class="level third-level" id="level3">
				<div class="main-info left">

					<h1 class="yellow-text"> Verify </h1>
					<h1> the existance </h1>
					<h1>of documents</h1>
					<p> This is where you can verify the existance of a document.

						Choose the file you would like to verify. Alternatively you can insert the hash of the file on
						the right where it says document hash.
						Select verify document to see if the file/hash has been verified on the blockchain.
					</p>
					<div class="buttons" style="position:relative;">
						<div class="buttons-container">
							<label class="make-permanent-btn select-file" @change="createHashOfFileToVerify()">
								<input class="file-upload" type="file" ref="file2">
								Select File
							</label>
							<!-- <input v-model="doc_to_verify_hash" class="proof-info verify-hash-input" placeholder="Hash SHA256"> -->
							<!-- <button style="margin-left: 30px;"> Verify Hash </button> -->
						</div>


					</div>
				</div>
				<div class="dotted-line"></div>
				<!-- <div class="main-image">
					
					<img class="third-img" src="../gold_tree.webp" alt="">
				</div> -->
				<div class="proof-info upload-info">
					<div class="upload-info-line"> Document Hash: </div>
					<textarea v-model="doc_to_verify_hash" name="" id="hash-textarea" cols="30" rows="10"
						placeholder="Insert Hash to verify or Select a file"></textarea>

					<div class="upload-info-line"> Accompanied Message: </div>
					<textarea disabled v-model="this.verified_doc.message" name="" id="" cols="30" rows="10"
						placeholder="Message"></textarea>
					<div class="upload-info-line"> Document was created before:
						<div v-if="this.verified_doc.error == false"
							style="color: greenyellow;margin-top:10px;;text-align: center;font-weight:bold;font-size:medium;margin-left:20px;">
							<span v-if="this.verified_doc.datetime != 0">
								{{ epochToHumanReadable(this.verified_doc.datetime) }}</span>
						</div>
						<div v-else
							style="color: red ;margin-top:10px;text-align: center;font-weight:bold;font-size:medium;margin-left:20px;">
							This File Does not Exist on The Blockchain </div>

					</div>

					<button @click="verifyDocumentHash(doc_to_verify_hash)" class="make-permanent-btn">Verify
						Document</button>

				</div>
			</div>

			<!-- <div class="proof-info">

			</div> -->

		</div>
	</div>
</template>

<script>

import Web3 from 'web3'
import abi from "./assets/abi"
import CryptoJS from "crypto-js"

let web3 = new Web3(window.ethereum);



// if (window.ethereum) { // first we check if metamask is installed
// 			window.ethereum.request({ method: 'eth_requestAccounts' })
// 			.then(() => {
// 				// this.connected = true; // If users successfully connected their wallet
// 			});
// 		}

// window.ethereum.request({ method: 'eth_requestAccounts' })

const contractAddress = "0x4c7f77e11f7e84db3fd6d4b362ef71a221b7e214" // Testnet "0x64Bef834EFe9B132f6d622dbbc934e6db9dDbAaB"


let contract = new web3.eth.Contract(abi, contractAddress)

console.log(contract)







export default {
	name: 'App',
	components: {

	},
	data() {
		return {
			connected: false,
			documents: [],
			doc_to_upload: {
				_hash: "",
				message: "",
				est_datetime: Date.now()
			},
			verified_doc: {
				message: "",
				_hash: "",
				datetime: 0,
				error: false
			},
			doc_to_verify_hash: "",
			testAddress: undefined,
			file_to_upload: ""
		}
	},
	async created() {
		// console.log('created: ', this)
		// this.testAddress =  await this.connectWallet()
		console.log("Created: ", web3.eth.getAccounts())

		this.doc_to_upload.est_datetime = this.epochToHumanReadable(Date.now() / 1000)

		web3.eth.getAccounts().then((res) => {
			this.testAddress = res[0]
			this.getDocumentsOf(this.testAddress)
			console.log("getAccounts: ", this.testAddress)
		})




		// Event On Change Account
		window.ethereum.on('accountsChanged', (accounts) => {
			console.log(accounts[0])
			this.testAddress = accounts[0]
			this.getDocumentsOf(this.testAddress)

		})

		// GAS Estimation
		// contract.methods.addDocument("okkkk","okkkkkkkkkk").estimateGas(
		// 		{
		// 			from: this.testAddress,
		// 			// gasPrice: 20000000000, //await web3.eth.getGasPrice(),
		// 		}, function(error, estimatedGas) {
		// 			console.log(estimatedGas)
		// 		}
		// );

		// web3.eth.getGasPrice().then((price)=> console.log(parseInt(price)))

	},
	methods: {
		getDocumentsOf: function (address) {
			contract.methods.getDocumentOf(address).call({ from: address })
				.then(res => {
					this.documents = res;
					console.log("Entries() Response: ", res)
				})
		},
		connectWallet: async function () {
			try {
				const addresses = await window.ethereum.request({ method: "eth_requestAccounts" });
				console.log("Wallet Addresses: ", addresses)
				this.testAddress = addresses[0]
				// return  addresses[0]
			} catch (e) {
				console.log("error in request", e);
				// location.reload();
			}
		},

		uploadDocData: function () {
			contract.methods.addDocument(this.doc_to_upload._hash, this.doc_to_upload.message).send({ from: this.testAddress })
				.then(res => {
					console.log("AddDocument() Response: ", res)
					this.getDocumentsOf(this.testAddress)
				})
		},
		uploadFile: function () {
			this.file_to_upload = this.$refs.file.files[0];
			console.log(this.file_to_upload)
			var reader = new FileReader();
			let that = this
			reader.addEventListener('load', function () {
				var hash = CryptoJS.SHA256(CryptoJS.enc.Latin1.parse(this.result));
				var hash_s = hash.toString(CryptoJS.enc.Hex)
				that.doc_to_upload._hash = hash_s
				var output = hash_s
				console.log(output);

			})
			reader.readAsBinaryString(this.file_to_upload);

		},
		createHashOfFileToVerify: function () {
			this.file_to_upload = this.$refs.file2.files[0];
			console.log(this.file_to_upload)
			var reader = new FileReader();
			let that = this
			reader.addEventListener('load', function () {
				var hash = CryptoJS.SHA256(CryptoJS.enc.Latin1.parse(this.result));
				var hash_s = hash.toString(CryptoJS.enc.Hex)
				that.doc_to_verify_hash = hash_s
				var output = hash_s
				console.log(output);

			})
			reader.readAsBinaryString(this.file_to_upload);

		},
		verifyDocumentHash: function (hash) {
			//Verify document
			console.log("Hash to Verify: ", hash)
			contract.methods.documents(hash).call({ from: this.testAddress })
				.then(res => {
					if (res["datetime"] == 0) {
						this.verified_doc = { error: true }
						return
					}
					res["error"] = false
					this.verified_doc = res
					console.log("Verified Doc:", this.verified_doc, hash)
				})
		},

		epochToHumanReadable: function (epoch) {
			let date = new Date(epoch * 1000)
			return date.toGMTString()
		},
		shortenHash: function (addr) {
			return addr.slice(0, 4) + " . . . " + addr.slice(42 - 4, 42)
		}
	}
}
</script>

<style>





:root {
	--primary-color: #FFEDBD;
	--background-color: #000000;
	--horizontal-margin: 200px;
	--dashed-line-color: #958b6e;
}

html {
	scroll-behavior: smooth;
}

body {
	padding: 0px;
	background-color: var(--background-color);

}

.nav-bar {
	background-color: var(--background-color);
	display: flex;
	justify-content: space-between;
	/* padding: 10px var(--horizontal-margin);  */
	padding-top: 20px;
	padding-bottom: 20px;
	;
	position: fixed;
	top: 0px;
	width: 100%;
	z-index: 100;
	border-bottom: 2px dashed var(--dashed-line-color);

}

.company-name {
	/* text-shadow: rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset; */

	/* font-family: Verdana, Geneva, Tahoma, sans-serif; */
	color: white;
	font-size: 40px;
	letter-spacing: 4px;
	font-weight: bold;
	display: flex;
	align-items: center;
	padding-left: var(--horizontal-margin);
}

.nav-links {
	display: flex;
	align-items: center;
	padding-right: var(--horizontal-margin);
}

.nav-link {
	margin: 10px 20px;
	color: white;


}

.connect-wallet-btn {
	font-weight: bold;
	background-color: var(--primary-color);
	color: black;
	padding: 10px 20px;
	border-radius: 20px;
}

.bold {
	font-weight: bold;
}

.level {
	display: flex;
	justify-content: space-between;
	padding-top: 100px;
	/* height: 100%; */
	/* align-items: center; */
}

.seccond-level {
	padding-top: 150px;
	/* margin-top: 300px; */
	/* border-top: 1px dashed var(--primary-color); */
}

.third-level {
	padding-top: 200px;
}

.content {
	color: aliceblue;
	padding: 150px var(--horizontal-margin);
	;
}

.main-info {
	padding-top: 30px;
	width: 500px;
	position: relative;
}

.main-image {
	width: 500px;
}

.dotted-line {
	/* border-right: 1px dashed var(--dashed-line-color); */
	height: 200px;
}

.left {
	text-align: left;
}

.right {
	text-align: right;
}

h1 {
	font-size: 55px;
	margin: 0px;
	;
}

.yellow-text {
	color: var(--primary-color);
}

.gray-bg {
	background-color: rgb(65, 65, 65) !important;
	color: white !important;
}

p {
	color: gray;
	font-size: 18px;
	/* width: 300px; */
	z-index: 5;
}

.buttons {
	display: flex;
	margin-top: 20px;
	;
}

.btns-right {
	justify-content: end;
}



.buttons>button,
.btn {
	cursor: pointer;
	color: black;
	border: none;
	font-weight: bold;
	display: block;
	padding: 15px 35px;
	background-color: var(--primary-color);
	margin-right: 30px;
	border-radius: 20px;
	font-size: large;
}

.btns-right>button {
	margin: 0px;
}

.first-img {
	height: 500px;
	position: relative;
	top: -70px;
	left: 100px;
}

.seccond-img {
	height: 700px;
	;
	position: relative;
	top: -130px;
}

.third-img {
	height: 600px;
	position: relative;
	top: -0px;
	/* right: -500px; */

}

.proof-info {
	/* height: 100px; */
	border: 1px dashed var(--dashed-line-color);

	background-color: rgb(21, 21, 21);
	border-radius: 25px;
	margin-top: 60px;
	padding: 20px;
}

#arrow-upload {
	position: absolute;
	top: 180px;
	left: 160px;
	height: 170px;
	transform: rotate(-0deg);
	z-index: 2;
}


main {
	text-align: center;
	color: white;
	background-color: var(--background-color);
	padding-bottom: 100px;
}

.upload-info {
	width: 400px;
	min-height: 400px;
	margin-top: 0px;
	padding: 30px;
	/* box-shadow: rgba(0, 0, 0, 0.25) 0px 54px 55px, rgba(255, 255, 255, 0.556) 0px -12px 30px, rgba(255, 255, 255, 0.548) 0px 4px 6px, rgba(255, 255, 255, 0.53) 0px 12px 13px, rgba(255, 255, 255, 0.09) 0px -3px 5px; */
	color: rgb(209, 209, 209);
	overflow: auto;
	/* background-color: black ; */


}

.upload-info-line {
	margin-top: 10px;
	margin-bottom: 5px;
	margin-left: 10px;
	word-wrap: break-word;
	font-size: small;

}

textarea,
input {
	background-color: #000000;
	border: none;
	width: 90%;
	margin: auto;
	/* width: auto; */
	height: 100px;
	resize: none;
	color: white;
	padding: 20px;
	border-radius: 15px;


}

#hash-textarea {
	height: 32px;
}

.make-permanent-btn {
	border: none;
	font-weight: bold;
	display: block;
	padding: 15px 35px;
	background-color: var(--primary-color);
	margin-top: 20px;
	border-radius: 20px;
	font-size: large;
	width: 100%;
}

.file-upload {
	display: none;

}

.select-file {
	color: #000000;
	width: auto;

}

table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 100%;
	border: none;
}


td,
th {
	/* border: 1px solid #dddddd; */
	text-align: left;
	padding: 8px;
}

tr:nth-child(even) {
	background-color: #dddddd09;
}

.list-id {
	color: var(--primary-color);
	font-weight: bold;
}

/* Tooltip container */
.tooltip {
	position: relative;
	display: inline-block;
	border-bottom: 1px dotted black;
	/* If you want dots under the hoverable text */
}

/* Tooltip text */
.tooltip .tooltiptext {
	visibility: hidden;

	background-color: var(--primary-color);
	color: rgb(0, 0, 0);
	text-align: center;
	padding: 10px 10px;
	border-radius: 6px;

	top: -5px;
	left: 100%;
	/* Position the tooltip text - see examples below! */
	position: absolute;
	z-index: 1;
}

/* Show the tooltip text when you mouse over the tooltip container */
.tooltip:hover .tooltiptext {
	visibility: visible;
}

.table-title {
	font-size: 20px;
	text-align: center;
	margin-bottom: 20px;
	font-weight: bold;
	color: var(--primary-color);

}

.verify-hash-input {
	/* text-align: center; */
	margin: 0px;
	height: 50px;
	width: 480px;
	padding: 0px 20px;

	/* left: 200px; */
}

.buttons-container {
	position: absolute;
	display: flex;
	justify-content: left;
	width: 200px;

}

.buttons-container>button {
	background-color: #fbe3a2;
}


.buttons-container>button {
	cursor: pointer;
	border: none;
	font-weight: bold;
	display: block;
	padding: 15px 35px;
	background-color: var(--primary-color);
	margin-right: 30px;
	border-radius: 20px;
	font-size: large;
}

a {
	text-decoration: none;
}

button,
label {
	cursor: pointer;
}

.seccond-level p {
	/* width: 100px; */
}

/* button,label:hover{
	background-color: #fbe3a2;
} */

/*  

 @media (min-width: 640px) {
  main {
   max-width: none;
  }
 } */
</style>
