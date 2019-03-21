Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1116EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 04:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A22218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 04:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="skk0hlYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfCUEpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 00:45:43 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:59446
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725950AbfCUEpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 00:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ll0U3tgB4Zkl2eaGbR3PMfA6NimaGBuU52Bxu797TU=;
 b=skk0hlYLfj0PyqvZNKqmg+qgw75OGC30VOX4TmrFOlawUTgmDoWZ228psGfLPeYFNfXsdzQsX81xtK7wv2iLx2CJGzFubexc8NAZ0qWUSIj+qIY5a91wzDWkp4tYRd3TZWHT9pe9yTenluZls/ywuyxbv9P0CNmEJq98H444Ng0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6097.eurprd04.prod.outlook.com (20.179.36.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 04:45:38 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 04:45:38 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH] arm64: dts: imx8qxp: add lsio_mu2 node
Thread-Topic: [PATCH] arm64: dts: imx8qxp: add lsio_mu2 node
Thread-Index: AQHU2X6XfkrN9ckA80iUx9YseK0a4qYMf0+wgAkPbDA=
Date:   Thu, 21 Mar 2019 04:45:38 +0000
Message-ID: <AM0PR04MB44818E7C4A5128BD7993219A88420@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190313093650.18693-1-peng.fan@nxp.com>
 <AM0PR04MB4211FEB4C272759B84BCB6A180440@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211FEB4C272759B84BCB6A180440@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa7fc56f-fcaa-42eb-f448-08d6adb810f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6097;
x-ms-traffictypediagnostic: AM0PR04MB6097:
x-microsoft-antispam-prvs: <AM0PR04MB609726CB711F70BE4EB9FB9688420@AM0PR04MB6097.eurprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(366004)(199004)(13464003)(189003)(5660300002)(110136005)(14454004)(186003)(7416002)(14444005)(8936002)(33656002)(256004)(305945005)(71190400001)(81166006)(81156014)(44832011)(229853002)(316002)(99286004)(74316002)(68736007)(4326008)(446003)(9686003)(71200400001)(25786009)(476003)(486006)(6246003)(11346002)(7696005)(76176011)(478600001)(55016002)(86362001)(2906002)(105586002)(2201001)(106356001)(3846002)(66066001)(26005)(6116002)(102836004)(97736004)(8676002)(2501003)(7736002)(6436002)(6506007)(53546011)(52536014)(53936002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6097;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5k/eTpUa9XIK86IDgReEp1q+WJJuLgr52Waqj5dKo6vyIDKqGSz9cn8QNdhtYGhilxvQGGUDMZl/3qI7HnaYjJr3lVSpfON9KsAFHL+uTFCmv3o4yBEw9Mde22YFI4SU1325tp+9Ro9mEB9GodmbbTncl67iRVyKQdMinX5/rVyw/mpDMdc/GOdumMgZytuUCFECMGDE5Qd1gd5zpb3ueufwuw7zV/JzIPIlDQ+TFrvDsti7ONfIec+phYfNKIH4m+PX5S6U8z+AqUVW0DW2PWKG/Q4NrKbzWQXjI+4iOzmypqtjEI2glDvX9soIoK7fhhw2C5CXdQ1xpR6FbNFj2/tl2OQLcV211aI0EH8bDJEGWi2YKeit42niA8aE9jeVuLnmxIg5eD60kiUWnw07PMhfylQ/uuetLHcwDHfsx1I=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7fc56f-fcaa-42eb-f448-08d6adb810f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 04:45:38.8627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWlzaGVu
ZyBEb25nDQo+IFNlbnQ6IDIwMTnE6jPUwjE1yNUgMTg6MjQNCj4gVG86IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNv
bTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteA0KPiA8bGlu
dXgtaW14QG54cC5jb20+OyBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IERhbmll
bCBCYWx1dGENCj4gPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHZhbi5mcmVlbml4QGdtYWlsLmNvbQ0KPiBTdWJq
ZWN0OiBSRTogW1BBVENIXSBhcm02NDogZHRzOiBpbXg4cXhwOiBhZGQgbHNpb19tdTIgbm9kZQ0K
PiANCj4gPiBGcm9tOiBQZW5nIEZhbg0KPiA+DQo+ID4gQWRkIGxzaW9fbXUyIG5vZGUgd2hpY2gg
Y291bGQgYmUgdXNlZCBjb21tdW5pY2F0ZSB3aXRoIFNDVS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IERvbmcg
QWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNCldvdWxkIHlvdSBwaWNrIHVwIHRoaXMg
cGF0Y2g/DQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IFJlZ2FyZHMNCj4gRG9uZyBBaXNoZW5n
DQo+IA0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhw
LmR0c2kgfCA4ICsrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
cXhwLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRz
aQ0KPiA+IGluZGV4IDE2NzY2ODM4YWM3Ny4uNjRlZWNkNmNiMWU5IDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+ICsrKyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+IEBAIC0zMzksNiAr
MzM5LDE0IEBADQo+ID4gIAkJCSNtYm94LWNlbGxzID0gPDI+Ow0KPiA+ICAJCX07DQo+ID4NCj4g
PiArCQlsc2lvX211MjogbWFpbGJveEA1ZDFkMDAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAi
ZnNsLGlteDhxeHAtbXUiLCAiZnNsLGlteDZzeC1tdSI7DQo+ID4gKwkJCXJlZyA9IDwweDVkMWQw
MDAwIDB4MTAwMDA+Ow0KPiA+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTc4IElSUV9UWVBF
X0xFVkVMX0hJR0g+Ow0KPiA+ICsJCQkjbWJveC1jZWxscyA9IDwyPjsNCj4gPiArCQkJc3RhdHVz
ID0gImRpc2FibGVkIjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4gPiAgCQlsc2lvX211MzogbWFpbGJv
eEA1ZDFlMDAwMCB7DQo+ID4gIAkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtbXUiLCAiZnNs
LGlteDZzeC1tdSI7DQo+ID4gIAkJCXJlZyA9IDwweDVkMWUwMDAwIDB4MTAwMDA+Ow0KPiA+IC0t
DQo+ID4gMi4xNi40DQoNCg==
