Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E39C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5E7205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FMm8sBC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfEJM1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 08:27:25 -0400
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:55937
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbfEJM1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHQXVUEn7N7YGebv5xUl/OmglcApPH+o81T15w0vtHU=;
 b=FMm8sBC3VbFK2zOp1cO6Y8MMcnkPrq73GBGbhn3Mx4KffRCj3zIzGwx8Ek0MKvhNOCp4NEnSc239d1FSjk8ScNqho073X4gm5c6DHckplQSjOkOm5mTIHb4vRMo7rmGybvDUK/EIbroq4resF+llUbHwJ+Hk8GmFha0cyhAshp4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3676.eurprd04.prod.outlook.com (52.134.70.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Fri, 10 May 2019 12:27:19 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 12:27:19 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: imx_v6_v7_defconfig: Enable
 CONFIG_THERMAL_STATISTICS
Thread-Topic: [PATCH] ARM: imx_v6_v7_defconfig: Enable
 CONFIG_THERMAL_STATISTICS
Thread-Index: AQHU+k2bJJ9MRtHiIEOyvuqXcpXxpaZjzH4AgAAam8CAAHrbwA==
Date:   Fri, 10 May 2019 12:27:18 +0000
Message-ID: <DB3PR0402MB39167B660667C2322E7787E2F50C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1556076113-4593-1-git-send-email-Anson.Huang@nxp.com>
 <20190510032917.GG15856@dragon>
 <DB3PR0402MB391661070B9F664C9E9577B0F50C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391661070B9F664C9E9577B0F50C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ae06b1a-9120-4513-1796-08d6d542d822
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3676;
x-ms-traffictypediagnostic: DB3PR0402MB3676:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB36760825CF8AB4340938DB47F50C0@DB3PR0402MB3676.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:451;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(366004)(199004)(189003)(13464003)(7416002)(53936002)(81156014)(6306002)(2940100002)(186003)(2906002)(6116002)(14454004)(6916009)(3846002)(6246003)(6506007)(256004)(446003)(44832011)(33656002)(486006)(5660300002)(74316002)(476003)(53546011)(102836004)(11346002)(26005)(66066001)(99286004)(8936002)(9686003)(52536014)(68736007)(478600001)(7696005)(76176011)(81166006)(8676002)(25786009)(76116006)(6436002)(305945005)(4326008)(229853002)(7736002)(73956011)(316002)(54906003)(71190400001)(71200400001)(966005)(66946007)(66476007)(66556008)(64756008)(66446008)(86362001)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3676;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s4sA/rA6Zsv+xH5ZgacPYnUxwEmpPyWtJmIvG263I6l3zEVpBSF0LB3O0gGdz/0nutVlAjlmnm5PFkPzU7mj17isMCfQ8Yfgg1IL55Am74UiCijCbhFreixlYKBHRPRuI35UhWI7YGTArw7UJWiDH3WTH2Xkn3Cyc8Cldx98oa57crntwwJ6bqPyx05evr6Nn4h8cuBUv+0mSaOr3flE4hpnvc/bj4d2txlUMzIboNgXhfGJJ3JTB2eCB7cmh4SUY++5WlSfeXnu/snAaD6LzuN5fvgApF9GsnpsrJerTtOHtH1AIkHXfmfc/RGd4PXQCmaxtR5av2w1fL0oZr5P8/6dQb+yjdQMkBox+IdtkqMByOmToKQHrXYBVcAKssIR6QSPjUVn/wUGm1mGb6cKyEToCwkYycvCttdpDD14Rco=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae06b1a-9120-4513-1796-08d6d542d822
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 12:27:18.8463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoJSSBoYXZlIHJlc2VudCB0aGlzIHBhdGNoIHdpdGggIkNvbnRlbnQtVHJhbnNm
ZXItRW5jb2Rpbmc6IHF1b3RlZC1wcmludGFibGUiLCBjYW4geW91IGNoZWNrIGlmIHlvdSBjYW4g
YXBwbHkgdGhlIHBhdGNoIGNvcnJlY3RseSwgaWYgeWVzLCBwbGVhc2UgbGV0IG1lIGtub3cgYW5k
IEkgd2lsbCByZXNlbmQgYWxsIHBhdGNoZXMgbWFpbnRhaW5lZCBieSB5b3Ugd2l0aCB0aGlzIGVu
Y29kaW5nIHR5cGUuIFBhdGNoOiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEw
OTM4NzI1Lw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuc29uIEh1
YW5nDQo+IFNlbnQ6IEZyaWRheSwgTWF5IDEwLCAyMDE5IDE6MDUgUE0NCj4gVG86ICdTaGF3biBH
dW8nIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPiBDYzogbGludXhAYXJtbGludXgub3JnLnVrOyBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFt
QGdtYWlsLmNvbTsgb3RhdmlvQG9zc3lzdGVtcy5jb20uYnI7DQo+IExlb25hcmQgQ3Jlc3RleiA8
bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+OyBSb2JpbiBHb25nDQo+IDx5aWJpbi5nb25nQG54cC5j
b20+OyB1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU7DQo+IGphbi50dWVya0BlbXRyaW9u
LmNvbTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4g
U3ViamVjdDogUkU6IFtQQVRDSF0gQVJNOiBpbXhfdjZfdjdfZGVmY29uZmlnOiBFbmFibGUNCj4g
Q09ORklHX1RIRVJNQUxfU1RBVElTVElDUw0KPiANCj4gSGksIFNoYXduDQo+IA0KPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogU2hhd24gR3VvIFttYWlsdG86c2hhd25n
dW9Aa2VybmVsLm9yZ10NCj4gPiBTZW50OiBGcmlkYXksIE1heSAxMCwgMjAxOSAxMToyOSBBTQ0K
PiA+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gPiBDYzogbGludXhA
YXJtbGludXgub3JnLnVrOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiA+IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBvdGF2aW9Ab3NzeXN0ZW1zLmNvbS5icjsN
Cj4gPiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsgUm9iaW4gR29u
Zw0KPiA+IDx5aWJpbi5nb25nQG54cC5jb20+OyB1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXgu
ZGU7DQo+ID4gamFuLnR1ZXJrQGVtdHJpb24uY29tOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4
LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gQVJNOiBp
bXhfdjZfdjdfZGVmY29uZmlnOiBFbmFibGUNCj4gPiBDT05GSUdfVEhFUk1BTF9TVEFUSVNUSUNT
DQo+ID4NCj4gPiBPbiBXZWQsIEFwciAyNCwgMjAxOSBhdCAwMzoyNzoxM0FNICswMDAwLCBBbnNv
biBIdWFuZyB3cm90ZToNCj4gPiA+IEVuYWJsZSBDT05GSUdfVEhFUk1BTF9TVEFUSVNUSUNTIHRv
IGV4dGVuZCB0aGUgc3lzZnMgaW50ZXJmYWNlIGZvcg0KPiA+ID4gdGhlcm1hbCBjb29saW5nIGRl
dmljZXMgYW5kIGV4cG9zZSBzb21lIHVzZWZ1bCBzdGF0aXN0aWNzLg0KPiA+ID4NCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+DQo+ID4g
SSBkb24ndCBhcHBseSBwYXRjaCB1c2luZyBiYXNlNjQgZW5jb2RpbmcuDQo+IA0KPiBJdCBpcyBv
dXIgc2VydmVyIGlzc3VlIGFuZCB3ZSBoYXZlIHJlcG9ydGVkIGl0IHRvIGxvY2FsIElULCB3aWxs
IHJlc2VuZCBwYXRjaA0KPiBvbmNlIGlzc3VlIGlzIHNvbHZlZC4NCj4gDQo+IFRoYW5rcywNCj4g
QW5zb24uDQo+IA0KPiA+DQo+ID4gU2hhd24NCg==
