Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E21C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C4A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DIjuDDNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEFJS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:18:29 -0400
Received: from mail-eopbgr30063.outbound.protection.outlook.com ([40.107.3.63]:47877
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbfEFJSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOu9S1mJ26iewV4E+lxu8ZiFELq1fiLb1OCj9cZi0kY=;
 b=DIjuDDNJV/JtmimmTK820spDufVFrQLehymck2tAJW2JVAl2BVf50IxPvGeMZyb+rDteWQhIg5YJmPVToixfN4xBNbsnT+CaZ/eq6j/BaR2NlFif+2DM3LRG1FIZ/Dw0/LFzPKXE8vjvDoFQso5D2zVaKXlJPsLoq9XW/O32w4k=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3833.eurprd04.prod.outlook.com (52.134.67.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Mon, 6 May 2019 09:18:20 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 09:18:20 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 3/3] arm64: dts: imx8mm: add clock for GPIO node
Thread-Topic: [PATCH 3/3] arm64: dts: imx8mm: add clock for GPIO node
Thread-Index: AQHVA+yl4l13mgGktUuq5WpN749wKg==
Date:   Mon, 6 May 2019 09:18:20 +0000
Message-ID: <1557133994-5061-3-git-send-email-Anson.Huang@nxp.com>
References: <1557133994-5061-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557133994-5061-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b404f95b-f494-4aa2-2352-08d6d203c7cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3833;
x-ms-traffictypediagnostic: DB3PR0402MB3833:
x-microsoft-antispam-prvs: <DB3PR0402MB3833983B51E2502C464034F2F5300@DB3PR0402MB3833.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(446003)(486006)(68736007)(8936002)(3846002)(2906002)(99286004)(386003)(6506007)(52116002)(476003)(11346002)(76176011)(2616005)(6116002)(4326008)(7736002)(25786009)(305945005)(2201001)(110136005)(7416002)(478600001)(86362001)(316002)(81156014)(66066001)(6486002)(66946007)(66476007)(64756008)(66446008)(73956011)(14454004)(66556008)(71200400001)(71190400001)(36756003)(256004)(8676002)(186003)(6512007)(26005)(102836004)(2501003)(50226002)(6436002)(5660300002)(81166006)(53936002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3833;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NBA36RcCANPF/JYkdxu0ZsfEVBFx9JdflMBvmQy8njA1mxxGxeuUr6ezKUSO4grkg6jAzaeZWPmUSoE/zI5BF8ipPFjlh7F6yQr/3x3O6m1rqLhPgSzLFTuZa8OZrOj3S3W+AbUGSF+FyonFx0uNxUrRgCHs4XAxn+SaHFtlwGn9PKta9OJCYXD+VfbbLLHUtfwK0KaT8PU5C9OrZu0lcMR0SSpXICnwRKcL0LNoi83hahk+4m45DUxUT3m3b6Qx/YlVbks5fzTFGeRJrLEjlh0/G7N6u1i36Ei0kyxZHp+8yBLFhLUifrxWDd9giGgcZN+SYXaWbJbg9fHORxvwrLPnpt7LhkgvhU/DT/Rpo+q7fcIg3i7VXu5S2D6haCzEImA6JgNZwJnIIyyDSG7PY3m88gVK2lK8+l5QWdICpD8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b404f95b-f494-4aa2-2352-08d6d203c7cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 09:18:20.0839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWDhNTSBoYXMgY2xvY2sgZ2F0ZSBmb3IgZWFjaCBHUElPIGJhbmssIGFkZCBjbG9jayBpbmZv
DQp0byBHUElPIG5vZGUgZm9yIGNsb2NrIG1hbmFnZW1lbnQuDQoNClNpZ25lZC1vZmYtYnk6IEFu
c29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kgfCA1ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1tLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0K
aW5kZXggNmI0MDdhOTQuLmYzMmQ0ZTkgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1tLmR0c2kNCkBAIC0yMDYsNiArMjA2LDcgQEANCiAJCQkJcmVnID0gPDB4MzAyMDAw
MDAgMHgxMDAwMD47DQogCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA2NCBJUlFfVFlQRV9MRVZF
TF9ISUdIPiwNCiAJCQkJCSAgICAgPEdJQ19TUEkgNjUgSVJRX1RZUEVfTEVWRUxfSElHSD47DQor
CQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfR1BJTzFfUk9PVD47DQogCQkJCWdwaW8tY29u
dHJvbGxlcjsNCiAJCQkJI2dwaW8tY2VsbHMgPSA8Mj47DQogCQkJCWludGVycnVwdC1jb250cm9s
bGVyOw0KQEAgLTIxNyw2ICsyMTgsNyBAQA0KIAkJCQlyZWcgPSA8MHgzMDIxMDAwMCAweDEwMDAw
PjsNCiAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDY2IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0K
IAkJCQkJICAgICA8R0lDX1NQSSA2NyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCisJCQkJY2xvY2tz
ID0gPCZjbGsgSU1YOE1NX0NMS19HUElPMl9ST09UPjsNCiAJCQkJZ3Bpby1jb250cm9sbGVyOw0K
IAkJCQkjZ3Bpby1jZWxscyA9IDwyPjsNCiAJCQkJaW50ZXJydXB0LWNvbnRyb2xsZXI7DQpAQCAt
MjI4LDYgKzIzMCw3IEBADQogCQkJCXJlZyA9IDwweDMwMjIwMDAwIDB4MTAwMDA+Ow0KIAkJCQlp
bnRlcnJ1cHRzID0gPEdJQ19TUEkgNjggSVJRX1RZUEVfTEVWRUxfSElHSD4sDQogCQkJCQkgICAg
IDxHSUNfU1BJIDY5IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KKwkJCQljbG9ja3MgPSA8JmNsayBJ
TVg4TU1fQ0xLX0dQSU8zX1JPT1Q+Ow0KIAkJCQlncGlvLWNvbnRyb2xsZXI7DQogCQkJCSNncGlv
LWNlbGxzID0gPDI+Ow0KIAkJCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsNCkBAIC0yMzksNiArMjQy
LDcgQEANCiAJCQkJcmVnID0gPDB4MzAyMzAwMDAgMHgxMDAwMD47DQogCQkJCWludGVycnVwdHMg
PSA8R0lDX1NQSSA3MCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCiAJCQkJCSAgICAgPEdJQ19TUEkg
NzEgSVJRX1RZUEVfTEVWRUxfSElHSD47DQorCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtf
R1BJTzRfUk9PVD47DQogCQkJCWdwaW8tY29udHJvbGxlcjsNCiAJCQkJI2dwaW8tY2VsbHMgPSA8
Mj47DQogCQkJCWludGVycnVwdC1jb250cm9sbGVyOw0KQEAgLTI1MCw2ICsyNTQsNyBAQA0KIAkJ
CQlyZWcgPSA8MHgzMDI0MDAwMCAweDEwMDAwPjsNCiAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDcyIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KIAkJCQkJICAgICA8R0lDX1NQSSA3MyBJUlFfVFlQ
RV9MRVZFTF9ISUdIPjsNCisJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19HUElPNV9ST09U
PjsNCiAJCQkJZ3Bpby1jb250cm9sbGVyOw0KIAkJCQkjZ3Bpby1jZWxscyA9IDwyPjsNCiAJCQkJ
aW50ZXJydXB0LWNvbnRyb2xsZXI7DQotLSANCjIuNy40DQoNCg==
