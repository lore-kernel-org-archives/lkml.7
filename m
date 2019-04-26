Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C87C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4EF206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A5zQQjjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfDZIGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:06:09 -0400
Received: from mail-eopbgr50069.outbound.protection.outlook.com ([40.107.5.69]:17514
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbfDZIGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOw/nd6mZWn6uySvaALabGejFn7LilUgKaLDKkOCWTc=;
 b=A5zQQjjGuqIizkzgE2Qdt6x6J0RdD7vrzJ1ijSGahss+kKRUdXi8Zr8jJ39Vp670uG6U1O0ioGi4eOteh610JycB2Ethff1ln1l4Lg5gY7jLRqrRev3e1umMu9DgY9y3zv9kLrkz3wxTvRql7UOJijy7MvyipYfqG3b0wVbXmoc=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB6109.eurprd04.prod.outlook.com (20.179.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 08:06:03 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:06:03 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v2 10/15] dt-bindings: dma: imx-sdma: add i.mx6ul/6sx
 compatible name
Thread-Topic: [PATCH v2 10/15] dt-bindings: dma: imx-sdma: add i.mx6ul/6sx
 compatible name
Thread-Index: AQHU/Abk4gzgMZhpe06l0q1L0twpQQ==
Date:   Fri, 26 Apr 2019 08:06:03 +0000
Message-ID: <1556265512-9130-11-git-send-email-yibin.gong@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::36) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d1818c9-69c9-41e3-6914-08d6ca1e06b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6109;
x-ms-traffictypediagnostic: VI1PR04MB6109:
x-microsoft-antispam-prvs: <VI1PR04MB6109FB4DC2942313A03376E6893E0@VI1PR04MB6109.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(189003)(199004)(68736007)(478600001)(110136005)(4744005)(99286004)(186003)(53936002)(102836004)(76176011)(25786009)(386003)(6506007)(2501003)(4326008)(52116002)(446003)(11346002)(6512007)(97736004)(26005)(486006)(316002)(2616005)(476003)(7736002)(54906003)(71190400001)(305945005)(71200400001)(256004)(14454004)(2906002)(7416002)(8676002)(81156014)(81166006)(36756003)(6486002)(8936002)(50226002)(66946007)(66476007)(66556008)(64756008)(66066001)(66446008)(2201001)(6436002)(86362001)(6116002)(5660300002)(3846002)(73956011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6109;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8Wz5O7bdoQ1i8aTca3t7Lcsuuvl5aaJN+n7PcGCY0c4mrwHOwfX+bmm9Sx7RPYmPm4MmTBkJGqo/w9z2n9aM21GnOK3IBr7YMJkflGVlZwDzIWIJ/8TC835CxH3fuztNHrE5wkBfyWvlo8QiAn3FX8unHJsc9tfZoeorkuqwEUyyga0eFHnjBHHNgC/XFShfIA2jkmo1JB9HwZlT80AzIw1kwmWC8xbypSBdDpXuUxdKGFyBZZjz7W9FFs5WQQ7QVb/5LPL2AHAtlPAP30GsgeQwbF9dhM6vWJ/zdFwXRtsyVU9saXJtLFtzlOKcE14pynTsGKvysJu8TC8SF7fBUbHLTJyoxhl6jc7J6ENj6H5IGxgA0ORh4bp/NhUuT6DnCeZ+ExkrGmmkL6dzsHEMb77FXj2HB4SnIEM0IiCCjoU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1818c9-69c9-41e3-6914-08d6ca1e06b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:06:03.5231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGkubXg2dWwgYW5kIGkubXg2c3ggY29tcGF0aWJsZSBuYW1lLg0KDQpTaWduZWQtb2ZmLWJ5
OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS50eHQgfCAyICsrDQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0DQppbmRleCA5ZDhiYmFjLi5kMDI0
YTgzIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9m
c2wtaW14LXNkbWEudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZG1hL2ZzbC1pbXgtc2RtYS50eHQNCkBAIC05LDYgKzksOCBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVz
Og0KICAgICAgICJmc2wsaW14NTMtc2RtYSINCiAgICAgICAiZnNsLGlteDZxLXNkbWEiDQogICAg
ICAgImZzbCxpbXg3ZC1zZG1hIg0KKyAgICAgICJmc2wsaW14NnN4LXNkbWEiDQorICAgICAgImZz
bCxpbXg2dWwtc2RtYSINCiAgICAgICAiZnNsLGlteDhtcS1zZG1hIg0KICAgVGhlIC10byB2YXJp
YW50cyBzaG91bGQgYmUgcHJlZmVycmVkIHNpbmNlIHRoZXkgYWxsb3cgdG8gZGV0ZXJtaW5lIHRo
ZQ0KICAgY29ycmVjdCBST00gc2NyaXB0IGFkZHJlc3NlcyBuZWVkZWQgZm9yIHRoZSBkcml2ZXIg
dG8gd29yayB3aXRob3V0IGFkZGl0aW9uYWwNCi0tIA0KMi43LjQNCg0K
