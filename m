Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E4FC04AAB
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC07206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JBb/iIZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfEEN2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:28:18 -0400
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:2283
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfEEN2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxEm8J29UxXfpDXr9UMREWdvUBJfBSp6Off20hvufwY=;
 b=JBb/iIZCiUj/DZAudklgfQrG4GlUHvuWeCziw0U4aqboNzyMpeig6ccH3rINKjuhi//DHUpqBu9i2RG28wbmOW/FiAgEcsBZub7/2KcTa9b/FJIIxk0aSHgZBa1l8QuehBK2QaKIvkFazzCjI/Is7U18pG4nOp42rZRRZoFvzYw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4259.eurprd04.prod.outlook.com (52.134.126.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Sun, 5 May 2019 13:28:13 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 13:28:13 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Anson Huang <anson.huang@nxp.com>
Subject: [PATCH 1/4] dt-bindings: fsl: scu: add ocotp binding
Thread-Topic: [PATCH 1/4] dt-bindings: fsl: scu: add ocotp binding
Thread-Index: AQHVA0ZjnXjmGbRNIUCIpXt7yxOkeg==
Date:   Sun, 5 May 2019 13:28:13 +0000
Message-ID: <20190505134130.28071-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:203:b0::15) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23060414-4bb9-4771-fb72-08d6d15d860c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4259;
x-ms-traffictypediagnostic: AM0PR04MB4259:
x-microsoft-antispam-prvs: <AM0PR04MB425900E9B81EF98DDC3A1CAD88370@AM0PR04MB4259.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(366004)(346002)(189003)(199004)(486006)(54906003)(110136005)(68736007)(2906002)(476003)(2616005)(8936002)(8676002)(66066001)(81166006)(7416002)(7736002)(305945005)(44832011)(53936002)(36756003)(50226002)(4326008)(25786009)(86362001)(2201001)(1076003)(5660300002)(81156014)(52116002)(99286004)(102836004)(316002)(6506007)(3846002)(6116002)(386003)(478600001)(256004)(6512007)(71200400001)(14454004)(6486002)(6436002)(2501003)(66946007)(73956011)(186003)(71190400001)(66446008)(26005)(66476007)(66556008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4259;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GTBQ1hQBdPk5hc+m2fjhSGkq5w/Wau0EfXw1SVNc0lHonYPzGtQV1hAv29eCfuu5YLF3y7NXkuTwMUN1uMP+WN468aWIeaNI+sDmkXV1Er7PVt1Sr5mnhgGlNdodB9wY5s1oXN1tb8PgJkhpz81d8wToFO7X7pZfD45jWJyYHoj2t2sPQcN7lTVG40RhDodZVXHUWlQsspWz4FSATSoXSAxKhAqMgb1NWuCRL96jJ7J9QUx+7EKFYgsfg61m2fiTzb2dv6Yk/Wuw36uZrojka1nnFPG8vlwdTYgYqZJ7LTnvSbwJr+WwiVoaH96/gHacuDzk1MYYxgOfdHfEivTpjzlBLVibMwWb50YD6F5nmronujuPTHLzy7JEgwe3+xBqcOjB/Zk6/msEknn9e7Phaz1dHa8EZX0Olw898z6JnaE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23060414-4bb9-4771-fb72-08d6d15d860c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 13:28:13.3263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TlhQIGkuTVg4UVhQIGlzIGFuIEFSTXY4IFNvQyB3aXRoIGEgQ29ydGV4LU00IGNvcmUgaW5zaWRl
IGFzDQpzeXN0ZW0gY29udHJvbGxlcihTQ1UpLCB0aGUgb2NvdHAgY29udHJvbGxlciBpcyBiZWlu
ZyBjb250cm9sbGVkDQpieSB0aGUgU0NVLCBzbyBMaW51eCBuZWVkIHVzZSBSUEMgdG8gU0NVIGZv
ciBvY290cCBoYW5kbGluZy4gVGhpcw0KcGF0Y2ggYWRkcyBiaW5kaW5nIGRvYyBmb3IgaS5NWDgg
U0NVIE9DT1RQIGRyaXZlci4NCg0KU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQpDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz4NCkNjOiBNYXJrIFJ1
dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPg0KQ2M6IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5k
b25nQG54cC5jb20+DQpDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KQ2M6IFVs
ZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KQ2M6IFN0ZXBoZW4gQm95ZCA8c2Jv
eWRAa2VybmVsLm9yZz4NCkNjOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCkNj
OiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQgfCAxMyArKysrKysrKysrKysr
DQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50
eHQNCmluZGV4IDVkN2RiYWJiYjc4NC4uOWNiN2Q1MmJkZjI2IDEwMDY0NA0KLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCisr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxz
Y3UudHh0DQpAQCAtMTAwLDYgKzEwMCwxMyBAQCBJRCBpbiBpdHMgImNsb2NrcyIgcGhhbmRsZSBj
ZWxsLg0KIFNlZSB0aGUgZnVsbCBsaXN0IG9mIGNsb2NrIElEcyBmcm9tOg0KIGluY2x1ZGUvZHQt
YmluZGluZ3MvY2xvY2svaW14OHF4cC1jbG9jay5oDQogDQorT0NPVFAgYmluZGluZ3MgYmFzZWQg
b24gU0NVIE1lc3NhZ2UgUHJvdG9jb2wNCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCitSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KKy0g
Y29tcGF0aWJsZToJCVNob3VsZCBiZSAiZnNsLGlteDhxeHAtb2NvdHAiDQorLSAjYWRkcmVzcy1j
ZWxsczoJTXVzdCBiZSAxLiBDb250YWlucyBieXRlIGluZGV4DQorLSAjc2l6ZS1jZWxsczoJCU11
c3QgYmUgMS4gQ29udGFpbnMgYnl0ZSBsZW5ndGgNCisNCiBQaW5jdHJsIGJpbmRpbmdzIGJhc2Vk
IG9uIFNDVSBNZXNzYWdlIFByb3RvY29sDQogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogDQpAQCAtMTc3LDYgKzE4NCwxMiBAQCBm
aXJtd2FyZSB7DQogCQkJLi4uDQogCQl9Ow0KIA0KKwkJb2NvdHA6IGlteDhxeC1vY290cCB7DQor
CQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQorCQkJI3NpemUtY2VsbHMgPSA8MT47DQorCQkJY29t
cGF0aWJsZSA9ICJmc2wsaW14OHF4cC1vY290cCI7DQorCQl9Ow0KKw0KIAkJcGQ6IGlteDhxeC1w
ZCB7DQogCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zY3UtcGQiLCAiZnNsLHNjdS1wZCI7
DQogCQkJI3Bvd2VyLWRvbWFpbi1jZWxscyA9IDwxPjsNCi0tIA0KMi4xNi40DQoNCg==
