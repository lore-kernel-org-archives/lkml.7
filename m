Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B64C04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBACA20645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ngkd+/ys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfETDGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 23:06:39 -0400
Received: from mail-eopbgr40054.outbound.protection.outlook.com ([40.107.4.54]:5797
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbfETDGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 23:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhXOXypipUiDEKr/DnRIQvGKXNk+ZjIhFTsB5iUJHf4=;
 b=Ngkd+/ysnFQQ4530T9IEPS7ZFtfmi35ZG/khLhFg+HxQ1fmaIAs46Hnu4bwRDPpJ+FgULp09V/2B6gHgREcugQVpwY9Zcy4lBKz1vGc8o+RAqTjAHn8W1mGtcw/R6muGUGaGnl/wtgPCEj8EzvVbcQW5e08Qs3rKTtAsfgSz4yI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6611.eurprd04.prod.outlook.com (20.179.255.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 03:06:35 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 03:06:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [RFC 1/2] dt-bindings: imx-ocotp: Add fusable-node property
Thread-Topic: [RFC 1/2] dt-bindings: imx-ocotp: Add fusable-node property
Thread-Index: AQHVDrkIcB6j+hDf/kC51b4HJvSviA==
Date:   Mon, 20 May 2019 03:06:35 +0000
Message-ID: <20190520032020.7920-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR03CA0055.apcprd03.prod.outlook.com
 (2603:1096:203:52::19) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a61d514-2f7a-40b8-bdaa-08d6dcd02acf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6611;
x-ms-traffictypediagnostic: AM0PR04MB6611:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB661101DD4745AB44AA2DD09988060@AM0PR04MB6611.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(199004)(66556008)(66946007)(66476007)(64756008)(5660300002)(99286004)(73956011)(6116002)(3846002)(66446008)(53936002)(6486002)(7416002)(1076003)(71190400001)(6436002)(36756003)(6512007)(6306002)(71200400001)(2201001)(68736007)(86362001)(305945005)(81156014)(81166006)(8936002)(50226002)(25786009)(2906002)(8676002)(478600001)(4326008)(14454004)(7736002)(966005)(2501003)(486006)(316002)(256004)(102836004)(110136005)(14444005)(52116002)(476003)(2616005)(66066001)(186003)(54906003)(386003)(26005)(44832011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6611;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a5zYB9UrfL6DpFUzobCRwZv+HZZgqA7+PwgsVyJ8lFT47UPTcUOLOxaxQKHBBfUGoVHZOu2JWMnvUdIaPVD4wgbOz7/qB6dfv3FxduCV/xbXRPFVpsPrL7ob2NHwjMICVRGNWsGGx/xmT9jeEiBtEJLGnCR+rSBYBkHKaDk6ASOwmzxVuDBvDhBwpnUhTULhxUakLEgnLgo8/FKZ6QcSyFXRRSL2X/9qJutMY8Kdru36Ngo8bPXYjnzqpRts550n4oV+cLgV3R/+jWD24lagmjPEc+bbDnMeR/Y3fj/hEQxRI1zdEEZelkUDIA7GaATMNKzyVX9n4Kj9a2H9fj55nQOrjfsNz+ktgK57hYtIQ8qZjmnWle707ih3yR4RKgIbUg5SqoO6Ob6bddpar3yMC0AdNE2s225IxXZMkXjSRa0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a61d514-2f7a-40b8-bdaa-08d6dcd02acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 03:06:35.1558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6611
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW50cm9kdWNlIGZ1c2FibGUtbm9kZSBwcm9wZXJ0eSBmb3IgaS5NWCBPQ09UUCBkcml2ZXIuDQpU
aGUgcHJvcGVydHkgd2lsbCBvbmx5IGJlIHVzZWQgYnkgRmlybXdhcmUoZWcuIFUtQm9vdCkgdG8N
CnJ1bnRpbWUgZGlzYWJsZSB0aGUgbm9kZXMuDQoNClRha2UgaS5NWDZVTEwgZm9yIGV4YW1wbGUs
IHRoZXJlIGFyZSBzZXZlcmFsIHBhcnRzIHRoYXQgb25seQ0KaGF2ZSBsaW1pdGVkIG1vZHVsZXMg
ZW5hYmxlZCBjb250cm9sbGVkIGJ5IE9DT1RQIGZ1c2UuIEl0IGlzDQpub3QgZmxleGlibGUgdG8g
cHJvdmlkZSBzZXZlcmFsIGR0cyBmb3IgdGhlIHNlcnZhbCBwYXJ0cywgaW5zdGVhZA0Kd2UgY291
bGQgcHJvdmlkZSBvbmUgZGV2aWNlIHRyZWUgYW5kIGxldCBGaXJtd2FyZSB0byBydW50aW1lIGRp
c2FibGUNCnRoZSBkZXZpY2UgdHJlZSBub2RlcyBmb3IgdGhvc2UgbW9kdWxlcyB0aGF0IGFyZSBk
aXNhYmxlKGZ1c2VkKS4NCg0KU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+DQotLS0NCg0KQ3VycmVudGx5IE5YUCB2ZW5kb3IgdXNlIFUtQm9vdCB0byBzZXQgc3RhdHVz
IHRvIGRpc2FibGVkIGZvciBkZXZpY2VzDQp0aGF0IGNvdWxkIG5vdCBmdW5jdGlvbiwNCmh0dHBz
Oi8vc291cmNlLmNvZGVhdXJvcmEub3JnL2V4dGVybmFsL2lteC91Ym9vdC1pbXgvdHJlZS9hcmNo
L2FybS9tYWNoLWlteC9teDYvbW9kdWxlX2Z1c2UuYz9oPWlteF92MjAxOC4wM180LjE0Ljk4XzIu
MC4wX2dhI24xNDkNCkJ1dCB0aGlzIGFwcHJvYWNoIGlzIHdpbGwgbm90IHdvcmsgaWYga2VybmVs
IGR0cyBub2RlIHBhdGggY2hhbmdlZC4NCg0KVGhlcmUgYXJlIHR3byBhcHByb2FjaGVzIHRvIHJl
c29sdmU6DQoNCjEuIFRoaXMgcGF0Y2ggaXMgdG8gYWRkIGEgZnVzYWJsZS1ub2RlIHByb3BlcnR5
LCBhbmQgRmlybXdhcmUgd2lsbCBwYXJzZQ0KICAgdGhlIHByb3BlcnR5IGFuZCByZWFkIGZ1c2Ug
dG8gZGVjaWRlIHdoZXRoZXIgdG8gZGlzYWJsZSBvciBrZWVlcCBlbmFibGUNCiAgIHRoZSBub2Rl
cy4NCg0KMi4gVGhlcmUgaXMgYW5vdGhlciBhcHByb2FjaCBpcyB0aGF0IGFkZCBudm1lbS1jZWxs
cyBmb3IgYWxsIG5vZGVzIHRoYXQNCiAgIGNvdWxkIGJlIGRpc2FibGVkKGZ1c2VkKS4gVGhlbiBp
biBlYWNoIGxpbnV4IGRyaXZlciB0byB1c2UgbnZtZW0NCiAgIGFwaSB0byBkZXRlY3QgZnVzZWQg
b3Igbm90LCBvciBpbiBsaW51eCBkcml2ZXIgY29tbW9uIGNvZGUgdG8gY2hlY2sNCiAgIGRldmlj
ZSBmdW5jdGlvbmFibGUgb3Igbm90IHdpdGggbnZtZW0gQVBJLg0KDQoNClRvIG1ha2UgaXQgZWFz
eSB0byB3b3JrLCB3ZSBjaG9vc2UgWzFdIGhlcmUuIFBsZWFzZSBhZHZpc2Ugd2hldGhlcg0KaXQg
aXMgYWNjZXB0YWJsZSwgYmVjYXVzZSB0aGUgcHJvcGVydHkgaXMgbm90IHVzZWQgYnkgbGludXgg
ZHJpdmVyIGluDQphcHByb2FjaCBbMV0uIE9yIHlvdSBwcmVmZXIgWzJdIG9yIHBsZWFzZSBhZHZp
c2UgaWYgYW55IGJldHRlciBzb2x1dGlvbi4NCg0KVGhhbmtzLg0KDQogRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL252bWVtL2lteC1vY290cC50eHQgfCA1ICsrKysrDQogMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL252bWVtL2lteC1vY290cC50eHQgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbnZtZW0vaW14LW9jb3RwLnR4dA0KaW5kZXggN2E5OTlhMTM1ZTU2
Li5lOWE5OTg1ODhkYmQgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbnZtZW0vaW14LW9jb3RwLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL252bWVtL2lteC1vY290cC50eHQNCkBAIC0yMSw2ICsyMSw4IEBAIFJlcXVpcmVk
IHByb3BlcnRpZXM6DQogDQogT3B0aW9uYWwgcHJvcGVydGllczoNCiAtIHJlYWQtb25seTogZGlz
YWJsZSB3cml0ZSBhY2Nlc3MNCistIGZ1c2FibGUtbm9kZTogYXJyYXkgb2YgcGhhbmRsZXMgd2l0
aCByZWcgYmFzZSBhbmQgYml0IG9mZnNldCwgdGhpcw0KKwkJcHJvcGVydHkgaXMgdXNlZCBieSBG
aXJtd2FyZSB0byBydW50aW1lIGRpc2FibGUgbm9kZXMuDQogDQogT3B0aW9uYWwgQ2hpbGQgbm9k
ZXM6DQogDQpAQCAtNDIsNCArNDQsNyBAQCBFeGFtcGxlOg0KIAkJdGVtcG1vbl90ZW1wX2dyYWRl
OiB0ZW1wLWdyYWRlQDIwIHsNCiAJCQlyZWcgPSA8MHgyMCA0PjsNCiAJCX07DQorDQorCQlmdXNh
YmxlLW5vZGUgPSA8JnVzZGhjMSAweDEwIDQNCisJCQkJJnVzZGhjMiAweDEwIDU+Ow0KIAl9Ow0K
LS0gDQoyLjE2LjQNCg0K
