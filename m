Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1045C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE6920840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfCGRYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:24:55 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35184 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbfCGRYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:24:54 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27HMDJL031729;
        Thu, 7 Mar 2019 18:24:37 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r315ute4n-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 07 Mar 2019 18:24:37 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 70FC14D;
        Thu,  7 Mar 2019 17:24:36 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 46D6F562D;
        Thu,  7 Mar 2019 17:24:36 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 7 Mar
 2019 18:24:35 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Thu, 7 Mar 2019 18:24:35 +0100
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: RE: [PATCH] irqchip: stm32: don't set rising configuration registers
 at init
Thread-Topic: [PATCH] irqchip: stm32: don't set rising configuration registers
 at init
Thread-Index: AQHU1QD7RMigUJWrgUiPC0+O3u7LzKYATfOAgAAbASA=
Date:   Thu, 7 Mar 2019 17:24:35 +0000
Message-ID: <6817f02f47b4436cb9911371f91523ba@SFHDAG5NODE3.st.com>
References: <1551975317-5171-1-git-send-email-fabien.dessenne@st.com>
 <6ee8e9dc-f331-7bc9-64e2-8978ab17aed1@arm.com>
In-Reply-To: <6ee8e9dc-f331-7bc9-64e2-8978ab17aed1@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgWnluZ2ll
ciA8bWFyYy56eW5naWVyQGFybS5jb20+DQo+IFNlbnQ6IGpldWRpIDcgbWFycyAyMDE5IDE3OjQw
DQo+IFRvOiBGYWJpZW4gREVTU0VOTkUgPGZhYmllbi5kZXNzZW5uZUBzdC5jb20+OyBUaG9tYXMg
R2xlaXhuZXINCj4gPHRnbHhAbGludXRyb25peC5kZT47IEphc29uIENvb3BlciA8amFzb25AbGFr
ZWRhZW1vbi5uZXQ+OyBNYXhpbWUgQ29xdWVsaW4NCj4gPG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5j
b20+OyBBbGV4YW5kcmUgVE9SR1VFDQo+IDxhbGV4YW5kcmUudG9yZ3VlQHN0LmNvbT47IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXN0bTMyQHN0LW1kLQ0KPiBtYWlsbWFuLnN0
b3JtcmVwbHkuY29tOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6
IEJlbmphbWluIEdBSUdOQVJEIDxiZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGlycWNoaXA6IHN0bTMyOiBkb24ndCBzZXQgcmlzaW5nIGNvbmZpZ3VyYXRp
b24gcmVnaXN0ZXJzIGF0IGluaXQNCj4gDQo+IE9uIDA3LzAzLzIwMTkgMTY6MTUsIEZhYmllbiBE
ZXNzZW5uZSB3cm90ZToNCj4gPiBUaGUgcmlzaW5nIGNvbmZpZ3VyYXRpb24gc3RhdHVzIHJlZ2lz
dGVyIChydHNyKSBpcyBub3QgYmFua2VkLg0KPiA+IEFzIGl0IGlzIHNoYXJlZCB3aXRoIHRoZSBj
by1wcm9jZXNzb3IsIGl0IHNob3VsZCBub3QgYmUgd3JpdHRlbiBhdA0KPiA+IHByb2JlIHRpbWUs
IGVsc2UgdGhlIGNvLXByb2Nlc3NvciBjb25maWd1cmF0aW9uIHdpbGwgYmUgbG9zdC4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEZhYmllbiBEZXNzZW5uZSA8ZmFiaWVuLmRlc3Nlbm5lQHN0LmNv
bT4NCj4gDQo+IEZpeGVzOj8NCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaXJxY2hpcC9pcnEt
c3RtMzItZXh0aS5jIHwgNSAtLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLXN0bTMyLWV4dGku
Yw0KPiA+IGIvZHJpdmVycy9pcnFjaGlwL2lycS1zdG0zMi1leHRpLmMNCj4gPiBpbmRleCA2ZWRm
ZDRiLi5mZjhhODRmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtc3RtMzIt
ZXh0aS5jDQo+ID4gKysrIGIvZHJpdmVycy9pcnFjaGlwL2lycS1zdG0zMi1leHRpLmMNCj4gPiBA
QCAtNzE2LDcgKzcxNiw2IEBAIHN0bTMyX2V4dGlfY2hpcF9kYXRhICpzdG0zMl9leHRpX2NoaXBf
aW5pdChzdHJ1Y3QNCj4gc3RtMzJfZXh0aV9ob3N0X2RhdGEgKmhfZGF0YSwNCj4gPiAgCWNvbnN0
IHN0cnVjdCBzdG0zMl9leHRpX2JhbmsgKnN0bTMyX2Jhbms7DQo+ID4gIAlzdHJ1Y3Qgc3RtMzJf
ZXh0aV9jaGlwX2RhdGEgKmNoaXBfZGF0YTsNCj4gPiAgCXZvaWQgX19pb21lbSAqYmFzZSA9IGhf
ZGF0YS0+YmFzZTsNCj4gPiAtCXUzMiBpcnFzX21hc2s7DQo+ID4NCj4gPiAgCXN0bTMyX2Jhbmsg
PSBoX2RhdGEtPmRydl9kYXRhLT5leHRpX2JhbmtzW2JhbmtfaWR4XTsNCj4gPiAgCWNoaXBfZGF0
YSA9ICZoX2RhdGEtPmNoaXBzX2RhdGFbYmFua19pZHhdOyBAQCAtNzI1LDEwICs3MjQsNiBAQA0K
PiA+IHN0bTMyX2V4dGlfY2hpcF9kYXRhICpzdG0zMl9leHRpX2NoaXBfaW5pdChzdHJ1Y3Qgc3Rt
MzJfZXh0aV9ob3N0X2RhdGENCj4gPiAqaF9kYXRhLA0KPiA+DQo+ID4gIAlyYXdfc3Bpbl9sb2Nr
X2luaXQoJmNoaXBfZGF0YS0+cmxvY2spOw0KPiA+DQo+ID4gLQkvKiBEZXRlcm1pbmUgbnVtYmVy
IG9mIGlycXMgc3VwcG9ydGVkICovDQo+ID4gLQl3cml0ZWxfcmVsYXhlZCh+MFVMLCBiYXNlICsg
c3RtMzJfYmFuay0+cnRzcl9vZnN0KTsNCj4gPiAtCWlycXNfbWFzayA9IHJlYWRsX3JlbGF4ZWQo
YmFzZSArIHN0bTMyX2JhbmstPnJ0c3Jfb2ZzdCk7DQo+ID4gLQ0KPiANCj4gQW5kIEkgZ3Vlc3Mg
eW91IGRvbid0IG5lZWQgdG8gZmluZCBvdXQgdGhlIG51bWJlciBvZiBzdXBwb3J0ZWQgSVJRcz8N
Cg0KVGhhdCdzIGNvcnJlY3QsIHRoaXMgaW5mb3JtZWQgaXMgdXNlbGVzcyA6IGlycXNfbWFzayBp
cyBuZXZlciB1c2VkIChpdCB1c2VkIHRvIGJlIG91dHB1dCBpbiBhIGxvZyBmb3IgZGVidWcgcHVy
cG9zZS5hbmQgdGhlIGxvZyBoYXMgYmVlbiByZW1vdmVkKQ0KDQoNCj4gDQo+IEFsc28sIGEgaGFu
ZGZ1bCBvZiBsaW5lcyBkb3duLCB5b3UncmUgd3JpdGluZyBhZ2FpbiB0byB0aGUgc2FtZSByZWdp
c3Rlci4gV2h5IGlzbid0DQo+IHRoYXQgYSBwcm9ibGVtPw0KDQpJdCdzIG9idmlvdXNseSBhIHBy
b2JsZW0gOiBhbm90aGVyIHBhdGNoIGlzIG1pc3NpbmcsIEkgYW0gZ29pbmcgdG8gYWRkIGl0IGlu
IHYyLg0KVGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dCENCg0KDQo+IA0KPiA+ICAJLyoNCj4g
PiAgCSAqIFRoaXMgSVAgaGFzIG5vIHJlc2V0LCBzbyBhZnRlciBob3QgcmVib290IHdlIHNob3Vs
ZA0KPiA+ICAJICogY2xlYXIgcmVnaXN0ZXJzIHRvIGF2b2lkIHJlc2lkdWUNCj4gPg0KPiANCj4g
VGhhbmtzLA0KPiANCj4gCU0uDQo+IC0tDQo+IEphenogaXMgbm90IGRlYWQuIEl0IGp1c3Qgc21l
bGxzIGZ1bm55Li4uDQo=
