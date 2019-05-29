Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4167DC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 05:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FAC20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 05:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pXG4xW7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfE2FRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 01:17:51 -0400
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:35891
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbfE2FRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 01:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP+y0oxk0+NX3SMiMJrxC8di8BJGijzwjbv+xENaCAc=;
 b=pXG4xW7jKiJivEaZNoFMXuCY8aS4OE9byDJoZXvcyb60+eCUHpZh09orEI/Gr1nF6Shfwxx6Tscif4g7OmtOlxlo01Fv1ceYRpDeOyeLj1dXxluhhfZBzpbZNBhzRJlriXbsy5p2l1F7t9BGbq8r5kq3OodNhx9AEzMw2XnVVVQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 05:17:47 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 05:17:47 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH RESEND 2/5] ARM: dts: imx7d-sdb: Assign corresponding
 power supply for LDOs
Thread-Topic: [PATCH RESEND 2/5] ARM: dts: imx7d-sdb: Assign corresponding
 power supply for LDOs
Thread-Index: AQHVCKkZhfxt7jnKxUqx2zVaOAuHUqaBqaow
Date:   Wed, 29 May 2019 05:17:47 +0000
Message-ID: <DB3PR0402MB391628E1B6D27C9AC5B02DB8F51F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1557654739-12564-1-git-send-email-Anson.Huang@nxp.com>
 <1557654739-12564-2-git-send-email-Anson.Huang@nxp.com>
 <VI1PR04MB5055647612FAC2FE6FBE139FEE1E0@VI1PR04MB5055.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5055647612FAC2FE6FBE139FEE1E0@VI1PR04MB5055.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8261d2ef-81ee-4fcc-af2b-08d6e3f4fcd9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB392913E0B0ECD32D3AC94397F51F0@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(13464003)(189003)(186003)(33656002)(3846002)(6116002)(476003)(6436002)(478600001)(86362001)(26005)(486006)(11346002)(2906002)(446003)(5660300002)(74316002)(44832011)(53936002)(14454004)(68736007)(81166006)(54906003)(55016002)(71190400001)(99286004)(6246003)(229853002)(8936002)(9686003)(316002)(71200400001)(66066001)(8676002)(53546011)(66476007)(4326008)(305945005)(52536014)(6506007)(66946007)(102836004)(25786009)(66556008)(7736002)(76116006)(7696005)(73956011)(6862004)(76176011)(66446008)(6636002)(81156014)(256004)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fVk+uAnVwKhEZtbp4nKT/7m6QRhl7o7btdgEta5QX1XcbYXIB1tHLC9EvU3YPNxpT1XbZAnLmwH2sJBx/2P3R7uKPt4RGoy3OnmsbJxQbXRc41GRbyvcZ38+Fy8edC5Sv8LjFC1oc4NBJ779MeCxokYSbyigOctdaQefKyjNjhkrQYpO/LTdYhxBo9yH7Y3FhZNDEMyCorH/CSMZuaoggneDp9IEnFN5epN5SypbU5nmMvg1WTgtzo24x/SR0yUVP7iZhYig7yVkk+buScjuYXuBvdaiUsRmW3DK/PH0hiV9XJxSvYAx2VYGfRk0rT4C1s1OOfcK0KtmR7rBmwXLRfIJuLBIr+ByAPsk+dDbKAWlbNY9lz8dSfVfOBqJq9pFn8B5Wt1UFhxEzpu3gyMlSq5FNiT6wPJFT240Prnwrn8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8261d2ef-81ee-4fcc-af2b-08d6e3f4fcd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 05:17:47.2334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZW9u
YXJkIENyZXN0ZXoNCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjksIDIwMTkgMzoyNCBBTQ0KPiBU
bzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiByb2JoK2R0QGtlcm5l
bC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhh
dWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWls
LmNvbTsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkVTRU5E
IDIvNV0gQVJNOiBkdHM6IGlteDdkLXNkYjogQXNzaWduIGNvcnJlc3BvbmRpbmcNCj4gcG93ZXIg
c3VwcGx5IGZvciBMRE9zDQo+IA0KPiBPbiAxMi4wNS4yMDE5IDEyOjU3LCBBbnNvbiBIdWFuZyB3
cm90ZToNCj4gPiBPbiBpLk1YN0QgU0RCIGJvYXJkLCBzdzIgc3VwcGxpZXMgMXAwZC8xcDIgTERP
LCB0aGlzIHBhdGNoIGFzc2lnbnMNCj4gPiBjb3JyZXNwb25kaW5nIHBvd2VyIHN1cHBseSBmb3Ig
MXAwZC8xcDIgTERPIHRvIGF2b2lkIGNvbmZ1c2lvbiBieQ0KPiA+IGJlbG93IGxvZzoNCj4gPg0K
PiA+IHZkZDFwMGQ6IHN1cHBsaWVkIGJ5IHJlZ3VsYXRvci1kdW1teQ0KPiA+IHZkZDFwMjogc3Vw
cGxpZWQgYnkgcmVndWxhdG9yLWR1bW15DQo+ID4NCj4gPiBXaXRoIHRoaXMgcGF0Y2gsIHRoZSBw
b3dlciBzdXBwbHkgaXMgbW9yZSBhY2N1cmF0ZToNCj4gPg0KPiA+IHZkZDFwMGQ6IHN1cHBsaWVk
IGJ5IFNXMg0KPiA+IHZkZDFwMjogc3VwcGxpZWQgYnkgU1cyDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14N2Qtc2RiLmR0cw0KPiA+IGIvYXJjaC9hcm0vYm9vdC9k
dHMvaW14N2Qtc2RiLmR0cw0KPiA+DQo+ID4gKyZyZWdfMXAwZCB7DQo+ID4gKwl2aW4tc3VwcGx5
ID0gPCZzdzJfcmVnPjsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZyZWdfMXAyIHsNCj4gPiArCXZp
bi1zdXBwbHkgPSA8JnN3Ml9yZWc+Ow0KPiA+ICt9Ow0KPiANCj4gSXQncyBub3QgY2xlYXIgd2h5
IGJ1dCB0aGlzIHBhdGNoIGJyZWFrcyBpbXg3ZC1zZGIgYm9vdC4gQ2hlY2tlZCB0d28NCj4gYm9h
cmRzOiBpbiBhIGJvYXJkIGZhcm0gYW5kIG9uIG15IGRlc2suDQoNClRoYW5rcyBmb3IgcmVwb3J0
aW5nIHRoaXMgaXNzdWUsIEkgY2FuIHJlcHJvZHVjZSBpdCBub3csIGEgcXVpY2sgZGVidWcgc2hv
d3MNCnRoYXQgd2l0aCB0aGlzIHBhdGNoLCB3aGVuIHNldHRpbmcgcmVnXzFwMGQncyB2b2x0YWdl
IHRvIDEuMFYsIHRoZSBTVzIncyB2b2x0YWdlDQp3aWxsIGJlIGNoYW5nZWQgdG8gMS41ViwgdGhl
IGV4cGVjdGVkIHZvbHRhZ2Ugc2hvdWxkIGJlIDEuOFYsIHNvIDEuNVYgY2F1c2UgYm9hcmQNCnJl
c2V0LiBCZWxvdyBwYXRjaCBjYW4gZml4IHRoaXMgaXNzdWUsIGJ1dCBJIGFtIHN0aWxsIGNoZWNr
aW5nIGlmIHRoaXMgaXMgdGhlIGJlc3QgZml4LCBvbmNlDQpJIGZpZ3VyZSBvdXQsIEkgd2lsbCBz
ZW5kIG91dCBhIGZpeCBwYXRjaCBmb3IgcmV2aWV3Og0KDQorKysgYi9hcmNoL2FybS9ib290L2R0
cy9pbXg3ZC1zZGIuZHRzDQpAQCAtMjY3LDYgKzI2Nyw3IEBADQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDE4NTAwMDA+Ow0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICByZWd1bGF0b3ItYm9vdC1vbjsNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmVndWxhdG9yLWFsd2F5cy1vbjsNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVndWxhdG9yLW1heC1zdGVwLW1pY3Jvdm9sdCA9IDwyNTAwMD47
DQogICAgICAgICAgICAgICAgICAgICAgICB9Ow0KDQpUaGFua3MsDQpBbnNvbg0KDQo+IA0KPiAt
LQ0KPiBSZWdhcmRzLA0KPiBMZW9uYXJkDQo=
