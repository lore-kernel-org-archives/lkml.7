Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D25C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 04:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE115218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 04:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wfYbalT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfCUEpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 00:45:04 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:3101
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfCUEpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 00:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1vKFYBMeqBtvPrWsh4JDcSf5XMtCZ3IsWOouJvTttg=;
 b=wfYbalT8TUUdlSaiKjtsoLQmrWnwqSuw2JWm1uxXH8H+Lj7sn6B4S9dvh07FvcSulSDoEshoSg2gfQP3PBUa+CK29YtlPHLcYAkATByDbZGj0WNV3phq6DxUCCAB2d9PqcJFWORzwC2NBHHAt+o11JJDh0St4k4/usr6K3FdzFA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6097.eurprd04.prod.outlook.com (20.179.36.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 04:44:59 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 04:44:59 +0000
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
Subject: RE: [PATCH] arm64: dts: imx8qxp: fix mbox-cells
Thread-Topic: [PATCH] arm64: dts: imx8qxp: fix mbox-cells
Thread-Index: AQHU2X6JXRYV9xh9YkiIRxWD43fsCaYMfvOwgAkPXuA=
Date:   Thu, 21 Mar 2019 04:44:59 +0000
Message-ID: <AM0PR04MB4481E701F964775406CB611888420@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190313093626.18589-1-peng.fan@nxp.com>
 <AM0PR04MB4211910FCC3CEDF11EE4B10380440@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211910FCC3CEDF11EE4B10380440@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 034fb7b4-771b-4bde-bd00-08d6adb7f997
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6097;
x-ms-traffictypediagnostic: AM0PR04MB6097:
x-microsoft-antispam-prvs: <AM0PR04MB6097F0CB134889E0AA503E3288420@AM0PR04MB6097.eurprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(366004)(199004)(13464003)(189003)(5660300002)(110136005)(14454004)(186003)(7416002)(14444005)(8936002)(33656002)(256004)(305945005)(71190400001)(81166006)(81156014)(44832011)(229853002)(316002)(99286004)(74316002)(68736007)(4326008)(446003)(9686003)(71200400001)(25786009)(476003)(486006)(6246003)(11346002)(7696005)(76176011)(478600001)(55016002)(86362001)(2906002)(105586002)(2201001)(106356001)(3846002)(66066001)(26005)(6116002)(102836004)(97736004)(8676002)(2501003)(7736002)(6436002)(6506007)(53546011)(52536014)(53936002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6097;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8oSAr71kKEPBG3klmcxcBoAGE4PU88ATTmvLJYKmAPPO/qkuu+cZCuKvwDcgocjyDtuiWt3j9OOaa3yegGUkFo/e59XMJrpOqfYz16h7lSO3YxoDgGxUBtV+IxBr44PHYPfEdnSDdK9vMgyKWzAvCnIBieCW0E9gJnL/aslP+DR7ZZP6MiX7tZ7a4bG4C5N+h9fGnBD4Y6dOCFT+wWxcN13fuMMkdNsi/DiprznhU2O/aZD2YVZ8lzNn2baAp1yxTV8lBHXK9LnzjMoyqMWKcC9pUnVM56Ud78acl6FSoVj+1/o6mxtnvrVDaM+sntxqINfGb2i1U1J9XotXlz1vafWDlagoMNg1nqATUSuzNj86FfzXQGoudhG0t0fRlLmDXAhv+vkwxxe/kXMKn+FQDzFO7ywfx0+pKkJPdRgC9g4=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034fb7b4-771b-4bde-bd00-08d6adb7f997
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 04:44:59.6504
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
ZWN0OiBSRTogW1BBVENIXSBhcm02NDogZHRzOiBpbXg4cXhwOiBmaXggbWJveC1jZWxscw0KPiAN
Cj4gPiBGcm9tOiBQZW5nIEZhbg0KPiA+DQo+ID4gU3ViamVjdDogW1BBVENIXSBhcm02NDogZHRz
OiBpbXg4cXhwOiBmaXggbWJveC1jZWxscw0KPiA+DQo+ID4gQ3VycmVudGx5IGxzaW9fbXUxIGlz
IHVzZWQgYnkgTGludXggS2VybmVsIHdpdGggbWJveC1jZWxscyBhcyAyLCBidXQgYWN0dWFsbHkN
Cj4gPiBtdTAtNCBjb3VsZCBiZSB1c2VkIHRvIGNvbW11bmljYXRlIHdpdGggU0NVLiBTbyBmaXgg
dGhlIG1ib3gtY2VsbHMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9u
Z0BueHAuY29tPg0KDQpXb3VsZCB5b3UgcGljayB1cCB0aGlzIHBhdGNoPw0KDQpUaGFua3MsDQpQ
ZW5nLg0KDQo+IA0KPiBSZWdhcmRzDQo+IERvbmcgQWlzaGVuZw0KPiANCj4gPiAtLS0NCj4gPiAg
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpIHwgNiArKystLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0
c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+
IGluZGV4IDRjM2RkOTVlZDQ4OC4uMTY3NjY4MzhhYzc3IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+IEBAIC0zMjgsNyArMzI4LDcg
QEANCj4gPiAgCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1tdSIsICJmc2wsaW14NnN4LW11
IjsNCj4gPiAgCQkJcmVnID0gPDB4NWQxYjAwMDAgMHgxMDAwMD47DQo+ID4gIAkJCWludGVycnVw
dHMgPSA8R0lDX1NQSSAxNzYgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gLQkJCSNtYm94LWNl
bGxzID0gPDA+Ow0KPiA+ICsJCQkjbWJveC1jZWxscyA9IDwyPjsNCj4gPiAgCQkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gPiAgCQl9Ow0KPiA+DQo+ID4gQEAgLTM0Myw3ICszNDMsNyBAQA0KPiA+
ICAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLW11IiwgImZzbCxpbXg2c3gtbXUiOw0KPiA+
ICAJCQlyZWcgPSA8MHg1ZDFlMDAwMCAweDEwMDAwPjsNCj4gPiAgCQkJaW50ZXJydXB0cyA9IDxH
SUNfU1BJIDE3OSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiAtCQkJI21ib3gtY2VsbHMgPSA8
MD47DQo+ID4gKwkJCSNtYm94LWNlbGxzID0gPDI+Ow0KPiA+ICAJCQlzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KPiA+ICAJCX07DQo+ID4NCj4gPiBAQCAtMzUxLDcgKzM1MSw3IEBADQo+ID4gIAkJCWNv
bXBhdGlibGUgPSAiZnNsLGlteDhxeHAtbXUiLCAiZnNsLGlteDZzeC1tdSI7DQo+ID4gIAkJCXJl
ZyA9IDwweDVkMWYwMDAwIDB4MTAwMDA+Ow0KPiA+ICAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkg
MTgwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+IC0JCQkjbWJveC1jZWxscyA9IDwwPjsNCj4g
PiArCQkJI21ib3gtY2VsbHMgPSA8Mj47DQo+ID4gIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+
ID4gIAkJfTsNCj4gPg0KPiA+IC0tDQo+ID4gMi4xNi40DQoNCg==
