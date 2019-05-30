Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F86C46470
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C3A25363
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="B4akPKNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfE3IqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:46:25 -0400
Received: from mail-eopbgr70131.outbound.protection.outlook.com ([40.107.7.131]:14004
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726825AbfE3IqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector1-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcXZaI+pgIljxCPO7ZcOPIhb4AmGtuNb86fpbuG5rv0=;
 b=B4akPKNJjuScq3e28FgewTmrkCgZmU42XYzAofKZdWavWqwskmR2Kr36/hFUx59nmIYrC/HMfMlszTKnw7q2V7GH8J9Kud9tnOL38ToREAsmU4ZhlhjY9FmLffb8STrfEXvUExS6mi6KlkaAC+rxi4z06l9QnF5NSB/YraqLWag=
Received: from DB7PR02MB4411.eurprd02.prod.outlook.com (20.178.41.22) by
 DB7PR02MB4956.eurprd02.prod.outlook.com (20.178.44.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.22; Thu, 30 May 2019 08:46:03 +0000
Received: from DB7PR02MB4411.eurprd02.prod.outlook.com
 ([fe80::ce5:7d93:d1e2:5bcf]) by DB7PR02MB4411.eurprd02.prod.outlook.com
 ([fe80::ce5:7d93:d1e2:5bcf%4]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 08:46:03 +0000
From:   Dalit Ben Zoor <dbenzoor@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] habanalabs: restore unsecured registers default values
Thread-Topic: [PATCH 3/3] habanalabs: restore unsecured registers default
 values
Thread-Index: AQHVFsQcnVosbcRxEk6QBd2kKea7Mg==
Date:   Thu, 30 May 2019 08:46:02 +0000
Message-ID: <20190530084554.31968-3-dbenzoor@habana.ai>
References: <20190530084554.31968-1-dbenzoor@habana.ai>
In-Reply-To: <20190530084554.31968-1-dbenzoor@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::21) To DB7PR02MB4411.eurprd02.prod.outlook.com
 (2603:10a6:10:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dbenzoor@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d99c8e87-9700-48f0-308e-08d6e4db3f0d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB7PR02MB4956;
x-ms-traffictypediagnostic: DB7PR02MB4956:
x-microsoft-antispam-prvs: <DB7PR02MB49568716E62D0B237CD65D0ADC180@DB7PR02MB4956.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39850400004)(366004)(396003)(199004)(189003)(8936002)(50226002)(25786009)(4326008)(14454004)(66446008)(64756008)(66556008)(66476007)(81166006)(81156014)(8676002)(73956011)(66946007)(2501003)(36756003)(68736007)(86362001)(66066001)(6486002)(2351001)(53936002)(74482002)(102836004)(316002)(1361003)(6436002)(5640700003)(6916009)(5660300002)(386003)(6506007)(7736002)(305945005)(476003)(2616005)(99286004)(6116002)(3846002)(11346002)(52116002)(478600001)(446003)(71190400001)(76176011)(26005)(186003)(71200400001)(486006)(6512007)(2906002)(1076003)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB4956;H:DB7PR02MB4411.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LIJPJwCgGnw8fZ1xGYhpED6DPFhd9/DffYYOEuNON0SKnXrHoL2hv4sldew5ED8kI5fBfA1fKtLBGoZtUnEiMvevny0xc19PpzbF9af35Oral3QUqQqV5Oxer5Rkr8NgAXlqMES7yL/RZadrLyVXn+W+IL9a5AzJcIhlypQOHKr3wsioTrFXYonOR7IyuhpxjHlWeU9Sp/+hiUcTBHFj3b/O57/Hgfzht1TLHafAjDYar8A3OgTu7I5kYoPwEhXdk3qZ04/FytFoUIXQx84Lysq3tOocmqgG3D5b19DxhpHP1nkflTmz/kEb5zyC27iGrR79r2ccIGLMuumJ5YuV8RkYjWGREsQ5AJAdODLxpTH/5BiCg0O6w7TYeuQlOeEvzghoRluqFEAqUa3a1PVYE5zTuyNutjTjb6kLYkZKB/I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: d99c8e87-9700-48f0-308e-08d6e4db3f0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 08:46:02.9551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbenzoor@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dW5zZWN1cmVkIHJlZ2lzdGVycyBjYW4gYmUgY2hhbmdlZCBieSB0aGUgdXNlciwgYW5kIGhlbmNl
IHNob3VsZCBiZQ0KcmVzdG9yZWQgdG8gdGhlaXIgZGVmYXVsdCB2YWx1ZXMgaW4gY29udGV4dCBz
d2l0Y2gNCg0KU2lnbmVkLW9mZi1ieTogRGFsaXQgQmVuIFpvb3IgPGRiZW56b29yQGhhYmFuYS5h
aT4NCi0tLQ0KIGRyaXZlcnMvbWlzYy9oYWJhbmFsYWJzL2dveWEvZ295YS5jIHwgMTkgKysrKysr
KysrKysrKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL2hhYmFuYWxhYnMvZ295YS9nb3lh
LmMgYi9kcml2ZXJzL21pc2MvaGFiYW5hbGFicy9nb3lhL2dveWEuYw0KaW5kZXggODc4NTljNTVi
NGI4Li44MWMxZDU3Njc4M2YgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21pc2MvaGFiYW5hbGFicy9n
b3lhL2dveWEuYw0KKysrIGIvZHJpdmVycy9taXNjL2hhYmFuYWxhYnMvZ295YS9nb3lhLmMNCkBA
IC03ODYsNyArNzg2LDYgQEAgc3RhdGljIHZvaWQgZ295YV9pbml0X2RtYV9jaChzdHJ1Y3QgaGxf
ZGV2aWNlICpoZGV2LCBpbnQgZG1hX2lkKQ0KIAllbHNlDQogCQlzb2JfYWRkciA9IENGR19CQVNF
ICsgbW1TWU5DX01OR1JfU09CX09CSl8xMDA3Ow0KIA0KLQlXUkVHMzIobW1ETUFfQ0hfMF9XUl9D
T01QX0FERFJfTE8gKyByZWdfb2ZmLCBsb3dlcl8zMl9iaXRzKHNvYl9hZGRyKSk7DQogCVdSRUcz
MihtbURNQV9DSF8wX1dSX0NPTVBfQUREUl9ISSArIHJlZ19vZmYsIHVwcGVyXzMyX2JpdHMoc29i
X2FkZHIpKTsNCiAJV1JFRzMyKG1tRE1BX0NIXzBfV1JfQ09NUF9XREFUQSArIHJlZ19vZmYsIDB4
ODAwMDAwMDEpOw0KIH0NCkBAIC00NTYwLDEwICs0NTU5LDEyIEBAIHN0YXRpYyBpbnQgZ295YV9t
ZW1zZXRfZGV2aWNlX21lbW9yeShzdHJ1Y3QgaGxfZGV2aWNlICpoZGV2LCB1NjQgYWRkciwgdTY0
IHNpemUsDQogaW50IGdveWFfY29udGV4dF9zd2l0Y2goc3RydWN0IGhsX2RldmljZSAqaGRldiwg
dTMyIGFzaWQpDQogew0KIAlzdHJ1Y3QgYXNpY19maXhlZF9wcm9wZXJ0aWVzICpwcm9wID0gJmhk
ZXYtPmFzaWNfcHJvcDsNCi0JdTY0IGFkZHIgPSBwcm9wLT5zcmFtX2Jhc2VfYWRkcmVzczsNCisJ
dTY0IGFkZHIgPSBwcm9wLT5zcmFtX2Jhc2VfYWRkcmVzcywgc29iX2FkZHI7DQogCXUzMiBzaXpl
ID0gaGRldi0+cGxkbSA/IDB4MTAwMDAgOiBwcm9wLT5zcmFtX3NpemU7DQogCXU2NCB2YWwgPSAw
eDc3Nzc3Nzc3Nzc3Nzc3Nzd1bGw7DQotCWludCByYzsNCisJaW50IHJjLCBkbWFfaWQ7DQorCXUz
MiBjaGFubmVsX29mZiA9IG1tRE1BX0NIXzFfV1JfQ09NUF9BRERSX0xPIC0NCisJCQkJCW1tRE1B
X0NIXzBfV1JfQ09NUF9BRERSX0xPOw0KIA0KIAlyYyA9IGdveWFfbWVtc2V0X2RldmljZV9tZW1v
cnkoaGRldiwgYWRkciwgc2l6ZSwgdmFsLCBmYWxzZSk7DQogCWlmIChyYykgew0KQEAgLTQ1NzEs
NyArNDU3MiwxOSBAQCBpbnQgZ295YV9jb250ZXh0X3N3aXRjaChzdHJ1Y3QgaGxfZGV2aWNlICpo
ZGV2LCB1MzIgYXNpZCkNCiAJCXJldHVybiByYzsNCiAJfQ0KIA0KKwkvKiB3ZSBuZWVkIHRvIHJl
c2V0IHJlZ2lzdGVycyB0aGF0IHRoZSB1c2VyIGlzIGFsbG93ZWQgdG8gY2hhbmdlICovDQorCXNv
Yl9hZGRyID0gQ0ZHX0JBU0UgKyBtbVNZTkNfTU5HUl9TT0JfT0JKXzEwMDc7DQorCVdSRUczMiht
bURNQV9DSF8wX1dSX0NPTVBfQUREUl9MTywgbG93ZXJfMzJfYml0cyhzb2JfYWRkcikpOw0KKw0K
Kwlmb3IgKGRtYV9pZCA9IDEgOyBkbWFfaWQgPCBOVU1CRVJfT0ZfRVhUX0hXX1FVRVVFUyA7IGRt
YV9pZCsrKSB7DQorCQlzb2JfYWRkciA9IENGR19CQVNFICsgbW1TWU5DX01OR1JfU09CX09CSl8x
MDAwICsNCisJCQkJCQkJKGRtYV9pZCAtIDEpICogNDsNCisJCVdSRUczMihtbURNQV9DSF8wX1dS
X0NPTVBfQUREUl9MTyArIGNoYW5uZWxfb2ZmICogZG1hX2lkLA0KKwkJCQkJCWxvd2VyXzMyX2Jp
dHMoc29iX2FkZHIpKTsNCisJfQ0KKw0KIAlXUkVHMzIobW1UUENfUExMX0NMS19STFhfMCwgMHgy
MDAwMjApOw0KKw0KIAlnb3lhX21tdV9wcmVwYXJlKGhkZXYsIGFzaWQpOw0KIA0KIAlnb3lhX2Ns
ZWFyX3NtX3JlZ3MoaGRldik7DQotLSANCjIuMTcuMQ0KDQo=
