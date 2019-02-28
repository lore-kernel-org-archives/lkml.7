Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D629C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56F1218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N2oBE50y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfB1Byv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:54:51 -0500
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:26304
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730240AbfB1Byu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpFbxY3OvWAjf9Arxz3xZZbJfc8JsNGGV8GC0aaX0uk=;
 b=N2oBE50yntfY8bJM1H4WBLpVRAvxyrK25kLuwT3UqN76+QkW6tfeZFmDdKQMadUbaQz2BvUeMnHkpVxP1FAHCGAz0cm6OsxhI8Dr6hf955mfrQV261tYBmmcxAJ4ryk1QuDMO2tr6AcQll5vPDP0zW2QxnST5l7/fptHhAOfHFA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3674.eurprd04.prod.outlook.com (52.134.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 01:54:41 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 01:54:41 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/3] ARM: dts: imx7ulp: add mmdc support
Thread-Topic: [PATCH V2 2/3] ARM: dts: imx7ulp: add mmdc support
Thread-Index: AQHUzwRDJ7uxcAbsqkmFaMlWuVCzvKX0bOMAgAAGAvA=
Date:   Thu, 28 Feb 2019 01:54:41 +0000
Message-ID: <DB3PR0402MB391672641C4829C18DA0DB36F5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1551316741-7848-1-git-send-email-Anson.Huang@nxp.com>
 <1551316741-7848-2-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5DQM0-rBbWuWa7dZw8es1NbY8DwCGmU4_ZJ2FdFEXYC6Q@mail.gmail.com>
In-Reply-To: <CAOMZO5DQM0-rBbWuWa7dZw8es1NbY8DwCGmU4_ZJ2FdFEXYC6Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4db39f4a-f383-4015-43f4-08d69d1fb43a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3674;
x-ms-traffictypediagnostic: DB3PR0402MB3674:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM2NzQ7MjM6eFZ0M1RVQmpaL2tTZlB2VC9iZGF2aDVO?=
 =?utf-8?B?aldCdWQrdDRCeW9oMTVQYUZxTnRlZ3ZpV29CV081bHBldlZmejIyOW5yTC9j?=
 =?utf-8?B?K1Z0VDdvbkgyVjdWK2ZyVG5QTCtlT2pFcDNqQ3hKNXlJdnh3TEJ3ZWtQeGpG?=
 =?utf-8?B?SWNiSm53V05sMU1qQ1cwOURyNWtoYzJ4dWIyc0JvS1daZzYyNE5HMkZKYVdq?=
 =?utf-8?B?Zk9HcGJzTVhuM3RjK1dvSjNnLzJMb2RreURiaGo4SkRZMFVYYWw4YW1JdzJr?=
 =?utf-8?B?TE9DZ2NRWW5QYkJZNlpYWCtnOVZ3UlBGc3BQcS9UN2tSVjJnejlDWm1UdDFK?=
 =?utf-8?B?RWl3QXkydUxJZUNkbFdKQTNqcTVQTTVYeTYvenJTaFFwWVd5dmJMNWF1Q2NN?=
 =?utf-8?B?SnhmaGZMZVlxaDA0dXpxSVdEazdsVmpjck5nVGpnZ1lpVHpMY2lXbyt6c1Y3?=
 =?utf-8?B?bzV1b201WHIyc2VFb0txdjZvbmdxLzl5WTJCcDZCYlcvSVB2NEVVVDNEVnNZ?=
 =?utf-8?B?dzF1ekI1ai9SK0Q1ZjhTK01OZGFjc3JDVmhuODF1ZitLejRrY0lQZzh2ZTdW?=
 =?utf-8?B?YlZjUTBUMWx2SzJMSGtXZXk5Skt1VTdKUEhhZ29oaFQ1aUVpWTZUSTJFOFJo?=
 =?utf-8?B?SzIwWHlYY2FYVGxhT0N3VkJKbXlBdjc2a0kxSjNnbkh1ZHQ4QkxHN3ZCaDVw?=
 =?utf-8?B?OVYxMHVjMHd6UUlpT0p3WVkwQ09FUXJQazFONThDN0xBc0ZTVFFQOG5hdVFo?=
 =?utf-8?B?QzYxZ3lBUzdkRG55YTY4QlZOSHJJQmd5SVZlazhvaFBpRTlNUUo3WXByRnY4?=
 =?utf-8?B?dFJ3UktQVmdiRnpSdHZ0WXZPOTZDWXhvSGVaRTRNSWg3ZDNxbjlTVkhYb0hi?=
 =?utf-8?B?ZFY5WVZORzNUVFVSS3pxUS9QTlZ6c3ZBMEZIUXgrYm1rTGdEbmV5VXdNbnhz?=
 =?utf-8?B?THpHeWdOL2ZBaElkYnJzRDVyTXo5aFYzdlVZYUU2SWxsMkhlaXhxaXcyd05T?=
 =?utf-8?B?dWNrMlRNRWg4QmZEZFhJUnpvU25mYkJaajlWK1pkdnFYUXNITkNyeTZJQ2Zv?=
 =?utf-8?B?KytUbUU1SUNYVTl3RDZ3R09jdnVpUFZ4Q3htanh3RDVNNGNzdGlGUDhzWVJZ?=
 =?utf-8?B?ZEZtVGxibTA0a0NxMVRsNU81aUNIVlFFczRkLzFMTUJ3TkllekNPVmUraEJX?=
 =?utf-8?B?MWJGNGxya2JLQXpSRlJMRGRVV002cHpzTTZIV1I2Zys3QjFob0lkRjQ0S2VJ?=
 =?utf-8?B?SWhNRW1JczVldFpZQ3l0M2tNazFrVnNnNm1kRU1EdC85bGZabG1zZDJXTHdl?=
 =?utf-8?B?SExVUS9hSlRPRHJMQ0dSUmJEWEVlOTVSdVF4MWdmaytJSHo5RXluVFV3MURG?=
 =?utf-8?B?QXhhNFE1ZitDb0F2dk13N2xmZzlXeS9STktodTA4dHlSK3dDMklWaTRSdzNW?=
 =?utf-8?B?clNUTXU2dFdJM09YbFdPNDlnYjRJNTd2NmdldmUrbk5lT2hlcnF5SngxRC9k?=
 =?utf-8?B?UmNCRXVLWUxUaEhhaXFkSEE0RTRqc1orbzhUWW13WlZGTlZOY1R4cHIyVm90?=
 =?utf-8?B?TFNnU0taV0NHWm4yMWhZSy9JdW9LM0lLT3VEa1NQZ2pybnFnM09NbFNPZFpR?=
 =?utf-8?B?OGtkdkZHS0E5SGJoelBnN1NMWGM3dkhDa2Q1S2NDVThwV3pqN2xTaFAyeWdx?=
 =?utf-8?B?NUFJZDFTQkFxazc3NC9Eb2FhelpnL1RTVVZpUGNVcEI0QUtUamdZQjE3anda?=
 =?utf-8?Q?r8pCAdKOZAGGejpyO58Uzy0xKnLGWmhDqQglsqQ=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3674E1A6142F237E9B15B345F5750@DB3PR0402MB3674.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(39860400002)(136003)(199004)(189003)(13464003)(76176011)(33656002)(6506007)(6116002)(3846002)(71200400001)(71190400001)(6246003)(478600001)(106356001)(105586002)(99286004)(6916009)(14454004)(86362001)(74316002)(1411001)(316002)(4326008)(7696005)(54906003)(25786009)(55016002)(14444005)(9686003)(256004)(229853002)(53936002)(52536013)(6436002)(68736007)(8936002)(446003)(11346002)(8676002)(81156014)(81166006)(66066001)(476003)(5660300002)(44832011)(186003)(305945005)(97736004)(7736002)(26005)(2906002)(102836004)(486006)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3674;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gmRAqY9YY8f9m13Zc+o8OgSQNdarIOwuckfJqIP4QPnsI6eHW+yIjUKSR7S65sc6Xr87o9nsTpP/G1OSbo6djmJX5eM4QAxKuxGFaXlHcW5oedhFlGO7TJGez9GqIDcEVLhJeIHNIKIzcJzGpHZndtu0TZSb2OaGMkpexzsDcszGrhKhbX7bs4qdjHZuH2ZcRrYb9Woxp7wP9XGIqQpYjHn+eeqNcCeh+aKnch2Zm1uGVAjiEncASQfziPJXqEcEWqWkYZUq7K2mvA4Hclj3K7uyfHGcSDCt+RGje9vQxTbkHc5qGPffkXDwIUbdCFIhBxkIhwkIK4RVcU3eYNP1baFIrsybl5ldjzgF87m9u1dJQpZfJ6LKIIWosXPSigDKML6iaKKi1KTE/KUdtbkq8L21QWZfhu5ZPPQY9ryrF3I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db39f4a-f383-4015-43f4-08d69d1fb43a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 01:54:41.2097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRvOmZlc3RldmFtQGdt
YWlsLmNvbV0NCj4gU2VudDogMjAxOeW5tDLmnIgyOOaXpSA5OjMyDQo+IFRvOiBBbnNvbiBIdWFu
ZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5y
dXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi8zXSBBUk06IGR0czogaW14N3VscDogYWRkIG1tZGMgc3Vw
cG9ydA0KPiANCj4gSGkgQW5zb24sDQo+IA0KPiBPbiBXZWQsIEZlYiAyNywgMjAxOSBhdCAxMDoy
MyBQTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4g
PiBpLk1YN1VMUCBoYXMgYSBNTURDIG1vZHVsZSB0byBjb250cm9sIEREUiwgaXQgcmV1c2VzIGku
TVg2USdzIE1NREMNCj4gPiBtb2R1bGUsIGFkZCBzdXBwb3J0IGZvciBpdC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0K
PiA+IENoYW5nZXMgc2luY2UgVjE6DQo+ID4gICAgICAgICAtIHVzZSAibWVtb3J5LWNvbnRyb2xs
ZXIiIGFzIE1NREMgbm9kZSBuYW1lIHRvIG1ha2UgaXQgbW9yZQ0KPiBnZW5lcmljLg0KPiA+IC0t
LQ0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLmR0c2kgfCA2ICsrKysrKw0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvaW14N3VscC5kdHNpDQo+ID4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg3
dWxwLmR0c2kgaW5kZXggZmNhNmU1MC4uNzhmNjExNyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2Fy
bS9ib290L2R0cy9pbXg3dWxwLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg3
dWxwLmR0c2kNCj4gPiBAQCAtMjg2LDYgKzI4NiwxMiBAQA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gICAgICAgICAgICAgICAgIH07DQo+ID4N
Cj4gPiArICAgICAgICAgICAgICAgbW1kYzogbWVtb3J5LWNvbnRyb2xsZXJANDBhYjAwMDAgew0K
PiANCj4gSXQgc2VlbXMgdGhhdCB0aGUgJ21tZGMnIGxhYmVsIGlzIG5vdCBuZWVlZC4NCj4gDQo+
IFlvdSBjb3VsZCBtYWtlIGl0IHNpbXBsZXIgYXM6DQo+IA0KPiBtZW1vcnktY29udHJvbGxlckA0
MGFiMDAwMCB7DQoNCklmIHNvLCBzaG91bGQgSSBjaGFuZ2Ugb3RoZXIgaS5NWDYgU29DcyB3aXRo
IHNpbmdsZSBNTURDIG5vZGUgYXMgd2VsbD8NClJlbW92ZSB0aGVtIGFzIHdlbGw/DQoNCkFuc29u
Lg0K
