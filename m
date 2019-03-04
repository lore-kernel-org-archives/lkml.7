Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D3FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F5621019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OE1cm5tK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfCDGsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:48:18 -0500
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:35654
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfCDGsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 01:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEhsPdXhQKPIfZF+CYpfg/+glIda4/klR3AwSBNSFhE=;
 b=OE1cm5tKDSI2PyADfn1fkBrYZXBJER5EnfhmdDeyuXHp9XGnBIn92MN6FXHa0g1vI2m17Px+wcFEat1hGOvbOOdMPxy8Gw4ldkvrj7IAJPn/1PEtCOmDIkTp3O8ms+I21aIrjkKXfh/kQVRf03oWbsvfqpnhZ3LzLLDj/pgIju0=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB4622.eurprd04.prod.outlook.com (20.177.56.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 06:46:33 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::c9ed:484:795a:6f4f]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::c9ed:484:795a:6f4f%4]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 06:46:32 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
Subject: RE: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
Thread-Topic: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
Thread-Index: AQHU0jo9yDvlWMWO2EezapwWi7PmgaX7AH0AgAAEh0A=
Date:   Mon, 4 Mar 2019 06:46:32 +0000
Message-ID: <VI1PR04MB433386B86A5E6AA804E9C3B5F3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190304032111.21770-1-andy.tang@nxp.com>
 <20190304062115.GB26041@dragon>
In-Reply-To: <20190304062115.GB26041@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 055bb31d-b291-415b-58e6-08d6a06d23a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4622;
x-ms-traffictypediagnostic: VI1PR04MB4622:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtWSTFQUjA0TUI0NjIyOzIzOlc5MGJOQmJyaUN2WmtaSG0vNnFXUTIxbUJF?=
 =?gb2312?B?MUZ6RDBpdWdFcjlHdWhzajlIQ0xhS2FHQmR3emNtZitLK1JoUldyaWhKeVF2?=
 =?gb2312?B?Tmh5a0MyQlBNWWxsWG1Vb3Jhc2h2d3hadkl5dXNNRDRYbGNjRzZxcC95NXBw?=
 =?gb2312?B?YStYMERVM3hCL0hoNlQyQUlHYWNGWm1QYm9iSFdndjFjOWhGVW85NkF0NFI3?=
 =?gb2312?B?YTNFeFhGUkdYNmF4ZmtSQTdQQUZNTFZ6VlAxWGJkcUdMRHh1R2ZuSWIwNUxM?=
 =?gb2312?B?Sm5lTE1MSzJwUm1Mc1loN3ZMakNGbm9tdGNpWkpsTXBNRDdXZ0pJcjlyUE5j?=
 =?gb2312?B?cGFmOE5leDJkSXJwYUcyM1hCeURoYmdaZmUxZEJtNk1WaDEzaWFES3ZHbC9l?=
 =?gb2312?B?Zzk4QnBRUTRsVXk1TDk2Ty91b1BZa2ZZcjgvUXUvdXE1NVpPOTdSRFhDMlFz?=
 =?gb2312?B?cmVLZC9PSmFZT0ZLY3dvS0ZGamhVUDRKTDQvamhvb24yVEFTQjdYeGdWQkxZ?=
 =?gb2312?B?dFF3Q2lZY2RLeDVnVWJYdDAxekJhREpyN09RVGgvQ2hMbC9SSzdmclh6bTNs?=
 =?gb2312?B?MTN6K0FoclJPazllaENydFFMR1hPR1o2QktoNFdSbHRsVjh4YW1KZ01maEFF?=
 =?gb2312?B?RGtINWRmZG9KQjVONDE3SUxqTCtNb1RpK0Q3WFA1Q1VHdExXZkdsbWtUbk43?=
 =?gb2312?B?bnF5N0VsamFMZWdsMnYwMUlhT2JCbDRzV1BPcXN6aXpzdTBJSWdBVHZ3U1Aw?=
 =?gb2312?B?MlNUQkh4MmJwNTdBK3o3MlJ3bWE5bEJmYWFYVXBreG85MkhjRFZwRENNS1Qv?=
 =?gb2312?B?ZUJiMG1CV1Uvd1dCTFZNQTFadExlNEJsbjVPWWswVmZYNUFsMGUyNW5PVzhW?=
 =?gb2312?B?MkhnR2laT2FEeDVtc1psVDZxbkVubUI2am94cEdMY3lQMW8wS3p0ZWd5YXZz?=
 =?gb2312?B?Tm9nYkd5eDFrTlU2YTdaMWE3SlBGSTVINHpxZWtGRGxERkxQMDVPWjBqYlQ5?=
 =?gb2312?B?ZnBtWWtOVkZIS0l2V0JZNk45VnJMbDNOa0Fid1BhdEZUYVRrYVY3bENsb3RE?=
 =?gb2312?B?VHpCR2pWbExTZjZWZnpsZnBOcjFidld1SXF2MmlCckc1c2E0MnIzSlR4aWJT?=
 =?gb2312?B?UGlVWHIzU1MraEFNb1FvTzM1NVYwZllqVGlFV0Q1dkF4YWhwYkhwTGYrTkJy?=
 =?gb2312?B?NmVkaEViK1hrdDlzbHg2VFVpVUp1MUQ5czh6Rk80bDUrWGVGK0dqMnhCelBG?=
 =?gb2312?B?cFVnVnN5bG1pOTdNVm92K2diS3RyY3ltdWhsa1h1RkNURU90QnF5T0RyaDFL?=
 =?gb2312?B?clh5Z1B3OVNUanNVTisvM0w2M2hNVS9tcTRndWExeHp2VUVRRDNmVERDWjdF?=
 =?gb2312?B?ckNSb2FYUHpRc0NuamhacXZPZVRGZW1meHMrK01qVXRkQTNlbVRvOURBZGhE?=
 =?gb2312?B?Y2xlMnhqSVFxbzRKWUZhb3lFSnJ5SzlKZDg1NUtuNzBiK0hBQ2pvVGIzbGx6?=
 =?gb2312?B?cW1XQVh3dGlLelhlOXJONUVYa0x3Q0FjR01ZQ3U3Z3N3S2xhZmR3OU4vbDBD?=
 =?gb2312?B?d2o1WGgwY3VDOXQ5T3dCa3NaV3YwWDFkRDQ2V1AwcFBDNm84Z0ZNVS9uUnYy?=
 =?gb2312?B?c2RKbC9PcTJhOEhIUzJQbk1IcTcxaTZYWENqR3lLTnR5NUhFY1greTY1dmQw?=
 =?gb2312?B?ZGdrckpyNUtmbHpyL2M1STQrSnhpdEN0cm4zenFNUUI3NS82RjFmclRXVUhi?=
 =?gb2312?Q?QI40Z2CI2MR47XAfCALxZIDdZrKu+qNJbtuFM=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB4622716E56605126947CD8AFF3710@VI1PR04MB4622.eurprd04.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(136003)(13464003)(199004)(189003)(6246003)(256004)(14444005)(71200400001)(71190400001)(55016002)(6436002)(7696005)(9686003)(44832011)(186003)(478600001)(7416002)(4326008)(2906002)(14454004)(52536013)(229853002)(5660300002)(316002)(446003)(8936002)(53546011)(11346002)(33656002)(305945005)(74316002)(97736004)(476003)(86362001)(486006)(76176011)(6116002)(3846002)(81156014)(106356001)(102836004)(54906003)(66066001)(7736002)(68736007)(26005)(6506007)(53936002)(25786009)(105586002)(81166006)(6916009)(99286004)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4622;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iQIxYFSfirIm/11q+5E5cyZI5GaWhUDuhc4zc8y6k8QCFMPSXSsMk/eO9end714NyGLTut+ZbuzB5Ka4A33mSjwIcCAZyOekJbw13GPW/oHduP1ZfmWdisIla30gqD0lscYh4+W+2FbfogAsfdorpdqkNW4H91VmX5/IQto7+QDUriqGM4/U3WXyCDSrV1X214xqFkRMhXq1qALu8aNl2KGVE33uN19iqwrfYnxbrwADQjJwGOpE3YXyngDHyNAjokDJSCH2vV4UbTZiuneIiN2gpOE2+x0ZzuWtjVAxkNuyVRNAtwky5tGGK9Uz6FEVEruXr0MbKDz/e/LE3rrOGBqtBHkwB+j1wdfdwBOARKr6emAo4ubAodqKEYKO1B+L7+5CNY0R7/AI8XNYLTwZx37x7fDKrHDS6gspZRh2B7s=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055bb31d-b291-415b-58e6-08d6a06d23a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 06:46:32.7977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24gR3VvIDxzaGF3
bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE5xOoz1MI0yNUgMTQ6MjENCj4gVG86IEFuZHkg
VGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IENjOiBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNv
bT47IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9y
ZzsNCj4gZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgcnVpLnpoYW5nQGludGVsLmNvbTsgZWR1
YmV6dmFsQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBhcm02NDogZHRzOiBs
czEwODhhOiBhZGQgb25lIG1vcmUgdGhlcm1hbCB6b25lIG5vZGUNCj4gDQo+IE9uIE1vbiwgTWFy
IDA0LCAyMDE5IGF0IDExOjIxOjExQU0gKzA4MDAsIFl1YW50aWFuIFRhbmcgd3JvdGU6DQo+ID4g
THMxMDg4YSBoYXMgMiB0aGVybWFsIHNlbnNvcnMsIGNvcmUgY2x1c3RlciBhbmQgU29DIHBsYXRm
b3JtLiBDb3JlDQo+ID4gY2x1c3RlciBzZW5zb3IgaXMgdXNlZCB0byBtb25pdG9yIHRoZSB0ZW1w
ZXJhdHVyZSBvZiBjb3JlIGFuZCBTb0MNCj4gPiBwbGF0Zm9ybSBpcyBmb3IgcGxhdGZvcm0uIFRo
ZSBjdXJyZW50IGR0cyBvbmx5IHN1cHBvcnQgdGhlIGZpcnN0IHNlbnNvci4NCj4gPiBUaGlzIHBh
dGNoIGFkZHMgdGhlIHNlY29uZCBzZW5zb3Igbm9kZSB0byBkdHMgdG8gZW5hYmxlIGl0Lg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogWXVhbnRpYW4gVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gdjI6DQo+ID4gCS0gQWRkIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgc2Vuc29y
cyB0byBkZXNjcmlwdGlvbg0KPiA+IFBTOiBJbiBvcmRlciB0byBrZWVwIGNvbnNpc3RlbmN5IHRv
IHRoZSBmaXJzdCB0aGVybWFsLXpvbmUgbm9kZSwgdGhlcmUNCj4gPiB3aWxsIGJlICJXQVJOSU5H
OiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycyIgd2FybmluZ3MuDQo+ID4NCj4gPiAgYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA4OGEuZHRzaSB8ICAgNDMNCj4gKysrKysrKysr
KysrKysrKysrKysrLS0NCj4gPiAgMSBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2ZzbC1sczEwODhhLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1sczEwODhhLmR0c2kNCj4gPiBpbmRleCA2NjExMzdmLi45ZjUyYmM5IDEwMDY0
NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwODhhLmR0
c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDg4YS5k
dHNpDQo+ID4gQEAgLTEyOSwxOSArMTI5LDE5IEBADQo+ID4gIAl9Ow0KPiA+DQo+ID4gIAl0aGVy
bWFsLXpvbmVzIHsNCj4gPiAtCQljcHVfdGhlcm1hbDogY3B1LXRoZXJtYWwgew0KPiA+ICsJCWNj
dSB7DQo+IA0KPiBJcyB0aGlzIGNoYW5nZSByZWFsbHkgbmVjZXNzYXJ5PyAgV2hhdCBkb2VzICdj
Y3UnIHN0YW5kIGZvcj8NCkkgdGhpbmsgc28uIGNjdSBzdGFuZHMgZm9yIGNvcmUgY2x1c3RlciB1
bml0LiBjcHUgaXMgdG9vIGdlbmVyYWwuDQpPbiBzb21lIHBsYXRmb3JtcywgdGhlcmUgYXJlIG1v
cmUgdGhhbiBvbmUgY29yZSBjbHVzdGVycy4NCkF0IGxlYXN0IHdlIHNob3VsZCBjaGFuZ2UgaXQg
dG8gImNvcmUgY2x1c3RlciIgaWYgc2hvcnQgZm9ybSBpcyBub3QgYXBwcm9wcmlhdGUuDQoNCj4g
DQo+ID4gIAkJCXBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwxMDAwPjsNCj4gPiAgCQkJcG9sbGlu
Zy1kZWxheSA9IDw1MDAwPjsNCj4gPiAgCQkJdGhlcm1hbC1zZW5zb3JzID0gPCZ0bXUgMD47DQo+
ID4NCj4gPiAgCQkJdHJpcHMgew0KPiA+IC0JCQkJY3B1X2FsZXJ0OiBjcHUtYWxlcnQgew0KPiA+
ICsJCQkJY2N1X2FsZXJ0OiBjY3UtYWxlcnQgew0KPiA+ICAJCQkJCXRlbXBlcmF0dXJlID0gPDg1
MDAwPjsNCj4gPiAgCQkJCQloeXN0ZXJlc2lzID0gPDIwMDA+Ow0KPiA+ICAJCQkJCXR5cGUgPSAi
cGFzc2l2ZSI7DQo+ID4gIAkJCQl9Ow0KPiA+DQo+ID4gLQkJCQljcHVfY3JpdDogY3B1LWNyaXQg
ew0KPiA+ICsJCQkJY2N1X2NyaXQ6IGNjdS1jcml0IHsNCj4gPiAgCQkJCQl0ZW1wZXJhdHVyZSA9
IDw5NTAwMD47DQo+ID4gIAkJCQkJaHlzdGVyZXNpcyA9IDwyMDAwPjsNCj4gPiAgCQkJCQl0eXBl
ID0gImNyaXRpY2FsIjsNCj4gPiBAQCAtMTUwLDcgKzE1MCw0MiBAQA0KPiA+DQo+ID4gIAkJCWNv
b2xpbmctbWFwcyB7DQo+ID4gIAkJCQltYXAwIHsNCj4gPiAtCQkJCQl0cmlwID0gPCZjcHVfYWxl
cnQ+Ow0KPiA+ICsJCQkJCXRyaXAgPSA8JmNjdV9hbGVydD47DQo+ID4gKwkJCQkJY29vbGluZy1k
ZXZpY2UgPQ0KPiA+ICsJCQkJCQk8JmNwdTAgVEhFUk1BTF9OT19MSU1JVA0KPiBUSEVSTUFMX05P
X0xJTUlUPiwNCj4gPiArCQkJCQkJPCZjcHUxIFRIRVJNQUxfTk9fTElNSVQNCj4gVEhFUk1BTF9O
T19MSU1JVD4sDQo+ID4gKwkJCQkJCTwmY3B1MiBUSEVSTUFMX05PX0xJTUlUDQo+IFRIRVJNQUxf
Tk9fTElNSVQ+LA0KPiA+ICsJCQkJCQk8JmNwdTMgVEhFUk1BTF9OT19MSU1JVA0KPiBUSEVSTUFM
X05PX0xJTUlUPiwNCj4gPiArCQkJCQkJPCZjcHU0IFRIRVJNQUxfTk9fTElNSVQNCj4gVEhFUk1B
TF9OT19MSU1JVD4sDQo+ID4gKwkJCQkJCTwmY3B1NSBUSEVSTUFMX05PX0xJTUlUDQo+IFRIRVJN
QUxfTk9fTElNSVQ+LA0KPiA+ICsJCQkJCQk8JmNwdTYgVEhFUk1BTF9OT19MSU1JVA0KPiBUSEVS
TUFMX05PX0xJTUlUPiwNCj4gPiArCQkJCQkJPCZjcHU3IFRIRVJNQUxfTk9fTElNSVQNCj4gVEhF
Uk1BTF9OT19MSU1JVD47DQo+ID4gKwkJCQl9Ow0KPiA+ICsJCQl9Ow0KPiA+ICsJCX07DQo+ID4g
Kw0KPiA+ICsJCXBsdCB7DQo+IA0KPiBXaGF0IGFib3V0ICdwbGF0Zm9ybS10aGVybWFsJyBmb3Ig
bm9kZSBuYW1lLCBwbGF0Zm9ybS1hbGVydCBhbmQgcGxhdGZvcm0tY3JpdA0KPiBmb3IgdHJpcCBu
b2RlcyBiZWxvdz8NCk9LLCB3aWxsIHVzZSBsb25nIG5hbWUgZm9ybS4NCg0KQlIsDQpBbmR5DQo+
IA0KPiBTaGF3bg0KPiANCj4gPiArCQkJcG9sbGluZy1kZWxheS1wYXNzaXZlID0gPDEwMDA+Ow0K
PiA+ICsJCQlwb2xsaW5nLWRlbGF5ID0gPDUwMDA+Ow0KPiA+ICsJCQl0aGVybWFsLXNlbnNvcnMg
PSA8JnRtdSAxPjsNCj4gPiArDQo+ID4gKwkJCXRyaXBzIHsNCj4gPiArCQkJCXBsdF9hbGVydDog
cGx0LWFsZXJ0IHsNCj4gPiArCQkJCQl0ZW1wZXJhdHVyZSA9IDw4NTAwMD47DQo+ID4gKwkJCQkJ
aHlzdGVyZXNpcyA9IDwyMDAwPjsNCj4gPiArCQkJCQl0eXBlID0gInBhc3NpdmUiOw0KPiA+ICsJ
CQkJfTsNCj4gPiArDQo+ID4gKwkJCQlwbHRfY3JpdDogcGx0LWNyaXQgew0KPiA+ICsJCQkJCXRl
bXBlcmF0dXJlID0gPDk1MDAwPjsNCj4gPiArCQkJCQloeXN0ZXJlc2lzID0gPDIwMDA+Ow0KPiA+
ICsJCQkJCXR5cGUgPSAiY3JpdGljYWwiOw0KPiA+ICsJCQkJfTsNCj4gPiArCQkJfTsNCj4gPiAr
DQo+ID4gKwkJCWNvb2xpbmctbWFwcyB7DQo+ID4gKwkJCQltYXAwIHsNCj4gPiArCQkJCQl0cmlw
ID0gPCZwbHRfYWxlcnQ+Ow0KPiA+ICAJCQkJCWNvb2xpbmctZGV2aWNlID0NCj4gPiAgCQkJCQkJ
PCZjcHUwIFRIRVJNQUxfTk9fTElNSVQNCj4gVEhFUk1BTF9OT19MSU1JVD4sDQo+ID4gIAkJCQkJ
CTwmY3B1MSBUSEVSTUFMX05PX0xJTUlUDQo+IFRIRVJNQUxfTk9fTElNSVQ+LA0KPiA+IC0tDQo+
ID4gMS43LjENCj4gPg0K
