Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834DBC10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CE1213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZNurp+vF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfDICoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:44:00 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:4482
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726770AbfDICn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LC5mqqk0kxv9DkPMYsSbW2MxhUz4skkSigTBQxFhAYo=;
 b=ZNurp+vFJzfvuGgr59ftgrTymvRuoA5/RtIBR7jeLQZGeOQJhTdAuYHYuZkEiYDnkiSwHlIeqSwa0/gRehYp/xgoUUZXTcUxGB8OXyb3JxWwLzkMT5CFO1MXAOF5R9dMKJ0TPJ5wQSmNf0wzwaY52xcd9Jo+XWW3JfFOGFqc0lU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.18; Tue, 9 Apr 2019 02:43:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 02:43:24 +0000
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
Subject: [PATCH V6 3/4] arm64: dts: freescale: imx8qxp: enable scu general irq
 channel
Thread-Topic: [PATCH V6 3/4] arm64: dts: freescale: imx8qxp: enable scu
 general irq channel
Thread-Index: AQHU7n4AnkSKL9EipUWUOLQSZBzgEg==
Date:   Tue, 9 Apr 2019 02:43:23 +0000
Message-ID: <1554777487-31075-3-git-send-email-Anson.Huang@nxp.com>
References: <1554777487-31075-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554777487-31075-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e396483-7cb5-4b60-90c9-08d6bc952287
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB3929982C254D651147E1539DF52D0@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(6512007)(53936002)(102836004)(478600001)(14454004)(6116002)(3846002)(7416002)(99286004)(97736004)(386003)(6506007)(305945005)(186003)(110136005)(4326008)(7736002)(316002)(256004)(25786009)(26005)(446003)(2616005)(11346002)(5660300002)(105586002)(2501003)(106356001)(486006)(6436002)(6486002)(2906002)(476003)(68736007)(71190400001)(8936002)(81166006)(81156014)(50226002)(2201001)(86362001)(76176011)(52116002)(71200400001)(36756003)(8676002)(66066001)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JzBI8DuQJNCCSG051A2xTCCIk0cgjJ/+XWU9ceimB4H83EbFtdL0NhrHcxrj6+moSe+scbX/UdgGKw/Sbp0vAL9iKiCEMqvjTtpB49FuceMUhWUYR+SfuN1RSIKmOEllMSixFV/Je+mOCPs+AeE1WuASjdKuXLIj/hKMXwF7il4wsJM1x9lrZ+ShbbGANrFqAJAuAc1so02WnjgktB0ccLvYX0bIzZ+HYdUe23UPNTVJitmN1WDbM6xiOKJ9TCTXKGSJlcyKiM93JZ3jzrYa28/xOS59y1PK9guYmazMuOpIdYVypTNei7PxZB9am4AjqMRB/yeCIKj2cIb3845fSuDFiY4qTBjy4G57ooPBeEgidBMwIgD6/6J2+gx2pUlhQQ0MY5YDZmOCBrr5HvnH48sA5MaXhblIKxdf81Wl3jE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e396483-7cb5-4b60-90c9-08d6bc952287
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 02:43:23.9786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
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
