Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45E5C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 03:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE6B2082F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 03:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390426AbfGTDDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 23:03:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2485 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728058AbfGTDDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 23:03:23 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 827899EB8FD686D92FFC;
        Sat, 20 Jul 2019 11:03:21 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 20 Jul 2019 11:03:20 +0800
Received: from DGGEMM506-MBX.china.huawei.com ([169.254.3.227]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0439.000;
 Sat, 20 Jul 2019 11:03:20 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
CC:     "kishon@ti.com" <kishon@ti.com>, Chen-Yu Tsai <wens@csie.org>,
        "Paul Kocialkowski" <paul.kocialkowski@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] phy: Change the configuration interface param to void*
 to make it more general
Thread-Topic: [PATCH] phy: Change the configuration interface param to void*
 to make it more general
Thread-Index: AQHVN9Ajzwa2MbZo40exGsBlwJEt36bEv5mAgApM1VWAAn7PsA==
Date:   Sat, 20 Jul 2019 03:03:20 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED2FF5D942@DGGEMM506-MBX.china.huawei.com>
References: <1562868255-31467-1-git-send-email-prime.zeng@hisilicon.com>
 <20190711112039.leuvelpm7opeoaxq@flea>
 <678F3D1BB717D949B966B68EAEB446ED2FF5B22D@DGGEMM506-MBX.china.huawei.com>
 <20190717163753.ti6swjfhm7fczcn4@flea>
In-Reply-To: <20190717163753.ti6swjfhm7fczcn4@flea>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.222.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgbWF4aW1lOiANCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTWF4aW1l
IFJpcGFyZCBbbWFpbHRvOm1heGltZS5yaXBhcmRAYm9vdGxpbi5jb21dDQo+U2VudDogVGh1cnNk
YXksIEp1bHkgMTgsIDIwMTkgMTI6MzggQU0NCj5UbzogWmVuZ3RhbyAoQikgPHByaW1lLnplbmdA
aGlzaWxpY29uLmNvbT4NCj5DYzoga2lzaG9uQHRpLmNvbTsgQ2hlbi1ZdSBUc2FpIDx3ZW5zQGNz
aWUub3JnPjsgUGF1bCBLb2NpYWxrb3dza2kNCj48cGF1bC5rb2NpYWxrb3dza2lAYm9vdGxpbi5j
b20+OyBTYWthcmkgQWlsdXMgPHNha2FyaS5haWx1c0BsaW51eC5pbnRlbC5jb20+Ow0KPmxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHBoeTogQ2hhbmdlIHRoZSBjb25maWd1cmF0aW9u
IGludGVyZmFjZSBwYXJhbSB0byB2b2lkKg0KPnRvIG1ha2UgaXQgbW9yZSBnZW5lcmFsDQo+DQo+
SGksDQo+DQo+T24gV2VkLCBKdWwgMTcsIDIwMTkgYXQgMDY6MzY6MDlBTSArMDAwMCwgWmVuZ3Rh
byAoQikgd3JvdGU6DQo+PiBIaSBNYXhpbWU6DQo+Pg0KPj4gVGhhbmtzIGZvciB5b3VyIHJlcGx5
Lg0KPj4NCj4+ID4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPkZyb206IE1heGltZSBS
aXBhcmQgW21haWx0bzptYXhpbWUucmlwYXJkQGJvb3RsaW4uY29tXQ0KPj4gPlNlbnQ6IFRodXJz
ZGF5LCBKdWx5IDExLCAyMDE5IDc6MjEgUE0NCj4+ID5UbzogWmVuZ3RhbyAoQikgPHByaW1lLnpl
bmdAaGlzaWxpY29uLmNvbT4NCj4+ID5DYzoga2lzaG9uQHRpLmNvbTsgQ2hlbi1ZdSBUc2FpIDx3
ZW5zQGNzaWUub3JnPjsgUGF1bCBLb2NpYWxrb3dza2kNCj4+ID48cGF1bC5rb2NpYWxrb3dza2lA
Ym9vdGxpbi5jb20+OyBTYWthcmkgQWlsdXMNCj4+ID48c2FrYXJpLmFpbHVzQGxpbnV4LmludGVs
LmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+PiA+bGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+PiA+U3ViamVjdDogUmU6IFtQQVRDSF0gcGh5OiBDaGFu
Z2UgdGhlIGNvbmZpZ3VyYXRpb24gaW50ZXJmYWNlIHBhcmFtIHRvDQo+PiA+dm9pZCogdG8gbWFr
ZSBpdCBtb3JlIGdlbmVyYWwNCj4+ID4NCj4+ID4qIFBHUCBTaWduZWQgYnkgYW4gdW5rbm93biBr
ZXkNCj4+ID4NCj4+ID5PbiBGcmksIEp1bCAxMiwgMjAxOSBhdCAwMjowNDowOEFNICswODAwLCBa
ZW5nIFRhbyB3cm90ZToNCj4+ID4+IFRoZSBwaHkgZnJhbWV3b3JrIG5vdyBhbGxvd3MgcnVudGlt
ZSBjb25maWd1cmF0aW9ucywgYnV0IG9ubHkNCj4+ID4+IGxpbWl0ZWQgdG8gbWlwaSBub3csIGFu
ZCBpdCdzIG5vdCByZWFzb25hYmxlIHRvIGludHJvZHVjZSB1c2VyDQo+PiA+PiBzcGVjaWZpZWQg
Y29uZmlndXJhdGlvbnMgaW50byB0aGUgdW5pb24gcGh5X2NvbmZpZ3VyZV9vcHRzDQo+PiA+PiBz
dHJ1Y3R1cmUuIEFuIHNpbXBsZSB3YXkgaXMgdG8gcmVwbGFjZSB3aXRoIGEgdm9pZCAqLg0KPj4g
Pg0KPj4gPkknbSBub3Qgc3VyZSB3aHkgaXQncyB1bnJlYXNvbmFibGU/DQo+PiA+DQo+Pg0KPj4g
VGhlIHBoeS5oIHdpbGwgbmVlZCB0byBpbmNsdWRlIHZlbmRvciBzcGVjaWZpYyBwaHkgaGVhZGVy
cw0KPg0KPkknbSBub3Qgc3VyZSB0aGlzIGlzIGFuIGlzc3VlLg0KPg0KPj4gYW5kIHRoZSB1bmlv
biBwaHlfY29uZmlndXJlX29wdHMgd2lsbCBiZWNvbWUgbW9yZSBjb21wbGV4Lg0KPg0KPkFuZCB0
aGlzIHdhcyB0aGUgcGxhbiBhbGwgYWxvbmcuDQo+DQo+PiBJIGRvbid0IHRoaW5rIHRoaXMgaXMg
YSBnb29kIHNvbHV0aW9uIHRvIGluY2x1ZGUgYWxsIHZlbmRvciBzcGVjaWZpYw0KPj4gcGh5IGNv
bmZpZ3MgaW50byBhIHNpbmdsZSB1bmlvbiBzdHJ1Y3R1cmUuDQo+DQo+VGhlIHRoaW5nIGlzLCBh
cyBTYWthcmkgaGF2ZSBzdGF0ZWQsIHRoaXMgaW50ZXJmYWNlIHdhcyBtZWFudCBhcyBhIGdlbmVy
aWMgd2F5DQo+dG8gbmVnb3RpYXRlIGEgY29uZmlndXJhdGlvbiBiZXR3ZWVuIGEgUEhZIGNvbnN1
bWVyIGFuZCBhIFBIWSBwcm92aWRlciAoaWUsDQo+d2hhdGV2ZXIgc2VuZHMgZGF0YSB0byB0aGUg
cGh5IGFuZCB0aGUgcGh5IGl0c2VsZikuDQo+DQo+SWYgeW91IHJlbW92ZSB0aGUgZXhwbGljaXQg
dHlwZSBjaGVjaywgdGhlbiB5b3UgbmVlZCB0byBoYXZlIHByaW9yIGtub3dsZWRnZQ0KPihhbmQg
YWdyZWVtZW50KSBvbiBib3RoIHNpZGVzLCB3aGljaCBicmVha3MgdGhlIGluaXRpYWwgaW50ZW50
Lg0KDQpJIGdldCB5b3VyIHBvaW50LCBzbyBpZiB3ZSBmb2xsb3cgeW91ciBkZXNpZ24sIGl0IHdp
bGwgbG9vayB0aGlzOg0KDQp1bmlvbiBwaHlfY29uZmlndXJlX29wdHMgew0KCXN0cnVjdCB4eHh4
MV9waHkgcGh5MV9vcHRzOw0KCXN0cnVjdCB4eHh4MV9waHkgcGh5Ml9vcHRzOw0KCXN0cnVjdCB4
eHh4MV9waHkgcGh5M19vcHRzOw0KCS4uLi4uDQp9DQoNCkFuZCB0aGUgZ2VuZXJhbCBwaHkgZnJh
bWV3b3JrIG5lZWRuJ3QgdG8ga25vdyBhYm91dCB0aGUgdHlwZSBidXQganVzdCBwYXNzIHRocm91
Z2gsIA0KdGhlIGNhbGxlciBhbmQgdGhlIHBoeSBkcml2ZXIgZGVmaW5pdGVseSBuZWVkIHRvIGtu
b3cgd2hhdCB0aGV5IGFyZSBkb2luZy4NClNvIEkgc3VnZ2VzdCBhIG1vcmUgZ2VuZXJhbCB0eXBl
IHZvaWQgKiwgb3RoZXJ3aXNlIHRoZSBnZW5lcmFsIHBoeSB3aWxsIG5lZWQgdG8gc2VlIGEgbG90
IA0Kb2YgZGV0YWlscyB3aGljaCBpcyBub3QgdGhhdCBnZW5lcmFsLiANCg0KWmVuZ3RhbyANCg0K
Pg0KPk1heGltZQ0KPg0KPi0tDQo+TWF4aW1lIFJpcGFyZCwgQm9vdGxpbg0KPkVtYmVkZGVkIExp
bnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj5odHRwczovL2Jvb3RsaW4uY29tDQo=
