Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC62C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34DC204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ENBhy1Ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfCRJuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:50:19 -0400
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]:29825
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727022AbfCRJuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMvC5JkqiyTBm8ny3zVe1+ccnpmi4XitE626onBKKvg=;
 b=ENBhy1UlcCNiD2+38DYvrB+5SHJiPA9YN8obqO9WU6hmnc26SICPAtPpwVUu8ZaR8K4jBmq+0HYzh3/d4C3av42oEj+nAA2jaxliLlmpu0DFrLVXfYxq5RKizuKAG25fXbVr54zYA0ykz93kfdwMjCrorTKIYKyzdfcpdi/WYgA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3673.eurprd04.prod.outlook.com (52.134.70.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 09:50:01 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 09:50:01 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stefan Agner <stefan@agner.ch>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
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
Thread-Index: AQHU3V4B0+Op6lebhUq7cDF33YTb6qYRC60AgAAZROA=
Date:   Mon, 18 Mar 2019 09:50:01 +0000
Message-ID: <DB3PR0402MB3916ABEA308378751FE54D21F5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
 <1552894581-3391-2-git-send-email-Anson.Huang@nxp.com>
 <d1f8b006ad56e8ed4e9fb9137148d98b@agner.ch>
In-Reply-To: <d1f8b006ad56e8ed4e9fb9137148d98b@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3eb431a-e644-4761-5538-08d6ab871707
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3673;
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-microsoft-antispam-prvs: <DB3PR0402MB3673DE2661183C173D48FC6DF5470@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(13464003)(54906003)(71190400001)(74316002)(44832011)(7736002)(71200400001)(316002)(33656002)(305945005)(68736007)(53936002)(478600001)(8676002)(52536014)(229853002)(66066001)(256004)(5660300002)(81156014)(486006)(6116002)(97736004)(3846002)(11346002)(86362001)(446003)(81166006)(6436002)(186003)(476003)(6246003)(6916009)(7696005)(7416002)(14454004)(25786009)(76176011)(2906002)(106356001)(55016002)(9686003)(105586002)(4326008)(8936002)(102836004)(6506007)(53546011)(99286004)(26005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3673;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xm4mLAIAInjrgMfuPEKwAUPBbkkaduYIIBqIAj+wSE37IDLA/CTA10wdjw1lCFQUAiU/02zBsmtpvu989z9OnaJXvBYmz2ZIQzWWBk042kpCxj3ct0WQwVRyy7Ok/19UcT5/er3xeUcoJe/GPmM4dPAVBSWNrzbdKdln8NMsqMGGgUGDtP1lasXPwKFrYGwbRTqEqOjA2rTW1KGA7vlnEhELNgWfoR4j/hcJgcT8zJ/6DyyFkLv3hg9nr9DEUaplUWRouheR7Myd4r47wUWkTdtvyE//zSCG1hz/mZyarMppwfIkvpp5s3cJ8mjMv6hjBuqTJXpyEp5TdpvG04ga+SQH5sjIERz3cYD/noaKkah39FqHLs20xIT4TcxsiSr60BGapnhhC8YE0wwakvpqZMwUTfVp4JDlgVHYyo8yKhE=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3eb431a-e644-4761-5538-08d6ab871707
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 09:50:01.3284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZWZhbg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZWZhbiBBZ25lciBbbWFpbHRvOnN0ZWZhbkBhZ25l
ci5jaF0NCj4gU2VudDogMjAxOcTqM9TCMTjI1SAxNjoxOQ0KPiBUbzogQW5zb24gSHVhbmcgPGFu
c29uLmh1YW5nQG54cC5jb20+DQo+IENjOiB0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207IHJvYmgr
ZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5v
cmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVz
dGV2YW1AZ21haWwuY29tOyBsaW51eEBhcm1saW51eC5vcmcudWs7IG90YXZpb0Bvc3N5c3RlbXMu
Y29tLmJyOw0KPiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsgUm9i
aW4gR29uZw0KPiA8eWliaW4uZ29uZ0BueHAuY29tPjsgamFuLnR1ZXJrQGVtdHJpb24uY29tOyBs
aW51eC0NCj4gcHdtQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IHUua2xlaW5lLQ0KPiBrb2VuaWdAcGVuZ3V0cm9uaXguZGU7IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjUgMS81
XSBkdC1iaW5kaW5nczogcHdtOiBBZGQgaS5NWCBUUE0gUFdNIGJpbmRpbmcNCj4gDQo+IE9uIDE4
LjAzLjIwMTkgMDg6NDEsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IEFkZCBpLk1YIFRQTShMb3cg
UG93ZXIgVGltZXIvUHVsc2UgV2lkdGggTW9kdWxhdGlvbiBNb2R1bGUpIFBXTQ0KPiBiaW5kaW5n
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gTm8gY2hhbmdlcy4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBtLXB3bS50eHQgfCAxOQ0KPiA+ICsrKysr
KysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykNCj4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3B3bS9pbXgtdHBtLXB3bS50eHQNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10cG0tcHdtLnR4dA0KPiA+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBtLXB3bS50eHQNCj4gPiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAuLmQ0N2I4ZmINCj4gPiAtLS0gL2Rl
di9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9p
bXgtdHBtLXB3bS50eHQNCj4gPiBAQCAtMCwwICsxLDE5IEBADQo+ID4gK0ZyZWVzY2FsZSBpLk1Y
IFRQTSBQV00gY29udHJvbGxlcg0KPiA+ICsNCj4gPiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4g
PiArLSBjb21wYXRpYmxlIDogU2hvdWxkIGJlICJmc2wsaW14LXRwbS1wd20iLg0KPiA+ICstIHJl
ZzogUGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIGNvbnRyb2xsZXIncyBy
ZWdpc3RlcnMuDQo+ID4gKy0gI3B3bS1jZWxsczogU2hvdWxkIGJlIDIuIFNlZSBwd20udHh0IGlu
IHRoaXMgZGlyZWN0b3J5IGZvciBhDQo+ID4gZGVzY3JpcHRpb24gb2YgdGhlIGNlbGxzIGZvcm1h
dC4NCj4gDQo+IEl0IHNlZW1zIHRoYXQgdGhlIGRyaXZlciBzdXBwb3J0cyBwb2xhcml0eS4gQ2Fu
IHdlIHVzZSAzIGNlbGxzIHNvIHdlIGNhbg0KPiBzcGVjaWZ5IHRoZSBwb2xhcml0eSBpbiB0aGUg
ZGV2aWNlIHRyZWU/DQo+IA0KPiBBbHNvIHVzZSAzIGNlbGxzIGluIHRoZSBiYXNlIGRldmljZSB0
cmVlIHRvIGVuYWJsZSBvdGhlciBib2FyZHMgbWFraW5nIHVzZSBvZg0KPiB0aGUgcG9sYXJpdHkg
KGFyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAuZHRzaSkuDQoNCkl0IG1ha2VzIHNlbnNlLCBJIHdp
bGwgY2hhbmdlIGl0IHRvIDMgY2VsbHMgYW5kIHNwZWNpZnkgdGhlIHBvbGFyaXR5IGluIGJhY2ts
aWdodCBub2RlLg0KDQpBbnNvbi4NCg0KPiANCj4gLS0NCj4gU3RlZmFuDQo+IA0KPiA+ICstIGNs
b2NrcyA6IFRoZSBjbG9jayBwcm92aWRlZCBieSB0aGUgU29DIHRvIGRyaXZlIHRoZSBQV00uDQo+
ID4gKy0gaW50ZXJydXB0czogVGhlIGludGVycnVwdCBmb3IgdGhlIHB3bSBjb250cm9sbGVyLg0K
PiA+ICsNCj4gPiArRXhhbXBsZToNCj4gPiArDQo+ID4gK3B3bTA6IHRwbUA0MDI1MDAwMCB7DQo+
ID4gKwljb21wYXRpYmxlID0gImZzbCxpbXgtdHBtLXB3bSI7DQo+ID4gKwlyZWcgPSA8MHg0MDI1
MDAwMCAweDEwMDA+Ow0KPiA+ICsJYXNzaWduZWQtY2xvY2tzID0gPCZjbGtzIElNWDdVTFBfQ0xL
X0xQVFBNND47DQo+ID4gKwlhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZjbGtzIElNWDdVTFBf
Q0xLX1NPU0NfQlVTX0NMSz47DQo+ID4gKwljbG9ja3MgPSA8JmNsa3MgSU1YN1VMUF9DTEtfTFBU
UE00PjsNCj4gPiArCSNwd20tY2VsbHMgPSA8Mj47DQo+ID4gK307DQo=
