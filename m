Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AD0C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9F121738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fYaL2t2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfDVTgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:36:46 -0400
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:48101
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfDVTgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVgbtfVlYvH3OwrWZRjS/f1K49+Xk7R/VlCbqS0PrN8=;
 b=fYaL2t2VTKroxcZ7NnBoomxqJdaEExtBAzbhpTeBsOs2rhaGO9qJxWGtzxNAwzWzco6jnHlZPaCJMIvlHBjFUNTO0OFql/Sc60VQIkP72jDhqGoJdPVKUEpTAMXMUhDM64m0oKcYKE2Rmb/mKdgwz0NAQVmvG4K8DI4bVUK0Po4=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2861.eurprd04.prod.outlook.com (10.175.23.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 19:36:00 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 19:36:00 +0000
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
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 1/2] arm64: dts: imx8mm: Add SAI nodes
Thread-Topic: [PATCH v2 1/2] arm64: dts: imx8mm: Add SAI nodes
Thread-Index: AQHU+UKdpwmi+8iq7UKtnq+oC0I10g==
Date:   Mon, 22 Apr 2019 19:35:59 +0000
Message-ID: <20190422193542.2853-2-daniel.baluta@nxp.com>
References: <20190422193542.2853-1-daniel.baluta@nxp.com>
In-Reply-To: <20190422193542.2853-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0109.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::38) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53449789-eb9b-406f-f41e-08d6c759bf54
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2861;
x-ms-traffictypediagnostic: VI1PR0402MB2861:
x-microsoft-antispam-prvs: <VI1PR0402MB2861389C696BDAE6829609F5F9220@VI1PR0402MB2861.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(102836004)(6116002)(3846002)(54906003)(2616005)(11346002)(446003)(386003)(2906002)(6506007)(476003)(25786009)(4326008)(97736004)(26005)(186003)(44832011)(36756003)(73956011)(5660300002)(2501003)(5640700003)(1076003)(71190400001)(71200400001)(66946007)(86362001)(66476007)(66066001)(64756008)(66446008)(66556008)(99286004)(478600001)(7736002)(68736007)(6436002)(52116002)(6486002)(76176011)(6916009)(256004)(14444005)(53936002)(6512007)(486006)(316002)(14454004)(305945005)(8676002)(2351001)(81166006)(81156014)(50226002)(1730700003)(8936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2861;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mjTgviZuVN8iss56n9vFXjstjWFMxGse9MhTisiyq5EI9psuG9kkESW3LXx/jeXPN94zLqsXSMhHjttIeFrzwtt6mt2VJ5xwLD27sUGaE4UGcMYgq9XYDG5kIqpgSIeXPRWnH4SDH2ez3OZZyH4xh8BKMDDhSeEV1uDqq0XeWfntKbp3v2ShLhLnjgXDZss7/KQrp0tvg51H2BfKZzWdTNimF4wKurkTr3mNyCeWtnqchUzjf2qy/ZdFKf9lGMXhYXUk17pzeqtpPv+7AF00q2qm550StpXTI4HcQ6RPsoYmsCYsflJTldFu4faYF5fwQ1/qN8YHZ+6/2VfAQ4Hm7FmQX+Q3M9/NMYQVXQjDj4RYfl24j+zNzB1JM6RzCyetuFPkX7hgHqv99kgNfTJdPLoZdPGtK5DckaoyI7pTBv4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53449789-eb9b-406f-f41e-08d6c759bf54
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 19:35:59.8738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2861
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
fCA3MSArKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA3MSBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bW0uZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQppbmRl
eCBkZTM0OThjMmRkNDQuLjRkMDgwZGM0NzIxNiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bW0uZHRzaQ0KQEAgLTE3MSw2ICsxNzEsNzcgQEANCiAJCQkjc2l6ZS1jZWxs
cyA9IDwxPjsNCiAJCQlyYW5nZXM7DQogDQorCQkJc2FpMTogc2FpQDMwMDEwMDAwIHsNCisJCQkJ
Y29tcGF0aWJsZSA9ICJmc2wsaW14OG1tLXNhaSIsDQorCQkJCQkJImZzbCxpbXg4bXEtc2FpIjsN
CisJCQkJcmVnID0gPDB4MzAwMTAwMDAgMHgxMDAwMD47DQorCQkJCWludGVycnVwdHMgPSA8R0lD
X1NQSSA5NSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCisJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1N
X0NMS19TQUkxX0lQRz4sDQorCQkJCQkgPCZjbGsgSU1YOE1NX0NMS19TQUkxX1JPT1Q+LA0KKwkJ
CQkJIDwmY2xrIElNWDhNTV9DTEtfRFVNTVk+LCA8JmNsayBJTVg4TU1fQ0xLX0RVTU1ZPjsNCisJ
CQkJY2xvY2stbmFtZXMgPSAiYnVzIiwgIm1jbGsxIiwgIm1jbGsyIiwgIm1jbGszIjsNCisJCQkJ
ZG1hcyA9IDwmc2RtYTIgMCAyIDA+LCA8JnNkbWEyIDEgMiAwPjsNCisJCQkJZG1hLW5hbWVzID0g
InJ4IiwgInR4IjsNCisJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCisJCQl9Ow0KKw0KKwkJCXNh
aTI6IHNhaUAzMDAyMDAwMCB7DQorCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS1zYWkiLA0K
KwkJCQkJCSJmc2wsaW14OG1xLXNhaSI7DQorCQkJCXJlZyA9IDwweDMwMDIwMDAwIDB4MTAwMDA+
Ow0KKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgOTYgSVJRX1RZUEVfTEVWRUxfSElHSD47DQor
CQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfU0FJMl9JUEc+LA0KKwkJCQkJPCZjbGsgSU1Y
OE1NX0NMS19TQUkyX1JPT1Q+LA0KKwkJCQkJPCZjbGsgSU1YOE1NX0NMS19EVU1NWT4sIDwmY2xr
IElNWDhNTV9DTEtfRFVNTVk+Ow0KKwkJCQljbG9jay1uYW1lcyA9ICJidXMiLCAibWNsazEiLCAi
bWNsazIiLCAibWNsazMiOw0KKwkJCQlkbWFzID0gPCZzZG1hMiAyIDIgMD4sIDwmc2RtYTIgMyAy
IDA+Ow0KKwkJCQlkbWEtbmFtZXMgPSAicngiLCAidHgiOw0KKwkJCQlzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KKwkJCX07DQorDQorCQkJc2FpMzogc2FpQDMwMDMwMDAwIHsNCisJCQkJI3NvdW5kLWRh
aS1jZWxscyA9IDwwPjsNCisJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1tLXNhaSIsDQorCQkJ
CQkJImZzbCxpbXg4bXEtc2FpIjsNCisJCQkJcmVnID0gPDB4MzAwMzAwMDAgMHgxMDAwMD47DQor
CQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA1MCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCisJCQkJ
Y2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19TQUkzX0lQRz4sDQorCQkJCQkgPCZjbGsgSU1YOE1N
X0NMS19TQUkzX1JPT1Q+LA0KKwkJCQkJIDwmY2xrIElNWDhNTV9DTEtfRFVNTVk+LCA8JmNsayBJ
TVg4TU1fQ0xLX0RVTU1ZPjsNCisJCQkJY2xvY2stbmFtZXMgPSAiYnVzIiwgIm1jbGsxIiwgIm1j
bGsyIiwgIm1jbGszIjsNCisJCQkJZG1hcyA9IDwmc2RtYTIgNCAyIDA+LCA8JnNkbWEyIDUgMiAw
PjsNCisJCQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCisJCQkJc3RhdHVzID0gImRpc2FibGVk
IjsNCisJCQl9Ow0KKw0KKwkJCXNhaTU6IHNhaUAzMDA1MDAwMCB7DQorCQkJCWNvbXBhdGlibGUg
PSAiZnNsLGlteDhtbS1zYWkiLA0KKwkJCQkJCSJmc2wsaW14OG1xLXNhaSI7DQorCQkJCXJlZyA9
IDwweDMwMDUwMDAwIDB4MTAwMDA+Ow0KKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgOTAgSVJR
X1RZUEVfTEVWRUxfSElHSD47DQorCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfU0FJNV9J
UEc+LA0KKwkJCQkJIDwmY2xrIElNWDhNTV9DTEtfU0FJNV9ST09UPiwNCisJCQkJCSA8JmNsayBJ
TVg4TU1fQ0xLX0RVTU1ZPiwgPCZjbGsgSU1YOE1NX0NMS19EVU1NWT47DQorCQkJCWNsb2NrLW5h
bWVzID0gImJ1cyIsICJtY2xrMSIsICJtY2xrMiIsICJtY2xrMyI7DQorCQkJCWRtYXMgPSA8JnNk
bWEyIDggMiAwPiwgPCZzZG1hMiA5IDIgMD47DQorCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7
DQorCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQorCQkJfTsNCisNCisJCQlzYWk2OiBzYWlAMzAw
NjAwMDAgew0KKwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bW0tc2FpIiwNCisJCQkJCQkiZnNs
LGlteDhtcS1zYWkiOw0KKwkJCQlyZWcgPSA8MHgzMDA2MDAwMCAweDEwMDAwPjsNCisJCQkJaW50
ZXJydXB0cyA9IDxHSUNfU1BJIDkwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KKwkJCQljbG9ja3Mg
PSA8JmNsayBJTVg4TU1fQ0xLX1NBSTZfSVBHPiwNCisJCQkJCSA8JmNsayBJTVg4TU1fQ0xLX1NB
STZfUk9PVD4sDQorCQkJCQkgPCZjbGsgSU1YOE1NX0NMS19EVU1NWT4sIDwmY2xrIElNWDhNTV9D
TEtfRFVNTVk+Ow0KKwkJCQljbG9jay1uYW1lcyA9ICJidXMiLCAibWNsazEiLCAibWNsazIiLCAi
bWNsazMiOw0KKwkJCQlkbWFzID0gPCZzZG1hMiAxMCAyIDA+LCA8JnNkbWEyIDExIDIgMD47DQor
CQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQorCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQor
CQkJfTsNCisNCiAJCQlncGlvMTogZ3Bpb0AzMDIwMDAwMCB7DQogCQkJCWNvbXBhdGlibGUgPSAi
ZnNsLGlteDhtbS1ncGlvIiwgImZzbCxpbXgzNS1ncGlvIjsNCiAJCQkJcmVnID0gPDB4MzAyMDAw
MDAgMHgxMDAwMD47DQotLSANCjIuMTcuMQ0KDQo=
