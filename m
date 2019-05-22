Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1874CC072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F762184C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bDeY9pvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfEVBrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 21:47:00 -0400
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:21078
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727208AbfEVBq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RHNfrQxWyqSDLZR872gbfoJOD0gu1pFD9KgCEZ4/ms=;
 b=bDeY9pvS/i1KcbQIOeGPHCaUGFOfeH+ka0IiILIbsSjA5XTHHG+Tjsek15PBAoZu0UndQmO89dE5IsCXFD+ZdcgfzEjagHi8AsRAw/VKDTiiH6jxSqanS8W8EIShdnKtgY++zXqPoBXpGZo7PVFs4g4gfOevLV1MP6v14XVR1Fc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5954.eurprd04.prod.outlook.com (20.178.115.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Wed, 22 May 2019 01:46:54 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 01:46:54 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
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
Subject: [PATCH V3 RESEND 1/4] dt-bindings: fsl: scu: add ocotp binding
Thread-Topic: [PATCH V3 RESEND 1/4] dt-bindings: fsl: scu: add ocotp binding
Thread-Index: AQHVEEA7lZzUdNknZUKkARJ4QlFfvw==
Date:   Wed, 22 May 2019 01:46:54 +0000
Message-ID: <20190522020040.30283-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:203:36::28) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0df361c4-6cba-4199-afd0-08d6de575e55
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5954;
x-ms-traffictypediagnostic: AM0PR04MB5954:
x-microsoft-antispam-prvs: <AM0PR04MB595406AC9C805676938CB54488000@AM0PR04MB5954.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(44832011)(486006)(2501003)(186003)(305945005)(476003)(2616005)(2906002)(71190400001)(71200400001)(14454004)(52116002)(99286004)(256004)(102836004)(26005)(6116002)(3846002)(6506007)(68736007)(386003)(498600001)(5660300002)(54906003)(110136005)(6512007)(6486002)(50226002)(4326008)(66066001)(25786009)(6436002)(53936002)(2201001)(8676002)(8936002)(81166006)(81156014)(73956011)(66946007)(86362001)(66476007)(66556008)(64756008)(66446008)(1076003)(7416002)(36756003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5954;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KvAga1kkNE42dcp8CCllHdZhvVURYHM8HLMXY7YBhUiznfowQvPb7r4JDyeBXDq4asO+8qYr/GeNGBPAVcNnFyRP4kbkdeDm8VmlUwJ1B9tMIf4VsSNrPlzNFbPj+3MMZ+KbC5BdH0sBIRqQU1A1cQlgxzX5m2Gu8I4cB/aiayUp02C+OLgRUobzgoU4ViWyBKV4HTyjTzFH11yb0MC5GevIgQcNEuyGOpJiYpN0lh5xAXmwdTypIGhSD1yAx6jhb3IOHtEr6mDHogVafirQzX7e1q4QsYBo6miP6dOyhM7IfupAyNDuEJGwceg8c+YhJORFSKsyr9lVePWO1segn/QpKv5FC8Thr6duDa/MEL3v01fIMriD4ygCNGkPaP69u9pZsh5XwC3eV1k5T5AhHkompePGHom6Vz66/rtqIgE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df361c4-6cba-4199-afd0-08d6de575e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 01:46:54.8087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5954
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
