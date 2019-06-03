Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C37C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F4726852
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="qvEmW388"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfFCIut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:50:49 -0400
Received: from mail-eopbgr1400091.outbound.protection.outlook.com ([40.107.140.91]:64832
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726055AbfFCIus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rZRHyp3jPSzd0GL9Ol7rWOVF7X9Mtj8KnP7Eo/m+xg=;
 b=qvEmW3889jSmNokzcmCfs9nuEBgwGjXD6eH0cFkNziddk88dnrgslmwcv1+b26HeOU9j/u3bjJq+9ctBvJ7Onlz9CFVmNKsR2C77rV5RYcbr94AxQY1E+2CtLVV1+VKOFBD14/XjkttgilEA435sKoSG8e8OwVkOzyTL7093trI=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.160.138) by
 TY1PR01MB1739.jpnprd01.prod.outlook.com (52.133.163.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Mon, 3 Jun 2019 08:50:05 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::14c:9d37:bcf0:1752]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::14c:9d37:bcf0:1752%3]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 08:50:05 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: clock: renesas,r9a06g032-sysctrl:
 Document power Domains
Thread-Topic: [PATCH v3 1/2] dt-bindings: clock: renesas,r9a06g032-sysctrl:
 Document power Domains
Thread-Index: AQHVEkXZL3OHYFrWsEu2221+eWtk7qaAKXeAgAl4K4CAAAlwAIAAARBQ
Date:   Mon, 3 Jun 2019 08:50:05 +0000
Message-ID: <TY1PR01MB17696938CCE90983748444E2F5140@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1558711904-27278-1-git-send-email-gareth.williams.jx@renesas.com>
 <1558711904-27278-2-git-send-email-gareth.williams.jx@renesas.com>
 <CAMuHMdV2jmY2u1-Z6cRR1OQcfW8U0HM_ac-xn1gO9nPf41iD+A@mail.gmail.com>
 <TY1PR01MB1769FB150E0258A8AC76CDB5F5140@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdXiBz6L83sBHXOg=zc0zo4ff37SbLOZc5NwgiTLVG-nTw@mail.gmail.com>
In-Reply-To: <CAMuHMdXiBz6L83sBHXOg=zc0zo4ff37SbLOZc5NwgiTLVG-nTw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70f36858-83cd-44a4-0e32-08d6e800797e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:TY1PR01MB1739;
x-ms-traffictypediagnostic: TY1PR01MB1739:
x-microsoft-antispam-prvs: <TY1PR01MB17396E7741872962F8EDABD1F5140@TY1PR01MB1739.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(73956011)(76176011)(66946007)(76116006)(5660300002)(66476007)(66556008)(74316002)(99286004)(26005)(53546011)(8936002)(6506007)(86362001)(229853002)(102836004)(316002)(25786009)(52536014)(446003)(11346002)(7696005)(486006)(81156014)(6246003)(44832011)(2906002)(6916009)(305945005)(81166006)(478600001)(14444005)(256004)(68736007)(66066001)(33656002)(9686003)(14454004)(4326008)(6436002)(53936002)(71190400001)(71200400001)(66446008)(3846002)(8676002)(6116002)(7736002)(54906003)(476003)(186003)(55016002)(64756008)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1739;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6DDFjwLNRKFMbeGseDKVujBeSkW4Xw469VG4Ol21co8Qrq8cVWoNzoBtGsJCwTo+Z/6gVA+LqZVF3LLFnfxXsDF5IpdwHtdt7ubZtJtEyNU7kyNHEc8eAUiHl6vnEz6XQzt7UFQ9vkxTwjU4rgsEMw9sl7EJHpgrX2Msnozt/Vg0QHwKzXzi5Lt8QPfUZJ2zwgMSEXSlpG84APnfQZAuT8aHBOwa61l0tYEdJmCAn+Y48uga9W8hbEkYdu8bnrMwQ9rpj8JNKLI3o/CCGDebqu5MDSfh21JY72gI5x5n8Ynffir2HU3QPjWl3l/NTqICyzSs/4KNial1dI4TGQJ1ZDDEXvQ2c3NOrb4XKtWh1+C3zpxLEsIXJUrq7hYXYPMJb78unigVUDdmVooZV+0FHvHXxrn5lCJzP5Orp1G/aW0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f36858-83cd-44a4-0e32-08d6e800797e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 08:50:05.3213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: phil.edworthy@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDAzIEp1bmUgMjAxOSAwOTozOSBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IE9uIE1vbiwgSnVuIDMsIDIwMTkgYXQgMTA6MjkgQU0gUGhpbCBFZHdvcnRoeSB3cm90
ZToNCj4gPiBPbiAyOCBNYXkgMjAxOSAwODoyOSBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+
ID4gPiBPbiBGcmksIE1heSAyNCwgMjAxOSBhdCA1OjMyIFBNIEdhcmV0aCBXaWxsaWFtcyB3cm90
ZToNCj4gPiA+ID4gVGhlIGRyaXZlciBpcyBnYWluaW5nIHBvd2VyIGRvbWFpbiBzdXBwb3J0LCBz
byBhZGQgdGhlIG5ldyBwcm9wZXJ0eSB0bw0KPiA+ID4gPiB0aGUgRFQgYmluZGluZyBhbmQgdXBk
YXRlIHRoZSBleGFtcGxlcy4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogR2FyZXRo
IFdpbGxpYW1zIDxnYXJldGgud2lsbGlhbXMuanhAcmVuZXNhcy5jb20+DQo+IA0KPiA+ID4gPiAt
LS0NCj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svcmVu
ZXNhcyxyOWEwNmcwMzItDQo+IHN5c2N0cmwudHh0DQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9yZW5lc2FzLHI5YTA2ZzAzMi0NCj4gc3lzY3Ry
bC50eHQNCj4gPiA+IEBAIC00MCw0ICs0Miw1IEBAIEV4YW1wbGVzDQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICByZWctaW8td2lkdGggPSA8ND47DQo+ID4gPiA+ICAgICAgICAgICAgICAgICBjbG9j
a3MgPSA8JnN5c2N0cmwgUjlBMDZHMDMyX0NMS19VQVJUMD47DQo+ID4gPiA+ICAgICAgICAgICAg
ICAgICBjbG9jay1uYW1lcyA9ICJiYXVkY2xrIjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHBv
d2VyLWRvbWFpbnMgPSA8JnN5c2N0cmw+Ow0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgYW4gaW50ZXJl
c3RpbmcgZXhhbXBsZTogYWNjb3JkaW5nIHRvIHRoZSBkcml2ZXIsDQo+ID4gPiBSOUEwNkcwMzJf
Q0xLX1VBUlQwLCBpcyBub3QgY2xvY2sgdXNlZCBmb3IgcG93ZXIgbWFuYWdlbWVudD8NCj4gPiA+
DQo+ID4gPiBPaCwgdGhlIHJlYWwgdWFydDAgbm9kZSBpbiBhcmNoL2FybS9ib290L2R0cy9yOWEw
NmcwMzIuZHRzaSB1c2VzDQo+ID4gPg0KPiA+ID4gICAgIGNsb2NrcyA9IDwmc3lzY3RybCBSOUEw
NkcwMzJfQ0xLX1VBUlQwPiwgPCZzeXNjdHJsDQo+ID4gPiBSOUEwNkcwMzJfSENMS19VQVJUMD47
DQo+ID4gPiAgICAgY2xvY2stbmFtZXMgPSAiYmF1ZGNsayIsICJhcGJfcGNsayI7DQo+ID4gPg0K
PiA+ID4gVGhhdCBkb2VzIG1ha2Ugc2Vuc2UuLi4NCj4gPiBOb3RlIHRoYXQgdGhlIFN5bm9wc3lz
IERXIHVhcnQgZHJpdmVyIGFscmVhZHkgZ2V0cyB0aGUgImFwYl9wY2xrIiBjbG9jaywNCj4gc28N
Cj4gPiB3ZSBkb27igJl0IGFjdHVhbGx5IG5lZWQgdG8gdXNlIGNsb2NrIGRvbWFpbnMgdG8gZW5h
YmxlIHRoaXMgY2xvY2suDQo+IA0KPiBUaGF0IGlzIG5vdCBuZWNlc3NhcmlseSBhIHByb2JsZW06
DQo+ICAgMSkgRFQgZGVzY3JpYmVzIGhhcmR3YXJlLCBub3Qgc29mdHdhcmUgcG9saWN5LA0KPiAg
IDIpIEl0IGRvZXNuJ3QgaHVydCB0byBlbmFibGUgYSBjbG9jayB0d2ljZS4NClllcywgdGhhdCB3
YXMgbXkgdGFrZSBhcyB3ZWxsLg0KDQo+IFRoZXJlIGFyZSBzdGlsbCBzb21lIFItQ2FyIGRyaXZl
cnMgdGhhdCBtYW5hZ2UgY2xvY2tzIHRoZW1zZWx2ZXMsIGJ1dA0KPiB3ZSdyZSBzbG93bHkgbWln
cmF0aW5nIGF3YXkgZnJvbSB0aGF0LCB3aGVyZSBwb3NzaWJsZS4gSWYgdGhlIGRyaXZlcg0KPiBp
cyBlLmcuIHNoYXJlZCB3aXRoIGEgcGxhdGZvcm0gd2l0aG91dCBjbG9jayBkb21haW5zLCB3ZSBv
YnZpb3VzbHkgY2Fubm90DQo+IGRvIHRoYXQuDQo+IA0KPiBTbyB5b3UgY2FuIHRha2Ugb3V0IHRo
YXQgY29kZSBhZ2FpbiwgdGhhdCdzIHVwIHRvIHlvdS4NCkkgdGhpbmsgbGVhdmluZyBpdCBhcyBp
cyBiZXN0Lg0KDQo+ID4gVGhpcyBpcyBhbHNvIHRydWUgZm9yIG1hbnkgb2YgdGhlIHBlcmlwaGVy
YWwgZHJpdmVycyB1c2VkIG9uIHJ6bjEgKFN5bm9wc3lzDQo+ID4gZ3BpbyBjb250cm9sbGVyLCBp
MmMgY29udHJvbGxlciwgZ21hYywgZG1hYywgQXJhc2FuIHNkaW8gY29udHJvbGxlcikuIFRoZQ0K
PiA+IGNvbW1pdCB0byBhZGQgdGhpcyBjbG9jayB0byB0aGUgaTJjIGNvbnRyb2xsZXIgZHJpdmVy
IGlzIG15IGZhdWx0LCBhcyBJIHdhcw0KPiA+IGZvbGxvd2luZyB0aGUgcGF0dGVybiBvZiB0aGUg
b3RoZXJzLg0KPiA+DQo+ID4gT2YgdGhlIGZldyBkcml2ZXJzIHRoYXQgZG9uJ3QgYWxyZWFkeSBn
ZXQgdGhlIGhjbGsvcGNsayB1c2VkIHRvIGFjY2VzcyB0aGUNCj4gPiBwZXJpcGhlcmFscyBpcyB0
aGUgU3lub3BzeXMgc3BpIGNvbnRyb2xsZXIgKHRob3VnaCB0aGF0IGN1cnJlbnRseSBkb2VzbuKA
mXQNCj4gPiBzdXBwb3J0IHJ1bnRpbWUgUE0pIGFuZCB0aGUgVVNCIEhvc3QgY29udHJvbGxlci4N
Cj4gDQo+IEdvb2QsIHNvIHRoZSBsYXR0ZXIgd2lsbCBzdGFydCB3b3JraW5nIG1hZ2ljYWxseSwg
SSBhc3N1bWU/IDstKQ0KWWVzLCBleGNlcHQgZm9yIHRoZSB1c2IgUExMLiBUaGUgcnpuMSBoYXMg
YSBtb2RlIGJpdCB0aGF0IHN3aXRjaGVzIFVTQg0KYmV0d2VlbiAyeEhvc3QgYW5kIDF4SG9zdCAr
IDF4RnVuYywgaG93ZXZlciB0aGUgUExMIG11c3QgYmUgc3RhcnRlZCBhZnRlcg0KdGhlIG1vZGUg
Yml0IGhhcyBiZWVuIHNldC4gVGhhdCBzdGlsbCBuZWVkcyB0byBiZSBpbXBsZW1lbnRlZC4uLg0K
DQpCUg0KUGhpbA0KIA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUn
cyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0K
PiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkg
Y2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxp
c3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
