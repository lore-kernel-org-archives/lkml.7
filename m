Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA299C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCC120843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W+pee1OO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEOHx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:53:28 -0400
Received: from mail-eopbgr10046.outbound.protection.outlook.com ([40.107.1.46]:7687
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbfEOHx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RHNfrQxWyqSDLZR872gbfoJOD0gu1pFD9KgCEZ4/ms=;
 b=W+pee1OOh76b55NJhFiC1HG3vCDzKIT2GiEIyeiYhs0ZVVJkKys0Z9wek8e7/FG5FkDrF3V9eX6cDyyM1AB5qbHgMIz/dAtR/Wwz7v8a6jZaGwlohKZWXLXMGKtqLAWZzNqKqx61UnvrRJyiBkT31DwVX5XEHoYupotppHeHIP0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6067.eurprd04.prod.outlook.com (20.179.32.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Wed, 15 May 2019 07:53:23 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 07:53:23 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V3 1/4] dt-bindings: fsl: scu: add ocotp binding
Thread-Topic: [PATCH V3 1/4] dt-bindings: fsl: scu: add ocotp binding
Thread-Index: AQHVCvNFnuiFecqWJ06/DpqJTtk4vg==
Date:   Wed, 15 May 2019 07:53:23 +0000
Message-ID: <20190515080703.19147-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::32) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa01d7c9-d6e8-4a8e-a117-08d6d90a67bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6067;
x-ms-traffictypediagnostic: AM0PR04MB6067:
x-microsoft-antispam-prvs: <AM0PR04MB606775AF19028758DF9DB7BA88090@AM0PR04MB6067.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(66946007)(73956011)(71190400001)(71200400001)(2501003)(66476007)(64756008)(81166006)(66556008)(256004)(2906002)(66446008)(53936002)(305945005)(186003)(102836004)(26005)(6512007)(7416002)(4326008)(7736002)(6116002)(3846002)(36756003)(66066001)(81156014)(8676002)(8936002)(44832011)(110136005)(316002)(50226002)(6636002)(25786009)(2616005)(478600001)(486006)(476003)(6436002)(6486002)(54906003)(1076003)(99286004)(52116002)(86362001)(386003)(6506007)(68736007)(14454004)(2201001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6067;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w6bKufeR6+K0D6i2I1oAKqmSy/xLyy8FMRHcnyTLIU4nuBKf25/Mo1hmr1+NgXppJRuMd6p7TABpqpVHRHPovOe11PgRCZMgTNjsKQCTqmSIXWPsmKcvhtHyfpkiF4IcqZwQp6RiMH+NB9ZuzWhS2jjaPciKMk5+OodkhHnVprwVgs4NEl9BpVPPALg3+Vylh2e7N+4aUOfU71qshwjvKuUM33Z1fVMUCg5aSAlZr3zff8rM9EtSJX7+ul5/3fpRO9g3G1wmkQIPXqngIaJIMIW0JYUm8mmBUk6m4Rwmvo5ChffKgDNannyqeoWbvUAni7iaw4woYS5BhAwayULs7PcV8UxeIhKQquCAcvtOHbDZlUd6/x270ogcrivxKRIWlRHt19i2Xhqsw4Q0ozuUO9c9+MpS2gKnqzkK+yNKJss=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa01d7c9-d6e8-4a8e-a117-08d6d90a67bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 07:53:23.6213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TlhQIGkuTVg4UVhQIGlzIGFuIEFSTXY4IFNvQyB3aXRoIGEgQ29ydGV4LU00IGNvcmUgaW5zaWRl
IGFzDQpzeXN0ZW0gY29udHJvbGxlcihTQ1UpLCB0aGUgb2NvdHAgY29udHJvbGxlciBpcyBiZWlu
ZyBjb250cm9sbGVkDQpieSB0aGUgU0NVLCBzbyBMaW51eCBuZWVkIHVzZSBSUEMgdG8gU0NVIGZv
ciBvY290cCBoYW5kbGluZy4gVGhpcw0KcGF0Y2ggYWRkcyBiaW5kaW5nIGRvYyBmb3IgaS5NWDgg
U0NVIE9DT1RQIGRyaXZlci4NCg0KQ2M6IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5j
b20+DQpDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KQ2M6IFVsZiBIYW5zc29u
IDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KQ2M6IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVs
Lm9yZz4NCkNjOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCkNjOiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZw0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5l
bC5vcmc+DQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KLS0tDQoNClYzOg0K
IEFkZCBSLWIgdGFnDQpWMjoNCiBNb3ZlIE9DT1RQIHRvIGVuZCwgYWRkIGV4YW1wbGUsIGFkZCAi
c2N1Ig0KDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4
dCAgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCmluZGV4IDVkN2RiYWJiYjc4NC4uZjM3
ODkyMjkwNmY2IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQpAQCAtMTMzLDYgKzEzMywxOCBA
QCBSVEMgYmluZGluZ3MgYmFzZWQgb24gU0NVIE1lc3NhZ2UgUHJvdG9jb2wNCiBSZXF1aXJlZCBw
cm9wZXJ0aWVzOg0KIC0gY29tcGF0aWJsZTogc2hvdWxkIGJlICJmc2wsaW14OHF4cC1zYy1ydGMi
Ow0KIA0KK09DT1RQIGJpbmRpbmdzIGJhc2VkIG9uIFNDVSBNZXNzYWdlIFByb3RvY29sDQorLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQorUmVxdWlyZWQgcHJvcGVydGllczoNCistIGNvbXBhdGlibGU6CQlTaG91bGQgYmUgImZzbCxp
bXg4cXhwLXNjdS1vY290cCINCistICNhZGRyZXNzLWNlbGxzOglNdXN0IGJlIDEuIENvbnRhaW5z
IGJ5dGUgaW5kZXgNCistICNzaXplLWNlbGxzOgkJTXVzdCBiZSAxLiBDb250YWlucyBieXRlIGxl
bmd0aA0KKw0KK09wdGlvbmFsIENoaWxkIG5vZGVzOg0KKw0KKy0gRGF0YSBjZWxscyBvZiBvY290
cDoNCisgIERldGFpbGVkIGJpbmRpbmdzIGFyZSBkZXNjcmliZWQgaW4gYmluZGluZ3MvbnZtZW0v
bnZtZW0udHh0DQorDQogRXhhbXBsZSAoaW14OHF4cCk6DQogLS0tLS0tLS0tLS0tLQ0KIGFsaWFz
ZXMgew0KQEAgLTE3Nyw2ICsxODksMTYgQEAgZmlybXdhcmUgew0KIAkJCS4uLg0KIAkJfTsNCiAN
CisJCW9jb3RwOiBpbXg4cXgtb2NvdHAgew0KKwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAt
c2N1LW9jb3RwIjsNCisJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCisJCQkjc2l6ZS1jZWxscyA9
IDwxPjsNCisNCisJCQlmZWNfbWFjMDogbWFjQDJjNCB7DQorCQkJCXJlZyA9IDwweDJjNCA4PjsN
CisJCQl9Ow0KKwkJfTsNCisNCiAJCXBkOiBpbXg4cXgtcGQgew0KIAkJCWNvbXBhdGlibGUgPSAi
ZnNsLGlteDhxeHAtc2N1LXBkIiwgImZzbCxzY3UtcGQiOw0KIAkJCSNwb3dlci1kb21haW4tY2Vs
bHMgPSA8MT47DQotLSANCjIuMTYuNA0KDQo=
