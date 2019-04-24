Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C2DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009D02084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NtDd5spj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbfDXPEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:04:20 -0400
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:58894
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730763AbfDXPET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfTeBk9FUxC/gk265YY3WU8DBOa1AoaHcDep2cUJc8c=;
 b=NtDd5spjQwJKYzLebcDO2C8aBbhUP2N2gKocKTHqFyDy9LvZ97sMZcHrT7Nkb4yLGdHAEVPRWiXGJRwYxt+N6ohx4Dw6wrzvIVbnWNJTho1NIzLnn7oOND9BOOQrO/AF5hWM76BHeYx6tmZAg0tic2WfRuQpGtZVsfZQc8PxASE=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2752.eurprd04.prod.outlook.com (10.175.22.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 24 Apr 2019 15:04:13 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 15:04:13 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 1/2] arm64: dts: imx8mm: Add SAI nodes
Thread-Topic: [PATCH v3 1/2] arm64: dts: imx8mm: Add SAI nodes
Thread-Index: AQHU+q76BBQNyW0vfkyxRF/BYgOi0w==
Date:   Wed, 24 Apr 2019 15:04:13 +0000
Message-ID: <20190424150350.7963-2-daniel.baluta@nxp.com>
References: <20190424150350.7963-1-daniel.baluta@nxp.com>
In-Reply-To: <20190424150350.7963-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0016.eurprd05.prod.outlook.com
 (2603:10a6:800:92::26) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a75dc7e-8d74-40da-fc2c-08d6c8c61c7a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2752;
x-ms-traffictypediagnostic: VI1PR0402MB2752:
x-microsoft-antispam-prvs: <VI1PR0402MB27528D4B2A4C1ECC54BCD284F93C0@VI1PR0402MB2752.eurprd04.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(136003)(39860400002)(199004)(189003)(86362001)(52116002)(6512007)(446003)(53936002)(54906003)(76176011)(6916009)(66066001)(2501003)(2906002)(4326008)(2351001)(25786009)(44832011)(6116002)(3846002)(66556008)(476003)(11346002)(71200400001)(71190400001)(64756008)(2616005)(66446008)(316002)(14444005)(256004)(73956011)(5640700003)(478600001)(5660300002)(66946007)(26005)(81156014)(50226002)(8936002)(66476007)(6486002)(36756003)(7736002)(486006)(305945005)(8676002)(14454004)(102836004)(81166006)(68736007)(386003)(1730700003)(97736004)(186003)(1076003)(6506007)(6436002)(99286004)(7416002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2752;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8CYggu2GTm9BUVLfhtmZFTo+wz4jSdnG/purvmyziX0CXUK2/BNF0Q+hPn1LmxmXypeXTiP+hmAzYnKf9NGXdktTaicFC7lDKHrg3YWgkPJo/ofwW5nMdEFTg7yVNEMxp/RwZBUHI3Potx2XNQUor+dFJSj4kAnVhnbi4VHcSe5mddISWUuvGoyuNiAxBhSEyinVnhAH+A0/3D7k5LOFeSLKM00oFEf760psaMXN3ie0+o76D96AU8qGLniXv24D5tILJvPqMoRhWmjA1o25l1g2bogU8aE3E7qJeEN7RXtQRUpC2PSSkj4tEXI9tX5VJ3bv3h0w56izj6lI281cVGf8s2wr+FLTKD83vL2wcxB0zKK90bKYn0lMIxB0It03833x8pFUmL+TIbOL0LIwlGddS3hmkbKU9U2bFNRo2x4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a75dc7e-8d74-40da-fc2c-08d6c8c61c7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 15:04:13.1229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWDhNTSBoYXMgNSBTQUkgaW5zdGFuY2VzIHdpdGggdGhlIGZvbGxvd2luZyBiYXNlDQphZGRy
ZXNzZXMgYWNjb3JkaW5nIHRvIFJNLg0KDQpTQUkxIGJhc2UgYWRkcmVzczogMzAwMV8wMDAwaA0K
U0FJMiBiYXNlIGFkZHJlc3M6IDMwMDJfMDAwMGgNClNBSTMgYmFzZSBhZGRyZXNzOiAzMDAzXzAw
MDBoDQpTQUk1IGJhc2UgYWRkcmVzczogMzAwNV8wMDAwaA0KU0FJNiBiYXNlIGFkZHJlc3M6IDMw
MDZfMDAwMGgNCg0KU2lnbmVkLW9mZi1ieTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBu
eHAuY29tPg0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kg
fCA2NiArKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA2NiBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bW0uZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQppbmRl
eCA2YjQwN2E5NGMwNmUuLjUyYWJlMmQwM2YzMSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bW0uZHRzaQ0KQEAgLTIwMSw2ICsyMDEsNzIgQEANCiAJCQkjc2l6ZS1jZWxs
cyA9IDwxPjsNCiAJCQlyYW5nZXM7DQogDQorCQkJc2FpMTogc2FpQDMwMDEwMDAwIHsNCisJCQkJ
Y29tcGF0aWJsZSA9ICJmc2wsaW14OG1tLXNhaSIsICJmc2wsaW14OG1xLXNhaSI7DQorCQkJCXJl
ZyA9IDwweDMwMDEwMDAwIDB4MTAwMDA+Ow0KKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgOTUg
SVJRX1RZUEVfTEVWRUxfSElHSD47DQorCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfU0FJ
MV9JUEc+LA0KKwkJCQkJIDwmY2xrIElNWDhNTV9DTEtfU0FJMV9ST09UPiwNCisJCQkJCSA8JmNs
ayBJTVg4TU1fQ0xLX0RVTU1ZPiwgPCZjbGsgSU1YOE1NX0NMS19EVU1NWT47DQorCQkJCWNsb2Nr
LW5hbWVzID0gImJ1cyIsICJtY2xrMSIsICJtY2xrMiIsICJtY2xrMyI7DQorCQkJCWRtYXMgPSA8
JnNkbWEyIDAgMiAwPiwgPCZzZG1hMiAxIDIgMD47DQorCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0
eCI7DQorCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQorCQkJfTsNCisNCisJCQlzYWkyOiBzYWlA
MzAwMjAwMDAgew0KKwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bW0tc2FpIiwgImZzbCxpbXg4
bXEtc2FpIjsNCisJCQkJcmVnID0gPDB4MzAwMjAwMDAgMHgxMDAwMD47DQorCQkJCWludGVycnVw
dHMgPSA8R0lDX1NQSSA5NiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCisJCQkJY2xvY2tzID0gPCZj
bGsgSU1YOE1NX0NMS19TQUkyX0lQRz4sDQorCQkJCQk8JmNsayBJTVg4TU1fQ0xLX1NBSTJfUk9P
VD4sDQorCQkJCQk8JmNsayBJTVg4TU1fQ0xLX0RVTU1ZPiwgPCZjbGsgSU1YOE1NX0NMS19EVU1N
WT47DQorCQkJCWNsb2NrLW5hbWVzID0gImJ1cyIsICJtY2xrMSIsICJtY2xrMiIsICJtY2xrMyI7
DQorCQkJCWRtYXMgPSA8JnNkbWEyIDIgMiAwPiwgPCZzZG1hMiAzIDIgMD47DQorCQkJCWRtYS1u
YW1lcyA9ICJyeCIsICJ0eCI7DQorCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQorCQkJfTsNCisN
CisJCQlzYWkzOiBzYWlAMzAwMzAwMDAgew0KKwkJCQkjc291bmQtZGFpLWNlbGxzID0gPDA+Ow0K
KwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bW0tc2FpIiwgImZzbCxpbXg4bXEtc2FpIjsNCisJ
CQkJcmVnID0gPDB4MzAwMzAwMDAgMHgxMDAwMD47DQorCQkJCWludGVycnVwdHMgPSA8R0lDX1NQ
SSA1MCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCisJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NM
S19TQUkzX0lQRz4sDQorCQkJCQkgPCZjbGsgSU1YOE1NX0NMS19TQUkzX1JPT1Q+LA0KKwkJCQkJ
IDwmY2xrIElNWDhNTV9DTEtfRFVNTVk+LCA8JmNsayBJTVg4TU1fQ0xLX0RVTU1ZPjsNCisJCQkJ
Y2xvY2stbmFtZXMgPSAiYnVzIiwgIm1jbGsxIiwgIm1jbGsyIiwgIm1jbGszIjsNCisJCQkJZG1h
cyA9IDwmc2RtYTIgNCAyIDA+LCA8JnNkbWEyIDUgMiAwPjsNCisJCQkJZG1hLW5hbWVzID0gInJ4
IiwgInR4IjsNCisJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCisJCQl9Ow0KKw0KKwkJCXNhaTU6
IHNhaUAzMDA1MDAwMCB7DQorCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS1zYWkiLCAiZnNs
LGlteDhtcS1zYWkiOw0KKwkJCQlyZWcgPSA8MHgzMDA1MDAwMCAweDEwMDAwPjsNCisJCQkJaW50
ZXJydXB0cyA9IDxHSUNfU1BJIDkwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KKwkJCQljbG9ja3Mg
PSA8JmNsayBJTVg4TU1fQ0xLX1NBSTVfSVBHPiwNCisJCQkJCSA8JmNsayBJTVg4TU1fQ0xLX1NB
STVfUk9PVD4sDQorCQkJCQkgPCZjbGsgSU1YOE1NX0NMS19EVU1NWT4sIDwmY2xrIElNWDhNTV9D
TEtfRFVNTVk+Ow0KKwkJCQljbG9jay1uYW1lcyA9ICJidXMiLCAibWNsazEiLCAibWNsazIiLCAi
bWNsazMiOw0KKwkJCQlkbWFzID0gPCZzZG1hMiA4IDIgMD4sIDwmc2RtYTIgOSAyIDA+Ow0KKwkJ
CQlkbWEtbmFtZXMgPSAicngiLCAidHgiOw0KKwkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KKwkJ
CX07DQorDQorCQkJc2FpNjogc2FpQDMwMDYwMDAwIHsNCisJCQkJY29tcGF0aWJsZSA9ICJmc2ws
aW14OG1tLXNhaSIsICJmc2wsaW14OG1xLXNhaSI7DQorCQkJCXJlZyA9IDwweDMwMDYwMDAwIDB4
MTAwMDA+Ow0KKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgOTAgSVJRX1RZUEVfTEVWRUxfSElH
SD47DQorCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfU0FJNl9JUEc+LA0KKwkJCQkJIDwm
Y2xrIElNWDhNTV9DTEtfU0FJNl9ST09UPiwNCisJCQkJCSA8JmNsayBJTVg4TU1fQ0xLX0RVTU1Z
PiwgPCZjbGsgSU1YOE1NX0NMS19EVU1NWT47DQorCQkJCWNsb2NrLW5hbWVzID0gImJ1cyIsICJt
Y2xrMSIsICJtY2xrMiIsICJtY2xrMyI7DQorCQkJCWRtYXMgPSA8JnNkbWEyIDEwIDIgMD4sIDwm
c2RtYTIgMTEgMiAwPjsNCisJCQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCisJCQkJc3RhdHVz
ID0gImRpc2FibGVkIjsNCisJCQl9Ow0KKw0KIAkJCWdwaW8xOiBncGlvQDMwMjAwMDAwIHsNCiAJ
CQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1tLWdwaW8iLCAiZnNsLGlteDM1LWdwaW8iOw0KIAkJ
CQlyZWcgPSA8MHgzMDIwMDAwMCAweDEwMDAwPjsNCi0tIA0KMi4xNy4xDQoNCg==
