Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04488C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8ABC2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1EkRwQks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbfFTIOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:14:12 -0400
Received: from mail-eopbgr690043.outbound.protection.outlook.com ([40.107.69.43]:22862
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfFTIOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5s9j+QmbOasbgR8+aqoPraZvCb+NNKosgOJU7KsJYLE=;
 b=1EkRwQkskLmAnc0Mjf/CdGX9rNf9GyjzPt+bt/U1sMK6u4hzIkIf+nbIavK2KJih8jRVLrQKb+GlK0CjdUyn4Hnj8Li0cDcmsY7XK65bzlueXWb36AMQ9Frq3M1f0kbL+lPeuPwOL3G1qpoRROZ8WcSJ+4OdO9YgYSs5370ut/g=
Received: from MN2PR02MB6029.namprd02.prod.outlook.com (10.255.7.10) by
 MN2PR02MB5886.namprd02.prod.outlook.com (20.179.86.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 20 Jun 2019 08:14:02 +0000
Received: from MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::e55a:e2d1:953f:ed3b]) by MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::e55a:e2d1:953f:ed3b%4]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 08:14:02 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Michal Simek <michals@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Olof Johansson <olof@lixom.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
Thread-Topic: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP
 Platform Tap Delays Setup
Thread-Index: AQHVIDwWKZKZdF95gUaFGq/oqBvspKafu1mAgAADioCAAA8FAIAC5KtwgABVmICAARvKAA==
Date:   Thu, 20 Jun 2019 08:14:02 +0000
Message-ID: <MN2PR02MB602935234A2A779B5A05CD63C1E40@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
 <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com>
 <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
 <MN2PR02MB6029DB87CEE32655B0F1E794C1E50@MN2PR02MB6029.namprd02.prod.outlook.com>
 <CAPDyKFqb3uRU1XbrioSw6UZ5atZ8WwZNhQ_yq2+3JfxXZCxr7g@mail.gmail.com>
In-Reply-To: <CAPDyKFqb3uRU1XbrioSw6UZ5atZ8WwZNhQ_yq2+3JfxXZCxr7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e50c468d-1619-474f-cb56-08d6f5574169
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR02MB5886;
x-ms-traffictypediagnostic: MN2PR02MB5886:
x-microsoft-antispam-prvs: <MN2PR02MB5886996A1A802060B683F8A2C1E40@MN2PR02MB5886.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(366004)(396003)(51444003)(13464003)(189003)(199004)(8936002)(99286004)(6506007)(53546011)(76176011)(66066001)(229853002)(81156014)(81166006)(8676002)(2906002)(486006)(4326008)(71190400001)(26005)(53936002)(86362001)(102836004)(71200400001)(25786009)(478600001)(11346002)(316002)(446003)(186003)(74316002)(64756008)(66556008)(66476007)(66946007)(76116006)(66446008)(73956011)(7736002)(305945005)(14454004)(6246003)(256004)(5660300002)(476003)(55016002)(33656002)(6916009)(9686003)(6116002)(68736007)(72206003)(3846002)(6436002)(54906003)(7696005)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB5886;H:MN2PR02MB6029.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9xq48dJTl7+Rs7iHxnN6D79arCW+vHV+6fzSVflXJQQjauC1p90arUhPEVmzuu+mubxM1kR7nIwVz67M5mWkCTKxt5hA/bQGfO5a2Gk2YohaiqTcYwoDFWuLmjmWDsgC7IU+VkYtoU5xW+81fmEQoujG8mwbbt8VowPn3D+y0WE0FWzuc7VtTo90FTwFXdTbhE65h4uOvhGBNJohfkf1XyH4A52pB0gfKkafStgXiztIokZZ/5fab20F9Ith8g+e8gxLFlgTyrViAhuAFL97JxqMqxxqHvT0TXr+VoGGB6j6HLqMrSxz2GlUj0ZjTybRJpEE4i3ntaMbStjBTRJ/A4L3n7/6i4zy2Abskr+s3kZxnScQ2ogCeJUyk/Vh+35+zYi9XZ4z7M2xB+5iMOVD6JQQqiCiNUXaQB89EIzvZMc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50c468d-1619-474f-cb56-08d6f5574169
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 08:14:02.5367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnarani@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5886
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVWZmZSwNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVsZiBI
YW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUg
MTksIDIwMTkgNzowOSBQTQ0KPiBUbzogTWFuaXNoIE5hcmFuaSA8TU5BUkFOSUB4aWxpbnguY29t
Pg0KPiBDYzogTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+OyBSb2IgSGVycmluZyA8
cm9iaCtkdEBrZXJuZWwub3JnPjsNCj4gTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNv
bT47IEFkcmlhbiBIdW50ZXINCj4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgUmFqYW4gVmFq
YSA8UkFKQU5WQHhpbGlueC5jb20+OyBKb2xseSBTaGFoDQo+IDxKT0xMWVNAeGlsaW54LmNvbT47
IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YW1AeGlsaW54LmNvbT47IE9sb2YNCj4gSm9oYW5zc29u
IDxvbG9mQGxpeG9tLm5ldD47IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IERUTUwNCj4gPGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBBUk0gPGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIG1tYzog
c2RoY2ktb2YtYXJhc2FuOiBBZGQgc3VwcG9ydCBmb3IgWnlucU1QDQo+IFBsYXRmb3JtIFRhcCBE
ZWxheXMgU2V0dXANCj4gDQo+IE9uIFdlZCwgMTkgSnVuIDIwMTkgYXQgMTA6NDAsIE1hbmlzaCBO
YXJhbmkgPE1OQVJBTklAeGlsaW54LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBVZmZlLA0KPiA+
DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBVbGYg
SGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgSnVu
ZSAxNywgMjAxOSA1OjUxIFBNDQo+ID4gWy4uLl0NCj4gPiA+DQo+ID4gPiBUaGUgImNvbnN0IHN0
cnVjdCB6eW5xbXBfZWVtaV9vcHMgKmVlbWlfb3BzOyBzaG91bGQgdGhlbiBiZSBtb3ZlZCBpbnRv
DQo+ID4gPiBhIGNsb2NrIHByb3ZpZGVyIHNwZWNpZmljIHN0cnVjdCwgd2hpY2ggaXMgYXNzaWdu
ZWQgd2hlbiBjYWxsaW5nDQo+ID4gPiBzZGhjaV9hcmFzYW5fcmVnaXN0ZXJfc2RjbGsuIEkgdW5k
ZXJzdGFuZCB0aGF0IGFsbCB0aGUgY2xvY2sgZGF0YSBpcw0KPiA+ID4gZm9sZGVkIGludG8gc3Ry
dWN0IHNkaGNpX2FyYXNhbl9kYXRhIHRvZGF5LCBidXQgSSB0aGluayB0aGF0IHNob3VsZCBiZQ0K
PiA+ID4gbW92ZWQgaW50byBhICJzdWItc3RydWN0IiBmb3IgdGhlIGNsb2NrIHNwZWNpZmljcy4N
Cj4gPiA+DQo+ID4gPiBNb3Jlb3Zlciwgd2hlbiByZWdpc3RlcmluZyB0aGUgY2xvY2ssIHdlIHNo
b3VsZCBjb252ZXJ0IGZyb20gdXNpbmcNCj4gPiA+IGRldm1fY2xrX3JlZ2lzdGVyKCkgaW50byBk
ZXZtX2Nsa19od19yZWdpc3RlcigpIGFzIHRoZSBmaXJzdCBvbmUgaXMNCj4gPiA+IG5vdyBkZXBy
ZWNhdGVkLg0KPiA+DQo+ID4gSnVzdCBhIHF1ZXJ5IGhlcmU6DQo+ID4gV2hlbiB3ZSBzd2l0Y2gg
dG8gdXNpbmcgZGV2bV9jbGtfaHdfcmVnaXN0ZXIoKSBoZXJlLCBpdCB3aWxsIHJlZ2lzdGVyIHRo
ZQ0KPiBjbGtfaHcgYW5kIHJldHVybiBpbnQuDQo+ID4gSXMgdGhlcmUgYSB3YXkgd2UgY2FuIGdl
dCB0aGUgY2xrIChyZWxhdGVkIHRvIHRoZSBjbGtfaHcgcmVnaXN0ZXJlZCkgZnJvbSB0aGUNCj4g
PiBjbG9jayBmcmFtZXdvcms/DQo+ID4gSSBhbSBhc2tpbmcgdGhpcyBiZWNhdXNlIHdlIHdpbGwg
bmVlZCB0aGF0IGNsayBwb2ludGVyIHdoaWxlIGNhbGxpbmcNCj4gY2xrX3NldF9waGFzZSgpIGZ1
bmN0aW9uLg0KPiANCj4gSSBhc3N1bWUgZGV2bV9jbGtfZ2V0KCkgc2hvdWxkIHdvcmsgZmluZT8N
Cg0KVGhpcyBjbG9jayBkb2VzIG5vdCBjb21lIHRocm91Z2ggWnlucU1QIENsb2NrIGZyYW1ld29y
ay4gV2UgYXJlIGluaXRpYWxpemluZyBpdCBpbiB0aGlzICdzZGhjaS1vZi1hcmFzYW4nIGRyaXZl
ciBhbmQgZ2V0dGluZyBvbmx5IHRoZSBjbG9jayBuYW1lIGZyb20gImNsb2NrX291dHB1dF9uYW1l
cyIgcHJvcGVydHkuIFNvIEkgdGhpbmsgZGV2bV9jbGtfZ2V0KCkgd2lsbCBub3Qgd29yayBoZXJl
IGZvciBvdXIgY2FzZS4NCkkgaGF2ZSBnb25lIHRocm91Z2ggdGhlIGNsb2NrIGZyYW1ld29yayBh
bmQgSSBmb3VuZCBvbmUgZnVuY3Rpb24gd2hpY2ggbWF5IGJlIHVzZWQgdG8gY3JlYXRlIGNsb2Nr
IGZyb20gY2xvY2sgaHcsIHRoYXQgaXMgJyBjbGtfaHdfY3JlYXRlX2NsaygpJyB3aGljaCBjYW4g
YmUgdXNlZCBmcm9tIG91ciBkcml2ZXIsIGhvd2V2ZXIgdGhpcyBuZWVkcyBjaGFuZ2UgaW4gdGhl
IGNsb2NrIGZyYW1ld29yayBhcyBiZWxvdyA6DQoNCi0tLQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y2xrL2Nsay5jIGIvZHJpdmVycy9jbGsvY2xrLmMNCmluZGV4IGFhNTE3NTYuLjRkYzY5ZmYgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9jbGsuYw0KKysrIGIvZHJpdmVycy9jbGsvY2xrLmMNCkBA
IC0zNDIwLDYgKzM0MjAsNyBAQCBzdHJ1Y3QgY2xrICpjbGtfaHdfY3JlYXRlX2NsayhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHN0cnVjdCBjbGtfaHcgKmh3LA0KIA0KICAgICAgICByZXR1cm4gY2xrOw0K
IH0NCitFWFBPUlRfU1lNQk9MX0dQTChjbGtfaHdfY3JlYXRlX2Nsayk7DQogDQogc3RhdGljIGlu
dCBjbGtfY3B5X25hbWUoY29uc3QgY2hhciAqKmRzdF9wLCBjb25zdCBjaGFyICpzcmMsIGJvb2wg
bXVzdF9leGlzdCkNCiB7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLmggYi9kcml2ZXJz
L2Nsay9jbGsuaA0KaW5kZXggZDg0MDBkNi4uMjMxOTg5OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
Y2xrL2Nsay5oDQorKysgYi9kcml2ZXJzL2Nsay9jbGsuaA0KQEAgLTIyLDE3ICsyMiw5IEBAIHN0
YXRpYyBpbmxpbmUgc3RydWN0IGNsa19odyAqb2ZfY2xrX2dldF9odyhzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5wLA0KIHN0cnVjdCBjbGtfaHcgKmNsa19maW5kX2h3KGNvbnN0IGNoYXIgKmRldl9pZCwg
Y29uc3QgY2hhciAqY29uX2lkKTsNCiANCiAjaWZkZWYgQ09ORklHX0NPTU1PTl9DTEsNCi1zdHJ1
Y3QgY2xrICpjbGtfaHdfY3JlYXRlX2NsayhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBjbGtf
aHcgKmh3LA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqZGV2X2lk
LCBjb25zdCBjaGFyICpjb25faWQpOw0KIHZvaWQgX19jbGtfcHV0KHN0cnVjdCBjbGsgKmNsayk7
DQogI2Vsc2UNCiAvKiBBbGwgdGhlc2UgY2FzdHMgdG8gYXZvaWQgaWZkZWZzIGluIGNsa2Rldi4u
LiAqLw0KLXN0YXRpYyBpbmxpbmUgc3RydWN0IGNsayAqDQotY2xrX2h3X2NyZWF0ZV9jbGsoc3Ry
dWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgY2xrX2h3ICpodywgY29uc3QgY2hhciAqZGV2X2lkLA0K
LSAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqY29uX2lkKQ0KLXsNCi0gICAgICAgcmV0dXJu
IChzdHJ1Y3QgY2xrICopaHc7DQotfQ0KIHN0YXRpYyBzdHJ1Y3QgY2xrX2h3ICpfX2Nsa19nZXRf
aHcoc3RydWN0IGNsayAqY2xrKQ0KIHsNCiAgICAgICAgcmV0dXJuIChzdHJ1Y3QgY2xrX2h3ICop
Y2xrOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvY2xrLmggYi9pbmNsdWRlL2xpbnV4L2Ns
ay5oDQppbmRleCBmNjg5ZmM1Li5kM2Y2MGZlIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9j
bGsuaA0KKysrIGIvaW5jbHVkZS9saW51eC9jbGsuaA0KQEAgLTE4LDYgKzE4LDcgQEANCiANCiBz
dHJ1Y3QgZGV2aWNlOw0KIHN0cnVjdCBjbGs7DQorc3RydWN0IGNsa19odzsNCiBzdHJ1Y3QgZGV2
aWNlX25vZGU7DQogc3RydWN0IG9mX3BoYW5kbGVfYXJnczsNCiANCkBAIC05MzQsNCArOTM1LDE1
IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IGNsayAqb2ZfY2xrX2dldF9mcm9tX3Byb3ZpZGVyKHN0
cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmNsa3NwDQogfQ0KICNlbmRpZg0KIA0KKyNpZmRlZiBDT05G
SUdfQ09NTU9OX0NMSw0KK3N0cnVjdCBjbGsgKmNsa19od19jcmVhdGVfY2xrKHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IGNsa19odyAqaHcsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCBjaGFyICpkZXZfaWQsIGNvbnN0IGNoYXIgKmNvbl9pZCk7DQorI2Vsc2UNCitzdGF0
aWMgaW5saW5lIHN0cnVjdCBjbGsgKg0KK2Nsa19od19jcmVhdGVfY2xrKHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWN0IGNsa19odyAqaHcsIGNvbnN0IGNoYXIgKmRldl9pZCwNCisgICAgICAgICAg
ICAgICAgIGNvbnN0IGNoYXIgKmNvbl9pZCkNCit7DQorICAgICAgIHJldHVybiAoc3RydWN0IGNs
ayAqKWh3Ow0KK30NCisjZW5kaWYNCiAjZW5kaWYNCi0tLQ0KDQpUaGlzIGNoYW5nZSBzaG91bGQg
aGVscCBvdGhlciBkcml2ZXJzIChvdXRzaWRlICdkcml2ZXJzL2Nsay8nKSBhcyB3ZWxsIGZvciBn
ZXR0aW5nIHRoZSBjbG9jayBjcmVhdGVkIGZyb20gY2xrX2h3Lg0KSXMgdGhpcyBmaW5lIHRvIGRv
Pw0KDQpUaGFua3MsDQpNYW5pc2gNCg==
