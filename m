Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1794C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A8B2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bxxctg/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDIFAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:00:07 -0400
Received: from mail-eopbgr10074.outbound.protection.outlook.com ([40.107.1.74]:27054
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725550AbfDIFAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LC5mqqk0kxv9DkPMYsSbW2MxhUz4skkSigTBQxFhAYo=;
 b=bxxctg/6E4x4JHLGg5u/WzBPWN3XV1BtzEslMk4P44SkElzFD0vJnrSAyM28rvlVjHe4vzmah4o5J8XvSV/PDbDYMLABve74jtWHXYYZMYn1PhuwA6N2kFaI/gbmLIocf2S4HQS95eINYqmW7/72BtepVydt80FVC51gcZi6AJQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3865.eurprd04.prod.outlook.com (52.134.73.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Tue, 9 Apr 2019 05:00:01 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 05:00:01 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V7 3/4] arm64: dts: freescale: imx8qxp: enable scu general irq
 channel
Thread-Topic: [PATCH V7 3/4] arm64: dts: freescale: imx8qxp: enable scu
 general irq channel
Thread-Index: AQHU7pEWxjYt5oDndkaeO3+BI9KoRw==
Date:   Tue, 9 Apr 2019 05:00:01 +0000
Message-ID: <1554785675-8090-3-git-send-email-Anson.Huang@nxp.com>
References: <1554785675-8090-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554785675-8090-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::20) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdb05e83-f8ec-4c60-6605-08d6bca838a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3865;
x-ms-traffictypediagnostic: DB3PR0402MB3865:
x-microsoft-antispam-prvs: <DB3PR0402MB386515381AEA6D2703D0EDE9F52D0@DB3PR0402MB3865.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(366004)(39860400002)(136003)(346002)(396003)(199004)(189003)(2906002)(52116002)(36756003)(68736007)(186003)(6436002)(26005)(110136005)(86362001)(6506007)(386003)(2201001)(8936002)(478600001)(25786009)(76176011)(102836004)(7736002)(316002)(4326008)(305945005)(66066001)(2501003)(97736004)(105586002)(7416002)(99286004)(50226002)(6486002)(8676002)(81156014)(81166006)(6116002)(106356001)(3846002)(71190400001)(71200400001)(5660300002)(14454004)(446003)(11346002)(486006)(6512007)(2616005)(256004)(53936002)(476003)(921003)(32563001)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3865;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T1U4qXo9gnm7f8PUxltxKFeQFPWzmqZiawSdB9HJyhBtsoPKM+dqrU1r7Mlgsi6AeLmbXEuI1v1qr9b0A/6FC35wzkChDCc+gBuqt/Fr7N9THCYHRD9hfgFwOAXerPyy/OUAYcE1iSsiQMmBVEyf0FnBF5h936FZpjDndERqJ/Wq+4KAFCTmDZXWFT5KULkDxGKcPBHNddwBkg2GsSgjKz6t9hJfzVShRkHfVM+Ks9dn5nowCkauIJz8KGuL3onHY1Zixc6xBPvMxpkSUGu35d6o3/RqA1mTBQzFmD/5TtPC9izhpSWlL2D3KpDY4PKZuXxrMPGU5oTrFkIPLnTfjxThrS5VYT7VRFPG0HnLaynGhZzGIG4wJjqhx452cK3XTcPViRB7oc1MM9n6fNCdSxfGxm7yyiMWUULL7mM4YY4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb05e83-f8ec-4c60-6605-08d6bca838a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 05:00:01.5430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gaS5NWDhRWFAsIFNDVSB1c2VzIE1VMSBnZW5lcmFsIGludGVycnVwdCBjaGFubmVsICMzIHRv
IG5vdGlmeQ0KdXNlciBmb3IgSVJRcyBvZiBSVEMgYWxhcm0sIHRoZXJtYWwgYWxhcm0gYW5kIFdE
T0cgZXRjLiwgbWFpbGJveA0KUlggZG9vcmJlbGwgbW9kZSBpcyB1c2VkIGZvciB0aGlzIGZ1bmN0
aW9uLCB0aGlzIHBhdGNoIGFkZHMNCnN1cHBvcnQgZm9yIGl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBB
bnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NClJldmlld2VkLWJ5OiBEb25nIEFpc2hl
bmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KLS0tDQpObyBjaGFuZ2VzLg0KLS0tDQogYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpIHwgNyArKysrKy0tDQogMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaSBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KaW5kZXggMGNiOTM5OC4uNzBlZjNkYiAx
MDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0K
KysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQpAQCAtMjEs
NiArMjEsNyBAQA0KIAkJbW1jMSA9ICZ1c2RoYzI7DQogCQltbWMyID0gJnVzZGhjMzsNCiAJCXNl
cmlhbDAgPSAmYWRtYV9scHVhcnQwOw0KKwkJbXUxID0gJmxzaW9fbXUxOw0KIAl9Ow0KIA0KIAlj
cHVzIHsNCkBAIC0xMTcsNyArMTE4LDggQEANCiAJc2N1IHsNCiAJCWNvbXBhdGlibGUgPSAiZnNs
LGlteC1zY3UiOw0KIAkJbWJveC1uYW1lcyA9ICJ0eDAiLCAidHgxIiwgInR4MiIsICJ0eDMiLA0K
LQkJCSAgICAgInJ4MCIsICJyeDEiLCAicngyIiwgInJ4MyI7DQorCQkJICAgICAicngwIiwgInJ4
MSIsICJyeDIiLCAicngzIiwNCisJCQkgICAgICJnaXAzIjsNCiAJCW1ib3hlcyA9IDwmbHNpb19t
dTEgMCAwDQogCQkJICAmbHNpb19tdTEgMCAxDQogCQkJICAmbHNpb19tdTEgMCAyDQpAQCAtMTI1
LDcgKzEyNyw4IEBADQogCQkJICAmbHNpb19tdTEgMSAwDQogCQkJICAmbHNpb19tdTEgMSAxDQog
CQkJICAmbHNpb19tdTEgMSAyDQotCQkJICAmbHNpb19tdTEgMSAzPjsNCisJCQkgICZsc2lvX211
MSAxIDMNCisJCQkgICZsc2lvX211MSAzIDM+Ow0KIA0KIAkJY2xrOiBjbG9jay1jb250cm9sbGVy
IHsNCiAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLWNsayI7DQotLSANCjIuNy40DQoNCg==
