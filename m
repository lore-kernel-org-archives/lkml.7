Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB9DC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37D8206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RDPUPxTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfEEGGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 02:06:52 -0400
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:49221
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfEEGGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 02:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDtSUgeM8n2L5uBJkOfR4Osl2EvVfbDOoWS1qBvKQrs=;
 b=RDPUPxTpf7NvVcEspnQgEAZ6saVpQznaCjNJhRRxOY+sS3WTuxvjKGvEK4JEDNZQwMgtO7DgI1nWWpPw0GjGzleRgtJV/AGNpWLJaJmAGXKxndMyYnUZhxVQ5nqBmmiJ6HQzGtWFoT2BLqOK54JFze6aV2n5X7VWA+/cDN1EC1g=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB5117.eurprd04.prod.outlook.com (20.177.50.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Sun, 5 May 2019 06:06:46 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566%5]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 06:06:46 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: RE: [EXT] Re: [PATCH v1] arm64: ls1028: dtsi: Add esdhc node in dtsi
Thread-Topic: [EXT] Re: [PATCH v1] arm64: ls1028: dtsi: Add esdhc node in dtsi
Thread-Index: AQHU+cmuEJQ1seVcO0uOXKGj5Q3IF6ZWmSeAgAWDyjA=
Date:   Sun, 5 May 2019 06:06:46 +0000
Message-ID: <VI1PR04MB415896DA3F0AF8BA6AB149C9E9370@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190423114424.3578-1-yinbo.zhu@nxp.com>
 <CAL_Jsq+4g+inxc+qcC3oLrXuR+L9AMvXFShGaU5Y3iRDsK3P6A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+4g+inxc+qcC3oLrXuR+L9AMvXFShGaU5Y3iRDsK3P6A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32c5e08f-1d91-491f-dcca-08d6d11fdb01
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5117;
x-ms-traffictypediagnostic: VI1PR04MB5117:
x-microsoft-antispam-prvs: <VI1PR04MB5117CCAD848D10FB723A9457E9370@VI1PR04MB5117.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(13464003)(199004)(189003)(71190400001)(86362001)(71200400001)(102836004)(66476007)(6246003)(6506007)(6436002)(14454004)(478600001)(54906003)(14444005)(7696005)(33656002)(76176011)(68736007)(256004)(316002)(25786009)(99286004)(4326008)(66066001)(2906002)(55016002)(486006)(9686003)(66446008)(64756008)(66556008)(74316002)(446003)(11346002)(8936002)(53546011)(53936002)(8676002)(44832011)(81156014)(81166006)(229853002)(76116006)(5660300002)(52536014)(3846002)(6116002)(26005)(186003)(66946007)(7736002)(476003)(73956011)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5117;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OL4vnRjTgQ1K5JOWndfkQwWOMExt/CQ7r9A+od5SLz9lvMLaJECTYe+DbMFNO6GVT8CSC2Y+aQQRPfuviSK+dCE0jM+GMuXm+nPeV7byDsjhpX2ReLUu4warkbDRNcHzxg698188e8IB8ju6qEj4Iw0HEuM+MqNRqIEfYp/9JOMKjJG2kzKVI+RYrR2rr059mUtG9dwrnxpaIS8xEds+Eq2JXHGPWAV1v8j6oalpHce9HHzR3GHZsu1QprI485C6sicVuVAwsCjDvoXiEtjF6a8ko1gRjQatuWvB4BL8p0ZrFQ9DzaBxtAWkC7ylUrDRmJdv7ULd5Rl6G7cTC70wYpBuUPr93pI1wClwCi5wSOuOBwWIweamkjO/LuWDzJJTcv3VWBSsrqhK3khplDUDzauAJ4Naf9g4NP8gBnQ9+2o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c5e08f-1d91-491f-dcca-08d6d11fdb01
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 06:06:46.7006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgW21h
aWx0bzpyb2JoK2R0QGtlcm5lbC5vcmddDQo+IFNlbnQ6IDIwMTnlubQ15pyIMuaXpSAxOjUwDQo+
IFRvOiBZaW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPg0KPiBDYzogU2hhd24gR3VvIDxzaGF3
bmd1b0BrZXJuZWwub3JnPjsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBYaWFvYm8NCj4g
WGllIDx4aWFvYm8ueGllQG54cC5jb20+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0u
Y29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
bW1jQHZnZXIua2VybmVsLm9yZzsgWS5iLiBMdQ0KPiA8eWFuZ2JvLmx1QG54cC5jb20+OyBKaWFm
ZWkgUGFuIDxqaWFmZWkucGFuQG54cC5jb20+OyBBc2hpc2ggS3VtYXINCj4gPGFzaGlzaC5rdW1h
ckBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYxXSBhcm02NDogbHMxMDI4
OiBkdHNpOiBBZGQgZXNkaGMgbm9kZSBpbiBkdHNpDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwN
Cj4gDQo+IE9uIFR1ZSwgQXByIDIzLCAyMDE5IGF0IDY6NDIgQU0gWWluYm8gWmh1IDx5aW5iby56
aHVAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBBc2hpc2ggS3VtYXIgPEFzaGlzaC5L
dW1hckBueHAuY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBpcyB0byBhZGQgZXNkaGMgbm9kZSBh
bmQgZW5hYmxlIFNEIFVIUy1JLCBlTU1DIEhTMjAwIGZvcg0KPiA+IGxzMTAyOGFyZGIvbHMxMDI4
YXFkcyBib2FyZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFzaGlzaCBLdW1hciA8QXNoaXNo
Lkt1bWFyQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWFuZ2JvIEx1IDx5YW5nYm8ubHVA
bnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZaW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29t
Pg0KPiA+IC0tLQ0KPiA+ICAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXFkcy5k
dHMgICAgfCAgOCArKysrKysNCj4gPiAgLi4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4
YS1yZGIuZHRzICAgIHwgMTMgKysrKysrKysrDQo+ID4gIC4uLi9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWxzMTAyOGEuZHRzaSB8IDI3DQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAzIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzDQo+ID4g
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzDQo+ID4g
aW5kZXggMTRjNzlmNDY5MWVhLi4xODBlNWQyYTAwZDEgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcWRzLmR0cw0KPiA+ICsrKyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMNCj4gPiBAQCAt
NDIsNiArNDIsMTQgQEANCj4gPiAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPiAgfTsNCj4g
Pg0KPiA+ICsmZXNkaGMgew0KPiA+ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0K
PiA+ICsNCj4gPiArJmVzZGhjMSB7DQo+ID4gKyAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4g
K307DQo+ID4gKw0KPiA+ICAmaTJjMCB7DQo+ID4gICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxz
MTAyOGEtcmRiLmR0cw0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxz
MTAyOGEtcmRiLmR0cw0KPiA+IGluZGV4IGY4NmIwNTRhNzRhZS4uMWJmYWY0Mjk0ZGI0IDEwMDY0
NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXJk
Yi5kdHMNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4
YS1yZGIuZHRzDQo+ID4gQEAgLTMwLDYgKzMwLDE5IEBADQo+ID4gICAgICAgICB9Ow0KPiA+ICB9
Ow0KPiA+DQo+ID4gKyZlc2RoYyB7DQo+ID4gKyAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4g
KyAgICAgICBzZC11aHMtc2RyMTA0Ow0KPiA+ICsgICAgICAgc2QtdWhzLXNkcjUwOw0KPiA+ICsg
ICAgICAgc2QtdWhzLXNkcjI1Ow0KPiA+ICsgICAgICAgc2QtdWhzLXNkcjEyOw0KPiA+ICsgICAg
ICAgfTsNCj4gPiArDQo+ID4gKyZlc2RoYzEgew0KPiA+ICsgICAgICAgc3RhdHVzID0gIm9rYXki
Ow0KPiA+ICsgICAgICAgbW1jLWhzMjAwLTFfOHY7DQo+ID4gKyAgICAgICB9Ow0KPiA+ICsNCj4g
PiAgJmkyYzAgew0KPiA+ICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kNCj4g
PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kNCj4gPiBp
bmRleCAyODk2YmJjZmEzYmIuLmQxM2NkM2ZiNDU1YiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpDQo+ID4gKysrIGIvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0KPiA+IEBAIC0yNzQsNiAr
Mjc0LDMzIEBADQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVk
IjsNCj4gPiAgICAgICAgICAgICAgICAgfTsNCj4gPg0KPiA+ICsgICAgICAgICAgICAgICBlc2Ro
YzogZXNkaGNAMjE0MDAwMCB7DQo+IA0KPiBtbWNALi4uDQo+IA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGxzMTAyOGEtZXNkaGMiLCAiZnNsLGVzZGhjIjsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4MjE0MDAwMCAweDAgMHgx
MDAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwwIDI4IDB4
ND47IC8qIExldmVsIGhpZ2ggdHlwZSAqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNs
b2NrLWZyZXF1ZW5jeSA9IDwwPjsNCj4gDQo+IEZpbGxlZCBpbiBieSBib290bG9hZGVyPyBJZiBz
bywgYWRkIGEgY29tbWVudC4NCkhpIHJvYiwNCkZpbGxlZCBpbiBieSBrZXJuZWwsIHBsZWFzZSB5
b3Ugbm90ZS4NCg0KUmVnYXJkcywNCllpbmJvLg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGNsb2NrcyA9IDwmY2xvY2tnZW4gMiAxPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB2
b2x0YWdlLXJhbmdlcyA9IDwxODAwIDE4MDAgMzMwMCAzMzAwPjsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBzZGhjaSxhdXRvLWNtZDEyOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGxpdHRsZS1lbmRpYW47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYnVzLXdpZHRoID0g
PDQ+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+
ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBlc2RoYzE6
IGVzZGhjQDIxNTAwMDAgew0KPiANCj4gbW1jQC4uLg0KPiANCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBjb21wYXRpYmxlID0gImZzbCxsczEwMjhhLWVzZGhjIiwgImZzbCxlc2RoYyI7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MCAweDIxNTAwMDAgMHgwIDB4MTAw
MDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8MCA2MyAweDQ+
OyAvKiBMZXZlbCBoaWdoIHR5cGUgKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBjbG9j
ay1mcmVxdWVuY3kgPSA8MD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0g
PCZjbG9ja2dlbiAyIDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHZvbHRhZ2UtcmFu
Z2VzID0gPDE4MDAgMTgwMCAzMzAwIDMzMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IHNkaGNpLGF1dG8tY21kMTI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJva2VuLWNk
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGxpdHRsZS1lbmRpYW47DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgYnVzLXdpZHRoID0gPDQ+Ow0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4g
Kw0KPiA+ICAgICAgICAgICAgICAgICBzYXRhOiBzYXRhQDMyMDAwMDAgew0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGxzMTAyOGEtYWhjaSI7DQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MCAweDMyMDAwMDAgMHgwIDB4MTAwMDA+LA0K
PiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==
