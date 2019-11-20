Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9790AC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E4421852
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfKTH7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 02:59:22 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:55214 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfKTH7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 02:59:21 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAK7wvGv028634, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAK7wvGv028634
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 20 Nov 2019 15:58:57 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 20 Nov 2019 15:58:57 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 20 Nov 2019 15:58:56 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::a4bf:5be3:6e60:69f9]) by
 RTEXMB03.realtek.com.tw ([fe80::a4bf:5be3:6e60:69f9%8]) with mapi id
 15.01.1779.005; Wed, 20 Nov 2019 15:58:56 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
Thread-Topic: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
Thread-Index: AdWTrwRiu8TDC5guRneVMItRk6mPLwAihi8AAIJriSACDOAZgAA+WRqQ
Date:   Wed, 20 Nov 2019 07:58:56 +0000
Message-ID: <993d5da60a87443995347ee2a4c74959@realtek.com>
References: <43B123F21A8CFE44A9641C099E4196FFCF91BEFA@RTITMBSVM04.realtek.com.tw>
 <25fdd8eb-f1a0-82ae-9c4b-22325b163b0e@suse.de>
 <43B123F21A8CFE44A9641C099E4196FFCF920024@RTITMBSVM04.realtek.com.tw>
 <6182b89f-cd7e-ce7c-56f7-e2f500321cde@suse.de>
In-Reply-To: <6182b89f-cd7e-ce7c-56f7-e2f500321cde@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.187]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KPiANCj4gVGhpcyBjb25mbGljdHMgd2l0aCB3aGF0IEkgc2VlIGluIEJT
UCBpcnEgbXV4IGNvZGUgaGVyZToNCj4gaHR0cHM6Ly9naXRodWIuY29tL0JQSS1TSU5PVk9JUC9C
UEktTTQtYnNwL2Jsb2IvbWFzdGVyL2xpbnV4LXJ0ay9kcml2ZXJzL2lyDQo+IHFjaGlwL2lycS1y
dGQxNnh4LmgNCj4gDQo+IFRoYXQgZG9lcyBzaG93IFVSMCBhcyBiaXQgMiBmb3IgdGhlIGlzbyBp
cnEgbXV4LCBhcyBmb3IgcHJldmlvdXMgU29Dcy4NCj4gSXMgdGhhdCBjb2RlIHdyb25nLCBvciBk
b2VzIHRoZSBzYW1lIFVBUlQwIElQIGJsb2NrIGhhdmUgdHdvIGFsdGVybmF0aXZlDQo+IGludGVy
cnVwdHMgZm9yIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5PyBJIHRoZXJlZm9yZSBoZWxkIGJhY2sg
UlREMTYxOSBpcnEgbXV4DQo+IHBhdGNoZXMgZnJvbSBteSBpcnFjaGlwIHY0IHNlcmllcyBbMV0u
DQo+IA0KSXQgaXMgY29kZSB3cm9uZy4gVGhlIFVSMCBzaG91bGQgcmVtb3ZlIGZyb20gImlycS1y
dGQxNnh4LmgiLg0KDQo+IFRoZSBCU1AgRFQgZG9lcyBhc3NpZ24gbm9uLW11eCBpbnRlcnJ1cHRz
IHRvIHRoZSBVQVJUIG5vZGUgbGlrZSB5b3UgZGlkOg0KPiBodHRwczovL2dpdGh1Yi5jb20vQlBJ
LVNJTk9WT0lQL0JQSS1NNC1ic3AvYmxvYi9tYXN0ZXIvbGludXgtcnRrL2FyY2gvYXJtDQo+IDY0
L2Jvb3QvZHRzL3JlYWx0ZWsvcnRkMTZ4eC9ydGQtMTZ4eC5kdHNpDQo+IEFuZCBJIG9idmlvdXNs
eSB0cnVzdCB0aGF0IHlvdSB0ZXN0ZWQgeW91ciBEVCB0byBwcm9kdWNlIHNlcmlhbCBvdXRwdXQu
DQo+IA0KDQo+IEFsc28gbm90ZSBob3cgdGhlcmUgYXJlIFVSMV9UTyBhbmQgVVIyX1RPIChUTyA9
IHRpbWVvdXQ/KSBpbiBhZGRpdGlvbiB0bw0KPiByZWd1bGFyIFVSMSBhbmQgVVIyIGludGVycnVw
dHMgaW4gdGhlIG11eCBhYm92ZSwganVzdCBhcyBmb3IgUlREMTI5NSBhbmQNCj4gUlREMTE5NSAo
VVIxL1VSMV9UTyBvbmx5KS4gRnJvbSBteSBpcnFtdXggdjQgc2VyaWVzIHBvc3RlZCBsYXN0IG5p
Z2h0IEkgaGFkDQo+IHRvIGRyb3AgdGhvc2UgYWRkaXRpb25hbCBpbnRlcnJ1cHRzIHByb3BlcnR5
IHZhbHVlcyBmcm9tIHRoZSBEVCBbMl0sIGFzIHRoZXkNCj4gdmlvbGF0ZSBtYWlubGluZSdzIERl
c2lnbldhcmUgRFQgc2NoZW1hJ3MgbWF4SXRlbXMgMSBhbmQgd291bGQgcmVxdWlyZSBhDQo+IG5l
dyBjb21wYXRpYmxlIHN0cmluZyAoYW5kIGEgZHJpdmVyIHBhdGNoIHRvIG1ha2UgdXNlIG9mIGl0
KS4NCj4gDQpZZXMsIFRPIGlzIGludGVycnVwdCB0aW1lb3V0Lg0KDQoNClJlZ2FyZHMsDQpKYW1l
cw0KDQoNCg==
