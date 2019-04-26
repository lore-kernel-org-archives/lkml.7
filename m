Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33327C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0699208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aXUTs9JD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfDZIFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:05:39 -0400
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:7942
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbfDZIFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDn8j2HqvkAgGOvzsK2c8evs0ozo2pfez6/Fl92rAdQ=;
 b=aXUTs9JDxLkFWlXOrvzGbZ/VcCXtDxydJDsyd0aW7Bxwzahq/uFFSxV5MIBBoBMUMRPMNLdkLPhqQKUMZwrU2Me6BZH0hhImRnB9wJmwV40qEAt9FXCmGwVeuf6I5dj3stTgZ40d13euZ//oROeLaGuHg1HFbgQUMg9rzUBAMs0=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB6109.eurprd04.prod.outlook.com (20.179.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 08:05:11 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:05:11 +0000
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
Subject: [PATCH v2 01/15] Revert "ARM: dts: imx6q: Use correct SDMA script for
 SPI5 core"
Thread-Topic: [PATCH v2 01/15] Revert "ARM: dts: imx6q: Use correct SDMA
 script for SPI5 core"
Thread-Index: AQHU/AbFXzucfL2CMEuJHVlmLX+6ow==
Date:   Fri, 26 Apr 2019 08:05:10 +0000
Message-ID: <1556265512-9130-2-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 1700f021-cc3a-4449-c6a4-08d6ca1de753
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6109;
x-ms-traffictypediagnostic: VI1PR04MB6109:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB61090208ECD4A0529C19B881893E0@VI1PR04MB6109.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(189003)(199004)(68736007)(478600001)(110136005)(99286004)(186003)(53936002)(102836004)(76176011)(25786009)(386003)(6506007)(2501003)(4326008)(6306002)(52116002)(446003)(11346002)(6512007)(97736004)(26005)(486006)(316002)(2616005)(476003)(7736002)(54906003)(71190400001)(305945005)(71200400001)(14444005)(256004)(14454004)(2906002)(7416002)(8676002)(81156014)(81166006)(36756003)(6486002)(8936002)(50226002)(66946007)(66476007)(66556008)(64756008)(66066001)(66446008)(2201001)(6436002)(86362001)(6116002)(5660300002)(3846002)(73956011)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6109;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D90TpumtTBf133z1XVjlu7QHkTSR1qDWHxV2BUzkW+a6DGbWeypC8xRQ/kPygeer7Vq19rvQbkUNrm2KGwGCEWwv0HN1e73MJTYgeNeqpVACbcsuiSl7Q33BuXO8cYPGzpkL55c6gwogiPUpbnoIi2gDFqcoiV9ATivXEJJGfyNIerflMR6pD5bzSrRbSZJ2ebUMn+cJlZn6YpiV17g9z3SCVrbAtNhlKspNiyKwXy4gKv8t6fO9mj5yEC6uD/Md/SLqIxDnIs1cRLFo2wshDCDc3hP69zDsit6MeawaxbBQSQnYcHvOjVJZX0umpqPvAA7d87jUln4E1EqUAtIT9lrGxH3IwxGaKzwIXxibM9NLmpKOJvqDIXDyNDFI+3JgCXmFyP+aLOXIZnKjy8qaL8VMnpR+G+tZ3svg/+woc90=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1700f021-cc3a-4449-c6a4-08d6ca1de753
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:05:10.9887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICBUaGVyZSBhcmUgdHdvIHdheXMgZm9yIFNETUEgYWNjZXNzaW5nIFNQQkEgZGV2aWNlczogb25l
IGlzIFNETUEtPkFJUFMNCi0+U1BCQShtYXN0ZXJBIHBvcnQpLCBhbm90aGVyIGlzIFNETUEtPlNQ
QkEobWFzdGVyQyBwb3J0KS4gUGxlYXNlIHJlZmVyDQp0byB0aGUgJ0ZpZ3VyZSA1OC0xLiBpLk1Y
IDZEdWFsLzZRdWFkIFNQQkEgY29ubmVjdGl2aXR5JyBvZiBpLm14NkRRDQpSZWZlcmVuY2UgTWFu
dWFsLiBTRE1BIHByb3ZpZGUgdGhlIGNvcnJlc3BvbmRpbmcgYXBwXzJfbWN1L21jdV8yX2FwcCBh
bmQNCnNocF8yX21jdS9tY3VfMl9zaHAgc2NyaXB0IGZvciBzdWNoIHR3byBvcHRpb25zLiBTbyBi
b3RoIEFJUFMgYW5kIFNQQkENCnNjcmlwdHMgc2hvdWxkIGtlZXAgdGhlIHNhbWUgYmVoYXZpb3Vy
LCB0aGUgaXNzdWUgb25seSBjYXVnaHQgaW4gQUlQUw0Kc2NyaXB0IHNvdW5kcyBub3Qgc29saWRl
Lg0KICBUaGUgaXNzdWUgaXMgbW9yZSBsaWtlbHkgYXMgdGhlIGVjc3BpIGVycmF0YQ0KRVJSMDA5
MTY1KGh0dHA6Ly93d3cubnhwLmNvbS9kb2NzL2VuL2VycmF0YS9JTVg2RFFDRS5wZGYpOg0KZUNT
UEk6IFRYRklGTyBlbXB0eSBmbGFnIGdsaXRjaCBjYW4gY2F1c2UgdGhlIGN1cnJlbnQgRklGTyB0
cmFuc2ZlciB0bw0KICAgICAgIGJlIHNlbnQgdHdpY2UNClNvIHJldmVydCBjb21taXQgJ2RmMDcx
MDFlMWM0YScgZmlyc3RseS4NCg0KU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29u
Z0BueHAuY29tPg0KLS0tDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEuZHRzaSB8IDIgKy0NCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2
cS5kdHNpDQppbmRleCBkMDM4ZjQxLi43MTc1ODk4IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9v
dC9kdHMvaW14NnEuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEuZHRzaQ0KQEAg
LTE3Miw3ICsxNzIsNyBAQA0KIAkJCQkJY2xvY2tzID0gPCZjbGtzIElNWDZRX0NMS19FQ1NQSTU+
LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlFfQ0xLX0VDU1BJNT47DQogCQkJCQljbG9jay1uYW1lcyA9
ICJpcGciLCAicGVyIjsNCi0JCQkJCWRtYXMgPSA8JnNkbWEgMTEgOCAxPiwgPCZzZG1hIDEyIDgg
Mj47DQorCQkJCQlkbWFzID0gPCZzZG1hIDExIDcgMT4sIDwmc2RtYSAxMiA3IDI+Ow0KIAkJCQkJ
ZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCiAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCQkJ
CX07DQotLSANCjIuNy40DQoNCg==
