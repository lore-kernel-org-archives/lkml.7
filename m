Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F50C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD0621479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QMbPlLtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfEHIzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:55:10 -0400
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:60150
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbfEHIzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHb5LJv20Q5O9jdPtsC9fwKknptDkDztqI238O1UoP8=;
 b=QMbPlLttgabSxTINnzgwwjywd67Tpw1STZKX1DPozczORGzpTa16ecaO66sZ/44f2CaBDG1u4a6Xmn7efM7kV7eedDanRiyce/uGO1lN6GiAjjuSSd+ZXbGdtjVr09YAEVFy29OgS3OfVTdc13AsoK4OOGhwfqwNaw5vNUSjEJI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4625.eurprd04.prod.outlook.com (52.135.147.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Wed, 8 May 2019 08:55:05 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 08:55:05 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH V2 1/4] dt-bindings: fsl: scu: add ocotp binding
Thread-Topic: [PATCH V2 1/4] dt-bindings: fsl: scu: add ocotp binding
Thread-Index: AQHVBUmS8YEY+TS9pUGxn5n6MqiHxaZg7LWw
Date:   Wed, 8 May 2019 08:55:05 +0000
Message-ID: <AM0PR04MB42115A523D5CD5FFF8144F0C80320@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190508030927.16668-1-peng.fan@nxp.com>
In-Reply-To: <20190508030927.16668-1-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f688312-cff9-4489-eac7-08d6d392dda0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4625;
x-ms-traffictypediagnostic: AM0PR04MB4625:
x-microsoft-antispam-prvs: <AM0PR04MB4625C4D6444B28B223A297EF80320@AM0PR04MB4625.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(8936002)(71190400001)(71200400001)(66066001)(44832011)(4744005)(102836004)(68736007)(446003)(11346002)(8676002)(486006)(81166006)(81156014)(476003)(2201001)(66476007)(26005)(76116006)(55016002)(229853002)(52536014)(73956011)(66446008)(66946007)(64756008)(66556008)(6436002)(7416002)(256004)(316002)(54906003)(53936002)(9686003)(2501003)(7736002)(86362001)(74316002)(6246003)(4326008)(33656002)(25786009)(305945005)(3846002)(99286004)(5660300002)(6506007)(478600001)(76176011)(6116002)(2906002)(110136005)(186003)(7696005)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4625;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8Evv7MNWjQaonCyYrzEwHAUNn+Unl+5TsajMFsvkfwvu7Z29MDwzfU4oqqeCcSamjPsXUiw6QMQO2jfBllwulLtuzoTyMWePueOqf8D8ua/YuViDf7xVBsnbL3VPYmejZagbGYlxhmtI7ydMadSH++nrFjXdz8IiNxUNTf3Bca0e61OzyGt+bY9VVhAv40s3xYVOP7mp9EEuROinq6HFWVeKMhFfF3G6Ie0wiwShJmWOREeQ/aD9QGKuFJoWVH5wsV6EOBxYYQRhrDfIsBWeshztvt0b5hD0GudlhsxGP5dEKaFbJWaUX233Q1ZEJ4+qumOAzFEjk2Pr9ZFTpveG6pME1lx/cDTuW2RFrWTz/gktjC1e9vmkIBQ2/UciPAFK6Q5+2/RvHtDWKZk+22CsNVfnIjHvaGekrdhk17yvePU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f688312-cff9-4489-eac7-08d6d392dda0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 08:55:05.5201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSA4LCAyMDE5IDEwOjU2IEFN
DQo+IA0KPiBOWFAgaS5NWDhRWFAgaXMgYW4gQVJNdjggU29DIHdpdGggYSBDb3J0ZXgtTTQgY29y
ZSBpbnNpZGUgYXMgc3lzdGVtDQo+IGNvbnRyb2xsZXIoU0NVKSwgdGhlIG9jb3RwIGNvbnRyb2xs
ZXIgaXMgYmVpbmcgY29udHJvbGxlZCBieSB0aGUgU0NVLCBzbyBMaW51eA0KPiBuZWVkIHVzZSBS
UEMgdG8gU0NVIGZvciBvY290cCBoYW5kbGluZy4gVGhpcyBwYXRjaCBhZGRzIGJpbmRpbmcgZG9j
IGZvciBpLk1YOA0KPiBTQ1UgT0NPVFAgZHJpdmVyLg0KPiANCj4gQ2M6IFJvYiBIZXJyaW5nIDxy
b2JoK2R0QGtlcm5lbC5vcmc+DQo+IENjOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0u
Y29tPg0KPiBDYzogQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gQ2M6IFNo
YXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gQ2M6IFVsZiBIYW5zc29uIDx1bGYuaGFu
c3NvbkBsaW5hcm8ub3JnPg0KPiBDYzogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0K
PiBDYzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5Abnhw
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+
DQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0K
