Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B710C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94D321019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GkQVp7kX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfEHC4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:56:07 -0400
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:57782
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfEHC4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2E1vSgiDUnsKxaunmF3/XtI9jYTGlfqdgySbAe8FCA=;
 b=GkQVp7kXFykkaanx2AbLheH7HD7x3m9KfkX4FopdQH9U4vLk8rPCQR2lqbQ1mW9FCBjR1el66GMSPljnp1mmM/6U2H2qOERz6ziXsvpwPhTuQOgWO/atfJeljuptx3xEIwJksapLwuChGvGnIW4uT5FdJqoUOAhLnGpp4F1mL1w=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5153.eurprd04.prod.outlook.com (20.177.40.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Wed, 8 May 2019 02:56:02 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 02:56:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
        Aisheng Dong <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V2 1/4] dt-bindings: fsl: scu: add ocotp binding
Thread-Topic: [PATCH V2 1/4] dt-bindings: fsl: scu: add ocotp binding
Thread-Index: AQHVBUmS8YEY+TS9pUGxn5n6MqiHxQ==
Date:   Wed, 8 May 2019 02:56:02 +0000
Message-ID: <20190508030927.16668-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0P153CA0028.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a96015b6-f15e-4da2-65f1-08d6d360b4d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5153;
x-ms-traffictypediagnostic: AM0PR04MB5153:
x-microsoft-antispam-prvs: <AM0PR04MB5153C8A635FF5AF175ED3A1588320@AM0PR04MB5153.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(199004)(26005)(1076003)(68736007)(66446008)(14454004)(2501003)(66946007)(186003)(52116002)(305945005)(102836004)(7736002)(316002)(66556008)(64756008)(66476007)(53936002)(73956011)(25786009)(7416002)(50226002)(8936002)(5660300002)(4326008)(71190400001)(71200400001)(6512007)(478600001)(54906003)(110136005)(6116002)(3846002)(2906002)(36756003)(81156014)(81166006)(8676002)(86362001)(2201001)(66066001)(6436002)(6486002)(2616005)(256004)(6506007)(486006)(44832011)(386003)(99286004)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5153;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I2ZBmrJh6WgINPX3iYI1h5/SvECPoppiB0UvFgB2/z+dLF8AhaB2i0Rbo5X1Ya4JE8u9juytjzy9u6r5UKsCqIjWaBMk6qJ5dP9jRERieFHPtUaiJoLGOwaD1AHUdbAC36rKzOa4+/WsO+hKV/X8RN1+sgWn367NmsLi7TOlq6/T+FhwkYfQ3xVuKn5HTIFGlKylWNZsXTRmvwNdRUaykEarGUHDAAW1Cb8dgXzT63WvnslQmqxI98uDZ0c0sHLqYNzy5ZQxyj31H11dFLuahRO5PxmEwx0paO6EJlpVYBnSHyj2Ci1snNxopD5APCxpysgBSYh6TeynC8ytD3mKX/Lw4Fu13i6QZLtDU9lBYvf9bh/YfEl8eDv5Tf0BabPEPfXgtWBoz9wBzi8nKbVR1JyUIraLP2VzKbY/lR0xsxo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96015b6-f15e-4da2-65f1-08d6d360b4d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 02:56:02.7586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TlhQIGkuTVg4UVhQIGlzIGFuIEFSTXY4IFNvQyB3aXRoIGEgQ29ydGV4LU00IGNvcmUgaW5zaWRl
IGFzDQpzeXN0ZW0gY29udHJvbGxlcihTQ1UpLCB0aGUgb2NvdHAgY29udHJvbGxlciBpcyBiZWlu
ZyBjb250cm9sbGVkDQpieSB0aGUgU0NVLCBzbyBMaW51eCBuZWVkIHVzZSBSUEMgdG8gU0NVIGZv
ciBvY290cCBoYW5kbGluZy4gVGhpcw0KcGF0Y2ggYWRkcyBiaW5kaW5nIGRvYyBmb3IgaS5NWDgg
U0NVIE9DT1RQIGRyaXZlci4NCg0KQ2M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+
DQpDYzogTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4NCkNjOiBBaXNoZW5nIERv
bmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVs
Lm9yZz4NCkNjOiBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCkNjOiBTdGVw
aGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQpDYzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5n
QG54cC5jb20+DQpDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNClNpZ25lZC1vZmYtYnk6
IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KLS0tDQoNClYyOg0KIE1vdmUgT0NPVFAgdG8g
ZW5kLCBhZGQgZXhhbXBsZSwgYWRkICJzY3UiDQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0ICB8IDIyICsrKysrKysrKysrKysrKysrKysrKysNCiAx
IGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0K
aW5kZXggNWQ3ZGJhYmJiNzg0Li5mMzc4OTIyOTA2ZjYgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50
eHQNCkBAIC0xMzMsNiArMTMzLDE4IEBAIFJUQyBiaW5kaW5ncyBiYXNlZCBvbiBTQ1UgTWVzc2Fn
ZSBQcm90b2NvbA0KIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogLSBjb21wYXRpYmxlOiBzaG91bGQg
YmUgImZzbCxpbXg4cXhwLXNjLXJ0YyI7DQogDQorT0NPVFAgYmluZGluZ3MgYmFzZWQgb24gU0NV
IE1lc3NhZ2UgUHJvdG9jb2wNCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCitSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KKy0gY29tcGF0
aWJsZToJCVNob3VsZCBiZSAiZnNsLGlteDhxeHAtc2N1LW9jb3RwIg0KKy0gI2FkZHJlc3MtY2Vs
bHM6CU11c3QgYmUgMS4gQ29udGFpbnMgYnl0ZSBpbmRleA0KKy0gI3NpemUtY2VsbHM6CQlNdXN0
IGJlIDEuIENvbnRhaW5zIGJ5dGUgbGVuZ3RoDQorDQorT3B0aW9uYWwgQ2hpbGQgbm9kZXM6DQor
DQorLSBEYXRhIGNlbGxzIG9mIG9jb3RwOg0KKyAgRGV0YWlsZWQgYmluZGluZ3MgYXJlIGRlc2Ny
aWJlZCBpbiBiaW5kaW5ncy9udm1lbS9udm1lbS50eHQNCisNCiBFeGFtcGxlIChpbXg4cXhwKToN
CiAtLS0tLS0tLS0tLS0tDQogYWxpYXNlcyB7DQpAQCAtMTc3LDYgKzE4OSwxNiBAQCBmaXJtd2Fy
ZSB7DQogCQkJLi4uDQogCQl9Ow0KIA0KKwkJb2NvdHA6IGlteDhxeC1vY290cCB7DQorCQkJY29t
cGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zY3Utb2NvdHAiOw0KKwkJCSNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KKwkJCSNzaXplLWNlbGxzID0gPDE+Ow0KKw0KKwkJCWZlY19tYWMwOiBtYWNAMmM0IHsN
CisJCQkJcmVnID0gPDB4MmM0IDg+Ow0KKwkJCX07DQorCQl9Ow0KKw0KIAkJcGQ6IGlteDhxeC1w
ZCB7DQogCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zY3UtcGQiLCAiZnNsLHNjdS1wZCI7
DQogCQkJI3Bvd2VyLWRvbWFpbi1jZWxscyA9IDwxPjsNCi0tIA0KMi4xNi40DQoNCg==
