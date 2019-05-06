Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852ACC004C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 03:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F44205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 03:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LUZH71Do"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfEFD06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 23:26:58 -0400
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:20238
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbfEFD05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 23:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYm82xapVzqlM4WNQoM9knM1Nsx5RW958/Ue6kqfmN4=;
 b=LUZH71DoxrjiDWtmStrtHORjiImu+RR0kbAYluaKGw53B7pYapposFAX2h9lftwEmDnBbfAo+nrpZwy5625bQ+thSsQxKbJhVVkk2mPn+qYdBM7QCaWxeLGYA+uPgobJs6GATT97BXV62JrheFio8imLvHUxz6E5Fxrey/qbi1k=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 03:26:54 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 03:26:54 +0000
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
Subject: [PATCH 2/2] ARM: dts: imx6qdl: Assign corresponding clocks instead of
 dummy clock
Thread-Topic: [PATCH 2/2] ARM: dts: imx6qdl: Assign corresponding clocks
 instead of dummy clock
Thread-Index: AQHVA7uNF1kKh/86SEOOvgIfDAJrlA==
Date:   Mon, 6 May 2019 03:26:54 +0000
Message-ID: <1557112911-17115-2-git-send-email-Anson.Huang@nxp.com>
References: <1557112911-17115-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557112911-17115-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0212.apcprd02.prod.outlook.com
 (2603:1096:201:20::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85b17a79-30e8-40ac-96c6-08d6d1d2af67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-microsoft-antispam-prvs: <DB3PR0402MB37561176555BE9880EDFBDEDF5300@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:334;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(396003)(376002)(346002)(199004)(189003)(6436002)(4744005)(14444005)(110136005)(6486002)(316002)(71190400001)(71200400001)(256004)(8676002)(81156014)(81166006)(8936002)(50226002)(76176011)(66946007)(7736002)(2501003)(4326008)(52116002)(66556008)(64756008)(86362001)(66476007)(2201001)(66446008)(2906002)(99286004)(6116002)(3846002)(305945005)(478600001)(68736007)(6512007)(14454004)(53936002)(2616005)(11346002)(36756003)(5660300002)(73956011)(66066001)(102836004)(186003)(26005)(386003)(6506007)(25786009)(486006)(476003)(446003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +P1kc8ZD0tyQ0aOBNu78ZTyAd0iUyBttVOUtQL98m82zLC1SWA2/ZEkK2VwkVlIeLTDwvE+SuKinHlZ5wfn0eUZXHNRZlpPlPiVV2Rjk3wip5JrTK/w0WOpXw7vDnE95gfQ7AeUy9Fo6gdNsNl4NhRcmJZsedQtK8lUx2fFxZ8ZBH7+XNiJdcvCImGyUdVR9srRzR4jlfsUcYuwyqvweY9nkNihKeHHQW9IM+Bgb8zThEDP6t0K4BKbg0iw8SL7Y/WtlAwt5EO8bKX9M6uZYMretXpp3i5kWB1pQAtlDgREbv6IYHHRruCWPidAogteHmkf9qxSmj1koC2jkuMJSLhEa1NgBUnXL0odHApIa1YaZjDO1OfeRvhsJftR40dieRGC517Dx9Ngiqf5knDtCg/f9m1+fwkMMsnVPdRpWREg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b17a79-30e8-40ac-96c6-08d6d1d2af67
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 03:26:54.0676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWDZRL0RMJ3MgV0RPR3MgdXNlIElNWDZRRExfQ0xLX0lQRyBhcyBjbG9jayByb290LCBhc3Np
Z24NCklNWDZRRExfQ0xLX0lQRyB0byB0aGVtIGluc3RlYWQgb2YgSU1YNlFETF9DTEtfRFVNTVku
DQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KLS0t
DQogYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpIHwgNCArKy0tDQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDZxZGwuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwuZHRz
aQ0KaW5kZXggYjNhNzdiYy4uNjY0ZjdiNSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDZxZGwuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpDQpAQCAt
Njc1LDE0ICs2NzUsMTQgQEANCiAJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14NnEtd2R0IiwgImZz
bCxpbXgyMS13ZHQiOw0KIAkJCQlyZWcgPSA8MHgwMjBiYzAwMCAweDQwMDA+Ow0KIAkJCQlpbnRl
cnJ1cHRzID0gPDAgODAgSVJRX1RZUEVfTEVWRUxfSElHSD47DQotCQkJCWNsb2NrcyA9IDwmY2xr
cyBJTVg2UURMX0NMS19EVU1NWT47DQorCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2UURMX0NMS19J
UEc+Ow0KIAkJCX07DQogDQogCQkJd2RvZzI6IHdkb2dAMjBjMDAwMCB7DQogCQkJCWNvbXBhdGli
bGUgPSAiZnNsLGlteDZxLXdkdCIsICJmc2wsaW14MjEtd2R0IjsNCiAJCQkJcmVnID0gPDB4MDIw
YzAwMDAgMHg0MDAwPjsNCiAJCQkJaW50ZXJydXB0cyA9IDwwIDgxIElSUV9UWVBFX0xFVkVMX0hJ
R0g+Ow0KLQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlFETF9DTEtfRFVNTVk+Ow0KKwkJCQljbG9j
a3MgPSA8JmNsa3MgSU1YNlFETF9DTEtfSVBHPjsNCiAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
CiAJCQl9Ow0KIA0KLS0gDQoyLjcuNA0KDQo=
