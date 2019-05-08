Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C43C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F4F20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cP2HXhe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfEHLtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:49:17 -0400
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:42306
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728341AbfEHLtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tfYvloir+yRrmJ7bbXzzhF+As7jjb3W+G5yqlLikRk=;
 b=cP2HXhe/aOo005Ak8pZCKpxEqCVlLB3dljfYlFO8vzKH0KjfXd5y+jmBflQa0PKUDKFyEJG1HnxuKGqVd8RZi2WmBb/k2c4rldTrAtglX3GPEtGH4dfMk+2VeVEg3nAllR5etVcnju+V0F8y00tNvO1VCouG7ppHMQBQdmszsg0=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4945.eurprd04.prod.outlook.com (20.176.215.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Wed, 8 May 2019 11:49:06 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 11:49:06 +0000
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
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH V2 4/4] arm64: dts: imx: add i.MX8QXP ocotp support
Thread-Topic: [PATCH V2 4/4] arm64: dts: imx: add i.MX8QXP ocotp support
Thread-Index: AQHVBUmcX4GOGcsPv0ihTPWps1XlRqZhHPxg
Date:   Wed, 8 May 2019 11:49:06 +0000
Message-ID: <AM0PR04MB4211A76AA2D65894CCB0F39A80320@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190508030927.16668-1-peng.fan@nxp.com>
 <20190508030927.16668-4-peng.fan@nxp.com>
In-Reply-To: <20190508030927.16668-4-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 605cb25b-6a5f-438e-8567-08d6d3ab2cc3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4945;
x-ms-traffictypediagnostic: AM0PR04MB4945:
x-microsoft-antispam-prvs: <AM0PR04MB4945E8A5D780556B4FC275DB80320@AM0PR04MB4945.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:160;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(2906002)(9686003)(6506007)(2501003)(99286004)(305945005)(102836004)(74316002)(7416002)(186003)(26005)(7736002)(6246003)(55016002)(33656002)(4326008)(25786009)(6436002)(6116002)(3846002)(53936002)(66066001)(68736007)(256004)(229853002)(52536014)(2201001)(8676002)(81156014)(81166006)(71190400001)(71200400001)(66446008)(86362001)(316002)(54906003)(14454004)(110136005)(66946007)(66556008)(64756008)(66476007)(76116006)(73956011)(7696005)(478600001)(76176011)(486006)(476003)(5660300002)(11346002)(446003)(4744005)(8936002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4945;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T7GG+qacRiBWo5XQRaZOAKYqknefD0as8osnqaRid6frXZ8L6Wd+z3piKKXGkBVzUo6jPFsPCyNn0Bc1pmsC2QPmkbzDLQ8YoSjfxQv/ObvELwtMIuA8R0GMkpEPZcNceM+oYujD/z7iwPXOma1/pxB3yeDPNJ8o6MbYTtNDpoziU8s4lX0MKSCii0s0Ykbm5vj9pgE7kF5UkufkGaz+zMa9ej43dzfq+8bv7RdQuDjjZ5dI5uZrlstuIu7mKzRZf0F0Ifr/o/2rv7C4zdkVrx1dspsxPDm3IckxfU2XK/HQrqSpQ+SFTMMajfw6+ivHmH7fWeaijf/4+40kIGTCYnpzXbhH+KIxWkPrM8PmXgriTdZ8HdllM8EhZkG5adkShivG95FpJAOlD/hSqCztI6E9lhLW8tU5WXHTVSHnfmc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605cb25b-6a5f-438e-8567-08d6d3ab2cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 11:49:06.2653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSA4LCAyMDE5IDEwOjU2IEFN
DQo+IA0KPiBBZGQgaS5NWDhRWFAgb2NvdHAgbm9kZQ0KPiANCj4gQ2M6IFJvYiBIZXJyaW5nIDxy
b2JoK2R0QGtlcm5lbC5vcmc+DQo+IENjOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0u
Y29tPg0KPiBDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPiBDYzogU2FzY2hh
IEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPg0KPiBDYzogUGVuZ3V0cm9uaXggS2VybmVs
IFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT4NCj4gQ2M6IEZhYmlvIEVzdGV2YW0gPGZlc3Rl
dmFtQGdtYWlsLmNvbT4NCj4gQ2M6IE5YUCBMaW51eCBUZWFtIDxsaW51eC1pbXhAbnhwLmNvbT4N
Cj4gQ2M6IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQo+IENjOiBBbnNvbiBI
dWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IERhbmllbCBCYWx1dGEgPGRhbmllbC5i
YWx1dGFAbnhwLmNvbT4NCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUGVu
ZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFp
c2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg==
