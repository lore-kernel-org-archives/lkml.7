Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C23C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491072080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YijYBpIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfCZA5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:57:10 -0400
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:52726
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbfCZA5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g81B7IyllW2gDNznuaujyrlFSFmX51mZi6oIzTDGfI8=;
 b=YijYBpIVSgsmL/jdJzckQUPOdgVcEYxHbcV97fqdn20VlZyDahF7o9K1iMfJ9J0TNmBWkXJU4g9L4YmLUrYE9f9UkqyRmTu0Abnl4oR4K3G7KjazDB5C3fMn8aCKmsJoNg6rrfeO2jrPniTRk/TPSKe8S3bw6IPHq9ow/KBxTYA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3932.eurprd04.prod.outlook.com (52.134.72.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 00:56:26 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 00:56:26 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
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
Subject: RE: [PATCH V9 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Topic: [PATCH V9 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Index: AQHU4FFLawhysUr2ckuOKuIEIybWsaYc1aWAgABF1lA=
Date:   Tue, 26 Mar 2019 00:56:26 +0000
Message-ID: <DB3PR0402MB3916B84081393C46609FD178F55F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1553218974-20464-1-git-send-email-Anson.Huang@nxp.com>
 <1553218974-20464-2-git-send-email-Anson.Huang@nxp.com>
 <20190325204137.GA19824@bogus>
In-Reply-To: <20190325204137.GA19824@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12f1276c-d83c-420e-5b38-08d6b185e028
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3932;
x-ms-traffictypediagnostic: DB3PR0402MB3932:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB3932F9488F79D399D371EF26F55F0@DB3PR0402MB3932.eurprd04.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(136003)(396003)(13464003)(199004)(189003)(486006)(33656002)(6916009)(81166006)(446003)(6246003)(2906002)(11346002)(9686003)(54906003)(4326008)(53936002)(6436002)(55016002)(25786009)(44832011)(105586002)(476003)(316002)(229853002)(76176011)(7696005)(106356001)(14454004)(5660300002)(7736002)(26005)(186003)(53546011)(6506007)(7416002)(71200400001)(97736004)(71190400001)(3846002)(6116002)(74316002)(8676002)(99286004)(86362001)(68736007)(81156014)(256004)(8936002)(66066001)(52536014)(102836004)(478600001)(14444005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3932;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FuS/zmKak+kgxbU3SAvV8ye6MFDfPxrGwNBciA8pZb/wd+QQKGQO328nlV+Wg9cHnNl9nBs0RfAD8YTxgrPp9bs+LNx25zp3wgD9+jp3EakaFGGfrA3XQu2Ogi/mVP+UOIa3BSFrO4NgUCTLCUJqXCWrXVpq4N+VdEcEFJqSeeKiYScfsNkytq4ptuBcQIyvfQ3vdDwQXDQ2o28yanLqTySCvEEV0sJItAdCZxcCgcmR7isYQXrhz+Sx5TNVYMA5RwtF+YZeCcoKErbz1zRZzx+URPM51GUxTx88NAydjwYvHqiuWjJ7SdtUU3Kwfkyltj08wZXzDWv0MLf8xzSzE5nXJyM8j3NnRX7uToxzFS647SkyIQeago7n2VeB2lvwMENPR8eCch7MiZKyWboQeT5RVVxFUO1CUL7mhZhtxrk=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f1276c-d83c-420e-5b38-08d6b185e028
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 00:56:26.8151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIFttYWlsdG86cm9iaEBrZXJuZWwub3Jn
XQ0KPiBTZW50OiAyMDE5xOoz1MIyNsjVIDQ6NDINCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5o
dWFuZ0BueHAuY29tPg0KPiBDYzogdGhpZXJyeS5yZWRpbmdAZ21haWwuY29tOyBtYXJrLnJ1dGxh
bmRAYXJtLmNvbTsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5k
ZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4QGFy
bWxpbnV4Lm9yZy51azsgc3RlZmFuQGFnbmVyLmNoOw0KPiBvdGF2aW9Ab3NzeXN0ZW1zLmNvbS5i
cjsgTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47DQo+IFJvYmluIEdv
bmcgPHlpYmluLmdvbmdAbnhwLmNvbT47IGphbi50dWVya0BlbXRyaW9uLmNvbTsgbGludXgtDQo+
IHB3bUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1h
cm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyB1LmtsZWluZS0NCj4ga29lbmlnQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgg
PGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY5IDEvNV0gZHQtYmlu
ZGluZ3M6IHB3bTogQWRkIGkuTVggVFBNIFBXTSBiaW5kaW5nDQo+IA0KPiBPbiBGcmksIE1hciAy
MiwgMjAxOSBhdCAwMTo0ODowNUFNICswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBBZGQg
aS5NWCBUUE0oTG93IFBvd2VyIFRpbWVyL1B1bHNlIFdpZHRoIE1vZHVsYXRpb24gTW9kdWxlKSBQ
V00NCj4gYmluZGluZy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNv
bi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IE5vIGNoYW5nZXMuDQo+IA0KPiB2OT8gSSBk
b24ndCByZWNhbGwgc2VlaW5nIGFueSBwcmV2aW91cyB2ZXJzaW9ucy4NCg0KSSBjaGVja2VkIG15
IG1haWxib3gsIHlvdSBhcmUgaW4gdGhlICJ0byIgbGlzdCBpbiBldmVyeSB2ZXJzaW9uLiBUaGUg
Zmlyc3QgdmVyc2lvbidzIHN1YmplY3QgaXM6DQpbUEFUQ0ggMS81XSBkdC1iaW5kaW5nczogcHdt
OiBBZGQgaS5NWCBUUE0gUFdNIGJpbmRpbmcuLi4NCg0KPiANCj4gPiAtLS0NCj4gPiAgLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10cG0tcHdtLnR4dCAgICAgICAgfCAyMg0KPiArKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCsp
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wd20vaW14LXRwbS1wd20udHh0DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBtLXB3bS50eHQNCj4gPiBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRwbS1wd20udHh0DQo+ID4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi45NGYxYWQ1DQo+ID4gLS0t
IC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
d20vaW14LXRwbS1wd20udHh0DQo+ID4gQEAgLTAsMCArMSwyMiBAQA0KPiA+ICtGcmVlc2NhbGUg
aS5NWCBUUE0gUFdNIGNvbnRyb2xsZXINCj4gPiArDQo+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6
DQo+ID4gKy0gY29tcGF0aWJsZSA6IFNob3VsZCBiZSAiZnNsLGlteC10cG0iLg0KPiANCj4gTmVl
ZHMgdG8gYmUgU29DIHNwZWNpZmljLg0KDQpPSywgd2lsbCBjaGFuZ2UgaXQgdG8gImZzbCxpbXg3
dWxwLXRwbSIgaW4gbmV4dCB2ZXJzb24uDQoNCj4gDQo+ID4gKy0gcmVnOiBQaHlzaWNhbCBiYXNl
IGFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgY29udHJvbGxlcidzIHJlZ2lzdGVycy4NCj4gPiAr
LSAjcHdtLWNlbGxzOiBTaG91bGQgYmUgMy4gU2VlIHB3bS50eHQgaW4gdGhpcyBkaXJlY3Rvcnkg
Zm9yIGEgZGVzY3JpcHRpb24NCj4gb2YgdGhlIGNlbGxzIGZvcm1hdC4NCj4gPiArLSBjbG9ja3Mg
OiBUaGUgY2xvY2sgcHJvdmlkZWQgYnkgdGhlIFNvQyB0byBkcml2ZSB0aGUgUFdNLg0KPiA+ICst
IGludGVycnVwdHM6IFRoZSBpbnRlcnJ1cHQgZm9yIHRoZSBQV00gY29udHJvbGxlci4NCj4gPiAr
DQo+ID4gK05vdGU6IFRoZSBUUE0gY291bnRlciBhbmQgcGVyaW9kIGNvdW50ZXIgYXJlIHNoYXJl
ZCBiZXR3ZWVuIG11bHRpcGxlDQo+ID4gK2NoYW5uZWxzLCBzbyBhbGwgY2hhbm5lbHMgc2hvdWxk
IHVzZSBzYW1lIHBlcmlvZCBzZXR0aW5nLg0KPiA+ICsNCj4gPiArRXhhbXBsZToNCj4gPiArDQo+
ID4gK3B3bTA6IHRwbUA0MDI1MDAwMCB7DQo+IA0KPiBwd21ALi4uDQoNCkkgZm9yZ290IHRvIHVw
ZGF0ZSB0aGUgZXhhbXBsZSBpbiBEVCBiaW5kaW5nLCBzb3JyeSBmb3IgdGhhdCwgd2lsbCB1cGRh
dGUgaXQgYWNjb3JkaW5nIHRvDQpiZWxvdyBkdHMgbm9kZToNCg0KICAgICAgICAgICAgICAgICBw
d20wOiBwd21ANDAyNTAwMDAgew0KDQpBbnNvbi4NCg==
