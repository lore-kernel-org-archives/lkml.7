Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20383C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98562087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PdvzIP3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfEGGef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:34:35 -0400
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:11523
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfEGGec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ExYq0/XxosQws+I+MObyIAbrW7kRE6w3THug/jQZiA=;
 b=PdvzIP3qEYHBU9U+5ZM/qMLVEeFN0MsiDemaP14nAXhhIf3Nfvr07Wf3rs0EGbMlJJgt/gTPGXJP04mSzuhNG4K0oACKJbBw1CRKDKOrS/X1DI1K3mCP0D9iU6SvdvKwiOMzYssd/q6nGAAa1jJTAaPOh9agpOwpwp3njm7tHK8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3771.eurprd04.prod.outlook.com (52.134.67.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 06:34:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 06:34:29 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 3/5] ARM: dts: imx6sl-evk: Assign corresponding power supply
 for LDOs
Thread-Topic: [PATCH 3/5] ARM: dts: imx6sl-evk: Assign corresponding power
 supply for LDOs
Thread-Index: AQHVBJ7sDSmZDi+uOk6YXfDKN/0/wA==
Date:   Tue, 7 May 2019 06:34:28 +0000
Message-ID: <1557210565-4457-3-git-send-email-Anson.Huang@nxp.com>
References: <1557210565-4457-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557210565-4457-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0014.apcprd03.prod.outlook.com
 (2603:1096:202::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a74042d6-a866-44de-ebb1-08d6d2b60e5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3771;
x-ms-traffictypediagnostic: DB3PR0402MB3771:
x-microsoft-antispam-prvs: <DB3PR0402MB3771D9FDAE31D398F77EC19CF5310@DB3PR0402MB3771.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(189003)(199004)(6486002)(66066001)(68736007)(26005)(386003)(6506007)(186003)(102836004)(86362001)(11346002)(2616005)(446003)(76176011)(110136005)(14454004)(316002)(2201001)(52116002)(2501003)(5660300002)(99286004)(6116002)(2906002)(3846002)(4326008)(6512007)(6436002)(476003)(486006)(25786009)(36756003)(256004)(53936002)(305945005)(66476007)(66556008)(64756008)(66446008)(50226002)(478600001)(81156014)(81166006)(8676002)(8936002)(71190400001)(7736002)(73956011)(66946007)(71200400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3771;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h7VJfW0kRg74xWnyGmcqBvI0FlTE+/fhDb1L1Qywc86jjk0icPzG5Ee8/OaS6knVzFrnLXX+S3ZuuFH++BvA9G1F6CbG6rMx9NbPTPsOWWVDl6XTygfHVwx18rOlHUHhvgMsWv6Tee6US64fpyDb3ukuT7mwYiaAu6s5IzWHGhDcIhpWkD+CtiOmP/ILEmeAhzAablPpqrksu1FfX9SWqLI+yCcdtkOzESIEOyB08OD0+z1IXYmMrmUS1EGbdDN9CRc1kjmvjfYbyJIx6YX8UWwd1lBNUZ4B/adws8yKVzYSsN9cmPZuLdzMvRpO6lJlRLUsZzSLFWYRLhA9AVc6Vize4mFktelJhxFT+gw72u4zu2XgsAPl8FueWl6qdWPAGCkPypT5WZMKh5777zQ5+rEZU6T0flHG9KGo1TlPwTQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74042d6-a866-44de-ebb1-08d6d2b60e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 06:34:28.9582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gaS5NWDZTTCBFVksgYm9hcmQsIHN3MiBzdXBwbGllcyB2ZGQxcDEvdmRkMnA1L3ZkZDNwMCBM
RE8sIHRoaXMNCnBhdGNoIGFzc2lnbnMgY29ycmVzcG9uZGluZyBwb3dlciBzdXBwbHkgZm9yIHZk
ZDFwMS92ZGQycDUvdmRkM3AwDQp0byBhdm9pZCBjb25mdXNpb24gYnkgYmVsb3cgbG9nOg0KDQp2
ZGQxcDE6IHN1cHBsaWVkIGJ5IHJlZ3VsYXRvci1kdW1teQ0KdmRkM3AwOiBzdXBwbGllZCBieSBy
ZWd1bGF0b3ItZHVtbXkNCnZkZDJwNTogc3VwcGxpZWQgYnkgcmVndWxhdG9yLWR1bW15DQoNCldp
dGggdGhpcyBwYXRjaCwgdGhlIHBvd2VyIHN1cHBseSBpcyBtb3JlIGFjY3VyYXRlOg0KDQp2ZGQx
cDE6IHN1cHBsaWVkIGJ5IFNXMg0KdmRkM3AwOiBzdXBwbGllZCBieSBTVzINCnZkZDJwNTogc3Vw
cGxpZWQgYnkgU1cyDQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0Bu
eHAuY29tPg0KLS0tDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsLWV2ay5kdHMgfCAxMiArKysr
KysrKysrKysNCiBhcmNoL2FybS9ib290L2R0cy9pbXg2c2wuZHRzaSAgICB8ICA2ICsrKy0tLQ0K
IDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzbC1ldmsuZHRzIGIvYXJjaC9hcm0vYm9v
dC9kdHMvaW14NnNsLWV2ay5kdHMNCmluZGV4IGY3YTQ4ZTQuLjQ4MjlhYTYgMTAwNjQ0DQotLS0g
YS9hcmNoL2FybS9ib290L2R0cy9pbXg2c2wtZXZrLmR0cw0KKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvaW14NnNsLWV2ay5kdHMNCkBAIC01ODAsNiArNTgwLDE4IEBADQogCXN0YXR1cyA9ICJva2F5
IjsNCiB9Ow0KIA0KKyZyZWdfdmRkMXAxIHsNCisJdmluLXN1cHBseSA9IDwmc3cyX3JlZz47DQor
fTsNCisNCismcmVnX3ZkZDNwMCB7DQorCXZpbi1zdXBwbHkgPSA8JnN3Ml9yZWc+Ow0KK307DQor
DQorJnJlZ192ZGQycDUgew0KKwl2aW4tc3VwcGx5ID0gPCZzdzJfcmVnPjsNCit9Ow0KKw0KICZz
bnZzX3Bvd2Vyb2ZmIHsNCiAJc3RhdHVzID0gIm9rYXkiOw0KIH07DQpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnNsLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2c2wuZHRz
aQ0KaW5kZXggOTM5M2YwMy4uYjM2ZmMwMSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDZzbC5kdHNpDQorKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2c2wuZHRzaQ0KQEAgLTUz
MSw3ICs1MzEsNyBAQA0KIAkJCQkJICAgICA8MCA1NCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCiAJ
CQkJCSAgICAgPDAgMTI3IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KIA0KLQkJCQlyZWd1bGF0b3It
MXAxIHsNCisJCQkJcmVnX3ZkZDFwMTogcmVndWxhdG9yLTFwMSB7DQogCQkJCQljb21wYXRpYmxl
ID0gImZzbCxhbmF0b3AtcmVndWxhdG9yIjsNCiAJCQkJCXJlZ3VsYXRvci1uYW1lID0gInZkZDFw
MSI7DQogCQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxMDAwMDAwPjsNCkBAIC01NDYs
NyArNTQ2LDcgQEANCiAJCQkJCWFuYXRvcC1lbmFibGUtYml0ID0gPDA+Ow0KIAkJCQl9Ow0KIA0K
LQkJCQlyZWd1bGF0b3ItM3AwIHsNCisJCQkJcmVnX3ZkZDNwMDogcmVndWxhdG9yLTNwMCB7DQog
CQkJCQljb21wYXRpYmxlID0gImZzbCxhbmF0b3AtcmVndWxhdG9yIjsNCiAJCQkJCXJlZ3VsYXRv
ci1uYW1lID0gInZkZDNwMCI7DQogCQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwyODAw
MDAwPjsNCkBAIC01NjEsNyArNTYxLDcgQEANCiAJCQkJCWFuYXRvcC1lbmFibGUtYml0ID0gPDA+
Ow0KIAkJCQl9Ow0KIA0KLQkJCQlyZWd1bGF0b3ItMnA1IHsNCisJCQkJcmVnX3ZkZDJwNTogcmVn
dWxhdG9yLTJwNSB7DQogCQkJCQljb21wYXRpYmxlID0gImZzbCxhbmF0b3AtcmVndWxhdG9yIjsN
CiAJCQkJCXJlZ3VsYXRvci1uYW1lID0gInZkZDJwNSI7DQogCQkJCQlyZWd1bGF0b3ItbWluLW1p
Y3Jvdm9sdCA9IDwyMjUwMDAwPjsNCi0tIA0KMi43LjQNCg0K
