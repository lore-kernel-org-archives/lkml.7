Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A145AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C72205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AsmRD968"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfCRKJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:09:19 -0400
Received: from mail-eopbgr10088.outbound.protection.outlook.com ([40.107.1.88]:32840
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727130AbfCRKJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxagMeiteWidLro3dGUpcOaM0OL2qxicyzuUQ4MuHFc=;
 b=AsmRD968LyELNliOG6guXL62Ovu/iulbLX3C7mNnQNvi+8lmjXEHaKOdClCFcCYBLx0ziG3lU3o+mheWqdlkJDq1DY+VewHGaBAVc4Qr71/ABezDq1g7cRtFNsd8GFTs7tTjyr8N4qNzDPz6B2C1oQH/WmcWZ9oLGWHQDJ/Ce/o=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 10:09:01 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 10:09:01 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V5 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Topic: [PATCH V5 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Index: AQHU3V4B0+Op6lebhUq7cDF33YTb6qYRJ5kAgAACvOA=
Date:   Mon, 18 Mar 2019 10:09:01 +0000
Message-ID: <DB3PR0402MB3916F037CC96A5CDE328BC19F5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
 <1552894581-3391-2-git-send-email-Anson.Huang@nxp.com>
 <20190318095842.GD17565@ulmo>
In-Reply-To: <20190318095842.GD17565@ulmo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bf837e4-f43d-4bc3-4ecf-08d6ab89be94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3754;
x-ms-traffictypediagnostic: DB3PR0402MB3754:
x-microsoft-antispam-prvs: <DB3PR0402MB37544FCF16755FCF0B3F07E1F5470@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(366004)(136003)(39860400002)(346002)(396003)(13464003)(189003)(199004)(105586002)(7736002)(106356001)(71190400001)(71200400001)(305945005)(7416002)(476003)(74316002)(316002)(33656002)(9686003)(55016002)(229853002)(14454004)(52536014)(6436002)(53936002)(54906003)(446003)(6346003)(11346002)(2906002)(81156014)(8676002)(81166006)(8936002)(5660300002)(97736004)(53546011)(68736007)(102836004)(6506007)(66066001)(4326008)(186003)(3846002)(6116002)(478600001)(6246003)(256004)(76176011)(26005)(99286004)(7696005)(486006)(44832011)(25786009)(86362001)(6916009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3754;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r2cLjSYzKaLbjbsRWP6GtZHpTttq/8ZtLvk0q08/GAVn1bQqj4yuCkGWNBl/CJB53rLdb0sOS/Tpajtj0NG14pacey6cZ3024NlNJlpFf2199j8hZU/PcofMAczQ1wi7dVJjiREC0h+AuLPwERss/lkJQicMwmf7MWjM7tisTJcIe99KS8qOubAyEm8NKZKyy8ckeyPdTSYo659dfDNSC6ZzT5fwqeU3wPg/CC3jGIvGcgtSzhebxrB9tE92GPR76T25VZMpzihTLC2vagHvMDrqqXE4rukm2CQX07vUU/K2yRbwcoGlCDoD3roJ6QYfFMScNIxDPza2YW5qgNK1p34fr26YbrT5S17/eOEurL5AMv7scK6FYbAcS8HR2CrhauNxvXD1tGbEgWcgBnyrznEJy7t29LXJEWiSnSsM46U=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf837e4-f43d-4bc3-4ecf-08d6ab89be94
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 10:09:01.4893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFRoaWVycnkNCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaGllcnJ5IFJlZGluZyBbbWFpbHRvOnRoaWVycnku
cmVkaW5nQGdtYWlsLmNvbV0NCj4gU2VudDogMjAxOcTqM9TCMTjI1SAxNzo1OQ0KPiBUbzogQW5z
b24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7
IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBl
bmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsN
Cj4gbGludXhAYXJtbGludXgub3JnLnVrOyBvdGF2aW9Ab3NzeXN0ZW1zLmNvbS5icjsgc3RlZmFu
QGFnbmVyLmNoOw0KPiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsg
Um9iaW4gR29uZw0KPiA8eWliaW4uZ29uZ0BueHAuY29tPjsgamFuLnR1ZXJrQGVtdHJpb24uY29t
OyBsaW51eC0NCj4gcHdtQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IHUua2xlaW5lLQ0KPiBrb2VuaWdAcGVuZ3V0cm9uaXguZGU7IGRs
LWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjUg
MS81XSBkdC1iaW5kaW5nczogcHdtOiBBZGQgaS5NWCBUUE0gUFdNIGJpbmRpbmcNCj4gDQo+IE9u
IE1vbiwgTWFyIDE4LCAyMDE5IGF0IDA3OjQxOjMyQU0gKzAwMDAsIEFuc29uIEh1YW5nIHdyb3Rl
Og0KPiA+IEFkZCBpLk1YIFRQTShMb3cgUG93ZXIgVGltZXIvUHVsc2UgV2lkdGggTW9kdWxhdGlv
biBNb2R1bGUpIFBXTQ0KPiBiaW5kaW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24g
SHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gTm8gY2hhbmdlcy4NCj4g
PiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBt
LXB3bS50eHQgfCAxOQ0KPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDE5IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBtLXB3bS50eHQNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10
cG0tcHdtLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9p
bXgtdHBtLXB3bS50eHQNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAw
MDAuLmQ0N2I4ZmINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBtLXB3bS50eHQNCj4gPiBAQCAtMCwwICsxLDE5
IEBADQo+ID4gK0ZyZWVzY2FsZSBpLk1YIFRQTSBQV00gY29udHJvbGxlcg0KPiA+ICsNCj4gPiAr
UmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiArLSBjb21wYXRpYmxlIDogU2hvdWxkIGJlICJmc2ws
aW14LXRwbS1wd20iLg0KPiANCj4gU2hvdWxkIHRoaXMgcGVyaGFwcyBvbmx5IGJlICJmc2wsaW14
LXRwbSI/IFNvdW5kcyB0byBtZSBsaWtlIHRoaXMgaXMgYQ0KPiBoYXJkd2FyZSBibG9jayBjYWxs
ZWQgIlRQTSIgdGhhdCBjYW4gYmUgdXNlZCBhcyBhIFBXTS4gVGhlIGNvbXBhdGlibGUNCj4gc3Ry
aW5nIHNob3VsZCBkZXNjcmliZSB0aGUgaGFyZHdhcmUgYmxvY2ssIG5vdCB0aGUgbW9kZSBpbiB3
aGljaCBpdCBpcyB1c2VkLg0KDQpPSywgd2lsbCBmaXggaXQuDQoNCj4gDQo+ID4gKy0gcmVnOiBQ
aHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgY29udHJvbGxlcidzIHJlZ2lz
dGVycy4NCj4gPiArLSAjcHdtLWNlbGxzOiBTaG91bGQgYmUgMi4gU2VlIHB3bS50eHQgaW4gdGhp
cyBkaXJlY3RvcnkgZm9yIGEgZGVzY3JpcHRpb24NCj4gb2YgdGhlIGNlbGxzIGZvcm1hdC4NCj4g
PiArLSBjbG9ja3MgOiBUaGUgY2xvY2sgcHJvdmlkZWQgYnkgdGhlIFNvQyB0byBkcml2ZSB0aGUg
UFdNLg0KPiA+ICstIGludGVycnVwdHM6IFRoZSBpbnRlcnJ1cHQgZm9yIHRoZSBwd20gY29udHJv
bGxlci4NCj4gDQo+IHB3bSAtPiBQV00NCg0KT0suDQpUaGFua3MsDQpBbnNvbg0KDQo+IA0KPiBU
aGllcnJ5DQo=
