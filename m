Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B2DC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA50217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="hZ9X2zfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfEJKvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 06:51:03 -0400
Received: from mail-eopbgr800050.outbound.protection.outlook.com ([40.107.80.50]:27824
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbfEJKvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 06:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8fT2x+6pypIkKAJnbqWrIJr08X+X5oHp6knLpySV3s=;
 b=hZ9X2zfw3NGgOxb6cFbkGj96bPKTOT5j8sNPeBCwjJQhwzrbgXytkFsOPqh0FqH/iMUzVqVi2T7oOwlCGPmVIcU7tBnkCBImoy0//PDdbA2wv9dvH1roVNKihOrwJwSI7o4CLKLBKs13wc9jiYLw9BBUSzxzumYQ9a/wd/8YHrA=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6431.namprd05.prod.outlook.com (20.178.247.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.18; Fri, 10 May 2019 10:50:57 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::60b8:98a9:5fab:36ee]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::60b8:98a9:5fab:36ee%4]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 10:50:57 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "tobin@kernel.org" <tobin@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] docs: Move kref.txt to core-api/kref.rst
Thread-Topic: [PATCH] docs: Move kref.txt to core-api/kref.rst
Thread-Index: AQHVBsXqHSAMgK8dWUqaz4yoOLeFEaZkLvEA
Date:   Fri, 10 May 2019 10:50:57 +0000
Message-ID: <a3db1384695bbaa051d93c18ac30175fb95165e3.camel@vmware.com>
References: <20190510001747.8767-1-tobin@kernel.org>
In-Reply-To: <20190510001747.8767-1-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5d95c6d-59db-441e-b827-08d6d5356203
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6431;
x-ms-traffictypediagnostic: MN2PR05MB6431:
x-microsoft-antispam-prvs: <MN2PR05MB643184A4741D6DBBD7284F9CA10C0@MN2PR05MB6431.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(39860400002)(376002)(396003)(189003)(199004)(8676002)(7736002)(81166006)(6506007)(2906002)(66446008)(66476007)(81156014)(66556008)(64756008)(316002)(25786009)(6116002)(73956011)(66946007)(186003)(91956017)(3846002)(118296001)(76116006)(36756003)(256004)(110136005)(305945005)(486006)(54906003)(14444005)(5660300002)(8936002)(4326008)(476003)(6512007)(2616005)(11346002)(71190400001)(446003)(26005)(71200400001)(86362001)(76176011)(6246003)(6486002)(66066001)(14454004)(102836004)(2501003)(478600001)(99286004)(6436002)(68736007)(53936002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6431;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: go4M1wVH6UiwhF9XG+dRl93OlZzpRIoH5LxFKNUoEZdtNLLeh3VN4Kr2jPRhrNJhBp7T4xo5Eqswei55RznJlXl+Jy8wENhkG5fIi2AKqXsOBkjmsgN6Mk6M6xtTKIW9+CXPQwQmOAT9MFjEVqC16SIU9XlAbAbN50aqhg4unxsXpq9HG+2pvM4XdLk5Tv0UTQGYtxx8c1IAgCD4ijvwcN1DflE9Xo8HMQWBhJGU4hJb3YKC6iBqSJxNTbpkqL+QGyDSe9ENpOIWhRaYJj70IY8sp032ub1x08fdiNCfTH0HN0V2kpNd8LGPRCrOlXbLc9Y2YfhMO4Vq8eQNGK3mivRslrZ4pi1Cnf9rVkSKJ1LXGUYBcV7/+krymapiLD+e1rz+YZn2/Y4ujyA9Y8I6aIzeKE6xwjgrNLtQQXx8HVo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ED99C4FFDFF174889E96C841102BEE1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d95c6d-59db-441e-b827-08d6d5356203
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 10:50:57.2858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6431
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA1LTEwIGF0IDEwOjE3ICsxMDAwLCBUb2JpbiBDLiBIYXJkaW5nIHdyb3Rl
Og0KPiBrcmVmLnR4dCBpcyBhbHJlYWR5IHdyaXR0ZW4gdXNpbmcgY29ycmVjdCBSZVN0cnVjdHVy
ZWRUZXh0DQo+IGZvcm1hdC4gIFRoaXMNCj4gY2FuIGJlIHZlcmlmaWVkIGFzIGZvbGxvd3MNCj4g
DQo+IAltYWtlIGNsZWFuZG9jcw0KPiAJbWFrZSBodG1sZG9jcyAyPiBwcmUuc3RkZXJyDQo+IAlt
diBEb2N1bWVudGF0aW9uL2tyZWYudHh0IERvY3VtZW50YXRpb24vY29yZS1hcGkva3JlZi5yc3QN
Cj4gCS8vIEFkZCAna3JlZicgdG8gY29yZS1hcGkvaW5kZXgucnN0DQo+IAltYWtlIGNsZWFuZG9j
cw0KPiAJbWFrZSBodG1sZG9jcyAyPiBwb3N0LnN0ZGVycg0KPiAJZGlmZiBwcmUuc3RkZXJyIHBv
c3Quc3RkZXJyDQo+IA0KPiBXaGlsZSBkb2luZyB0aGUgZmlsZSBtb3ZlLCBmaXggdGhlIGNvbHVt
biB3aWR0aCB0byBiZSA3MiBjaGFyYWN0ZXJzDQo+IHdpZGUNCj4gYXMgaXQgaXMgdGhyb3VnaG91
dCB0aGUgZG9jdW1lbnQuICBUaGlzIGlzIHdoaXRlc3BhY2Ugb25seS4gIGtyZWYudHh0DQo+IGlz
DQo+IHNvIGNsZWFubHkgd3JpdHRlbiBpdHMgYSBzaGFtZSB0byBoYXZlIHRoZXNlIGZldyBleHRy
YSB3aWRlDQo+IHBhcmFncmFwaHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUb2JpbiBDLiBIYXJk
aW5nIDx0b2JpbkBrZXJuZWwub3JnPg0KPiAtLS0NCj4gDQo+IEknbSBhbHdheXMgaGVzaXRhbnQg
dG8gZG8gZG9jcyBwYXRjaGVzIHRoYXQgc2VlbSBvYnZpb3VzIC0gaXMgdGhlcmUNCj4gc29tZSBy
ZWFzb24gdGhhdCB0aGlzIHdhcyBub3QgZG9uZSBwcmV2aW91c2x5Pw0KDQpTcGVha2luZyBmb3Ig
dGhlIHR3byBrcmVmLnR4dCBwYXJhZ3JhcGhzLCB0aGUgd2lkdGggYmVpbmcgdG9vIGxhcmdlIGlz
DQpzaW1wbHkgYW4gb3ZlcnNpZ2h0IGZyb20gbXkgc2lkZS4gSSB3YXNuJ3QgYXdhcmUgb2YgdGhl
IHJlc3RyaWN0aW9uLg0KDQoNClJldmlld2VkLWJ5OiBUaG9tYXMgSGVsbHN0cm9tIDx0aGVsbHN0
cm9tQHZtd2FyZS5jb20+DQoNCj4gDQo+IEkgZGlkIHRoaXMgb25lIGluIHByZXBhcmF0aW9uIGZv
ciBjb252ZXJ0aW5nIGtvYmplY3QudHh0LCBteSBpbnRlbnQNCj4gaXMNCj4gdG8gcHV0IGtib2pl
Y3QucnN0IGluIGNvcmUtYXBpLyBhbHNvPw0KPiANCj4gSSBjYW4gc3BsaXQgdGhlIHdoaXRlc3Bh
Y2UgY2hhbmdlIGFuZCB0aGUgZmlsZSByZW5hbWUgaW50byBzZXBhcmF0ZQ0KPiBwYXRjaGVzIGlm
IHlvdSdkIHByZWZlci4NCj4gDQo+IHRoYW5rcywNCj4gVG9iaW4uDQo+IA0KPiAgRG9jdW1lbnRh
dGlvbi9jb3JlLWFwaS9pbmRleC5yc3QgICAgICAgICAgICAgIHwgIDEgKw0KPiAgRG9jdW1lbnRh
dGlvbi97a3JlZi50eHQgPT4gY29yZS1hcGkva3JlZi5yc3R9IHwgMjQgKysrKysrKysrLS0tLS0t
DQo+IC0tLS0NCj4gIERvY3VtZW50YXRpb24va29iamVjdC50eHQgICAgICAgICAgICAgICAgICAg
ICB8ICA0ICsrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTIgZGVs
ZXRpb25zKC0pDQo+ICByZW5hbWUgRG9jdW1lbnRhdGlvbi97a3JlZi50eHQgPT4gY29yZS1hcGkv
a3JlZi5yc3R9ICg5MyUpDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9jb3JlLWFw
aS9pbmRleC5yc3QgYi9Eb2N1bWVudGF0aW9uL2NvcmUtDQo+IGFwaS9pbmRleC5yc3QNCj4gaW5k
ZXggZWUxYmI4OTgzYTg4Li4xYzk1ZjBjZGQyMzkgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRp
b24vY29yZS1hcGkvaW5kZXgucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vY29yZS1hcGkvaW5k
ZXgucnN0DQo+IEBAIC0zNCw2ICszNCw3IEBAIENvcmUgdXRpbGl0aWVzDQo+ICAgICB0aW1la2Vl
cGluZw0KPiAgICAgYm9vdC10aW1lLW1tDQo+ICAgICBtZW1vcnktaG90cGx1Zw0KPiArICAga3Jl
Zg0KPiAgDQo+ICANCj4gIEludGVyZmFjZXMgZm9yIGtlcm5lbCBkZWJ1Z2dpbmcNCj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24va3JlZi50eHQgYi9Eb2N1bWVudGF0aW9uL2NvcmUtYXBpL2ty
ZWYucnN0DQo+IHNpbWlsYXJpdHkgaW5kZXggOTMlDQo+IHJlbmFtZSBmcm9tIERvY3VtZW50YXRp
b24va3JlZi50eHQNCj4gcmVuYW1lIHRvIERvY3VtZW50YXRpb24vY29yZS1hcGkva3JlZi5yc3QN
Cj4gaW5kZXggM2FmMzg0MTU2ZDdlLi5hMjE3NGRkMDllYjIgMTAwNjQ0DQo+IC0tLSBhL0RvY3Vt
ZW50YXRpb24va3JlZi50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9rcmVmLnJz
dA0KPiBAQCAtMjMwLDggKzIzMCw4IEBAIG9mIHRoZSBmcmVlIG9wZXJhdGlvbnMgdGhhdCBjb3Vs
ZCB0YWtlIGEgbG9uZw0KPiB0aW1lIG9yIG1pZ2h0IGNsYWltIHRoZQ0KPiAgc2FtZSBsb2NrLiAg
Tm90ZSB0aGF0IGRvaW5nIGV2ZXJ5dGhpbmcgaW4gdGhlIHJlbGVhc2Ugcm91dGluZSBpcw0KPiBz
dGlsbA0KPiAgcHJlZmVycmVkIGFzIGl0IGlzIGEgbGl0dGxlIG5lYXRlci4NCj4gIA0KPiAtVGhl
IGFib3ZlIGV4YW1wbGUgY291bGQgYWxzbyBiZSBvcHRpbWl6ZWQgdXNpbmcNCj4ga3JlZl9nZXRf
dW5sZXNzX3plcm8oKSBpbg0KPiAtdGhlIGZvbGxvd2luZyB3YXk6Og0KPiArVGhlIGFib3ZlIGV4
YW1wbGUgY291bGQgYWxzbyBiZSBvcHRpbWl6ZWQgdXNpbmcNCj4ga3JlZl9nZXRfdW5sZXNzX3pl
cm8oKQ0KPiAraW4gdGhlIGZvbGxvd2luZyB3YXk6Og0KPiAgDQo+ICAJc3RhdGljIHN0cnVjdCBt
eV9kYXRhICpnZXRfZW50cnkoKQ0KPiAgCXsNCj4gQEAgLTI2MSwxMSArMjYxLDExIEBAIHRoZSBm
b2xsb3dpbmcgd2F5OjoNCj4gIAkJa3JlZl9wdXQoJmVudHJ5LT5yZWZjb3VudCwgcmVsZWFzZV9l
bnRyeSk7DQo+ICAJfQ0KPiAgDQo+IC1XaGljaCBpcyB1c2VmdWwgdG8gcmVtb3ZlIHRoZSBtdXRl
eCBsb2NrIGFyb3VuZCBrcmVmX3B1dCgpIGluDQo+IHB1dF9lbnRyeSgpLCBidXQNCj4gLWl0J3Mg
aW1wb3J0YW50IHRoYXQga3JlZl9nZXRfdW5sZXNzX3plcm8gaXMgZW5jbG9zZWQgaW4gdGhlIHNh
bWUNCj4gY3JpdGljYWwNCj4gLXNlY3Rpb24gdGhhdCBmaW5kcyB0aGUgZW50cnkgaW4gdGhlIGxv
b2t1cCB0YWJsZSwNCj4gLW90aGVyd2lzZSBrcmVmX2dldF91bmxlc3NfemVybyBtYXkgcmVmZXJl
bmNlIGFscmVhZHkgZnJlZWQgbWVtb3J5Lg0KPiAtTm90ZSB0aGF0IGl0IGlzIGlsbGVnYWwgdG8g
dXNlIGtyZWZfZ2V0X3VubGVzc196ZXJvIHdpdGhvdXQgY2hlY2tpbmcNCj4gaXRzDQo+ICtXaGlj
aCBpcyB1c2VmdWwgdG8gcmVtb3ZlIHRoZSBtdXRleCBsb2NrIGFyb3VuZCBrcmVmX3B1dCgpIGlu
DQo+ICtwdXRfZW50cnkoKSwgYnV0IGl0J3MgaW1wb3J0YW50IHRoYXQga3JlZl9nZXRfdW5sZXNz
X3plcm8gaXMNCj4gZW5jbG9zZWQgaW4NCj4gK3RoZSBzYW1lIGNyaXRpY2FsIHNlY3Rpb24gdGhh
dCBmaW5kcyB0aGUgZW50cnkgaW4gdGhlIGxvb2t1cCB0YWJsZSwNCj4gK290aGVyd2lzZSBrcmVm
X2dldF91bmxlc3NfemVybyBtYXkgcmVmZXJlbmNlIGFscmVhZHkgZnJlZWQNCj4gbWVtb3J5LiAg
Tm90ZQ0KPiArdGhhdCBpdCBpcyBpbGxlZ2FsIHRvIHVzZSBrcmVmX2dldF91bmxlc3NfemVybyB3
aXRob3V0IGNoZWNraW5nIGl0cw0KPiAgcmV0dXJuIHZhbHVlLiBJZiB5b3UgYXJlIHN1cmUgKGJ5
IGFscmVhZHkgaGF2aW5nIGEgdmFsaWQgcG9pbnRlcikNCj4gdGhhdA0KPiAga3JlZl9nZXRfdW5s
ZXNzX3plcm8oKSB3aWxsIHJldHVybiB0cnVlLCB0aGVuIHVzZSBrcmVmX2dldCgpDQo+IGluc3Rl
YWQuDQo+ICANCj4gQEAgLTMxMiw4ICszMTIsOCBAQCBsb2NraW5nIGZvciBsb29rdXBzIGluIHRo
ZSBhYm92ZSBleGFtcGxlOjoNCj4gIAkJa3JlZl9wdXQoJmVudHJ5LT5yZWZjb3VudCwgcmVsZWFz
ZV9lbnRyeV9yY3UpOw0KPiAgCX0NCj4gIA0KPiAtQnV0IG5vdGUgdGhhdCB0aGUgc3RydWN0IGty
ZWYgbWVtYmVyIG5lZWRzIHRvIHJlbWFpbiBpbiB2YWxpZCBtZW1vcnkNCj4gZm9yIGENCj4gLXJj
dSBncmFjZSBwZXJpb2QgYWZ0ZXIgcmVsZWFzZV9lbnRyeV9yY3Ugd2FzIGNhbGxlZC4gVGhhdCBj
YW4gYmUNCj4gYWNjb21wbGlzaGVkDQo+IC1ieSB1c2luZyBrZnJlZV9yY3UoZW50cnksIHJoZWFk
KSBhcyBkb25lIGFib3ZlLCBvciBieSBjYWxsaW5nDQo+IHN5bmNocm9uaXplX3JjdSgpDQo+IC1i
ZWZvcmUgdXNpbmcga2ZyZWUsIGJ1dCBub3RlIHRoYXQgc3luY2hyb25pemVfcmN1KCkgbWF5IHNs
ZWVwIGZvciBhDQo+IC1zdWJzdGFudGlhbCBhbW91bnQgb2YgdGltZS4NCj4gK0J1dCBub3RlIHRo
YXQgdGhlIHN0cnVjdCBrcmVmIG1lbWJlciBuZWVkcyB0byByZW1haW4gaW4gdmFsaWQgbWVtb3J5
DQo+IGZvcg0KPiArYSByY3UgZ3JhY2UgcGVyaW9kIGFmdGVyIHJlbGVhc2VfZW50cnlfcmN1IHdh
cyBjYWxsZWQuIFRoYXQgY2FuIGJlDQo+ICthY2NvbXBsaXNoZWQgYnkgdXNpbmcga2ZyZWVfcmN1
KGVudHJ5LCByaGVhZCkgYXMgZG9uZSBhYm92ZSwgb3IgYnkNCj4gK2NhbGxpbmcgc3luY2hyb25p
emVfcmN1KCkgYmVmb3JlIHVzaW5nIGtmcmVlLCBidXQgbm90ZSB0aGF0DQo+ICtzeW5jaHJvbml6
ZV9yY3UoKSBtYXkgc2xlZXAgZm9yIGEgc3Vic3RhbnRpYWwgYW1vdW50IG9mIHRpbWUuDQo+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2tvYmplY3QudHh0IGIvRG9jdW1lbnRhdGlvbi9rb2Jq
ZWN0LnR4dA0KPiBpbmRleCBmZjRjMjUwOTgxMTkuLjE0MDAzMGI0NjAzYiAxMDA2NDQNCj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9rb2JqZWN0LnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2tvYmpl
Y3QudHh0DQo+IEBAIC0xNTksNiArMTU5LDEwIEBAIGtlcm5lbCBhdCB0aGUgc2FtZSB0aW1lLCBj
YWxsZWQgc3VycHJpc2luZ2x5DQo+IGVub3VnaCBrb2JqZWN0X2luaXRfYW5kX2FkZCgpOjoNCj4g
ICAgICBpbnQga29iamVjdF9pbml0X2FuZF9hZGQoc3RydWN0IGtvYmplY3QgKmtvYmosIHN0cnVj
dCBrb2JqX3R5cGUNCj4gKmt0eXBlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3Qga29iamVjdCAqcGFyZW50LCBjb25zdCBjaGFyDQo+ICpmbXQsIC4uLik7DQo+ICANCj4g
K0FuIGVycm9yIHJldHVybiBmcm9tIGtvYmplY3RfaW5pdF9hbmRfYWRkKCkgbXVzdCBiZSBmb2xs
b3dlZCBieSBhDQo+IGNhbGwgdG8NCj4gK2tvYmplY3RfcHV0KCkgc2luY2UgdGhlICdpbml0JyBw
YXJ0IG9mIHRoaXMgZnVuY3Rpb24gaXMgYWx3YXlzDQo+IGNhbGxlZCBhbmQgdGhlDQo+ICtlcnJv
ciByZXR1cm4gaXMgZHVlIHRvIHRoZSAnYWRkJyBwYXJ0Lg0KPiArDQo+ICBUaGUgYXJndW1lbnRz
IGFyZSB0aGUgc2FtZSBhcyB0aGUgaW5kaXZpZHVhbCBrb2JqZWN0X2luaXQoKSBhbmQNCj4gIGtv
YmplY3RfYWRkKCkgZnVuY3Rpb25zIGRlc2NyaWJlZCBhYm92ZS4NCj4gIA0K
