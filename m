Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564B6C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361132073C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfLBJym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:54:42 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47164 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfLBJym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:54:42 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xB29oALQ029104, This message is accepted by code: ctloc85258
Received: from mail.realtek.com ([172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xB29oALQ029104
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Dec 2019 17:50:10 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Mon, 2 Dec 2019 17:49:57 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 2 Dec 2019 17:49:57 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::35ac:d9d0:1393:a902]) by
 RTEXMB03.realtek.com.tw ([fe80::35ac:d9d0:1393:a902%8]) with mapi id
 15.01.1779.005; Mon, 2 Dec 2019 17:49:57 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/7] arm64: dts: realtek: rtd129x: Use reserved-memory for RPC regions
Thread-Topic: [PATCH 2/7] arm64: dts: realtek: rtd129x: Use reserved-memory
 for RPC regions
Thread-Index: AQHVmDzfamWec3ddWkiVVX1ELT676KemGsuAgACXBLA=
Date:   Mon, 2 Dec 2019 09:49:56 +0000
Message-ID: <a511b94a991946a1b3f26dcdc485d4fa@realtek.com>
References: <20191111030434.29977-1-afaerber@suse.de>
 <20191111030434.29977-3-afaerber@suse.de>
 <1f25f2fc-5d31-1d74-b730-78ad7861ffce@suse.de>
In-Reply-To: <1f25f2fc-5d31-1d74-b730-78ad7861ffce@suse.de>
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

SGkgQW5kcmVhcywNCg0KPiA+ICAvbWVtcmVzZXJ2ZS8JMHgwMDAwMDAwMDAwMDAwMDAwIDB4MDAw
MDAwMDAwMDAzMDAwMDsNCj4gPiAtL21lbXJlc2VydmUvCTB4MDAwMDAwMDAwMDAxZjAwMCAweDAw
MDAwMDAwMDAwMDEwMDA7DQo+ID4gIC9tZW1yZXNlcnZlLwkweDAwMDAwMDAwMDAwMzAwMDAgMHgw
MDAwMDAwMDAwMGQwMDAwOw0KPiA+ICAvbWVtcmVzZXJ2ZS8JMHgwMDAwMDAwMDAxYjAwMDAwIDB4
MDAwMDAwMDAwMDRiZTAwMDsNCj4gPiAtL21lbXJlc2VydmUvCTB4MDAwMDAwMDAwMWZmZTAwMCAw
eDAwMDAwMDAwMDAwMDQwMDA7DQo+ID4NCg0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50
ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
cmVzZXQvcmVhbHRlayxydGQxMjk1Lmg+DQo+ID4gQEAgLTE5LDYgKzE3LDI1IEBADQo+ID4gIAkj
YWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiAgCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+DQo+ID4g
KwlyZXNlcnZlZC1tZW1vcnkgew0KPiA+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsJ
CSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICsJCXJhbmdlczsNCj4gPiArDQo+ID4gKwkJcnBjX2Nv
bW06IHJwY0AxZjAwMCB7DQo+ID4gKwkJCXJlZyA9IDwweDFmMDAwIDB4MTAwMD47DQo+ID4gKwkJ
fTsNCj4gPiArDQo+ID4gKwkJcnBjX3JpbmdidWY6IHJwY0AxZmZlMDAwIHsNCj4gPiArCQkJcmVn
ID0gPDB4MWZmZTAwMCAweDQwMDA+Ow0KPiA+ICsJCX07DQo+IA0KPiBIYXZlIHlvdSByZXZpZXdl
ZCB0aGlzIHBhdGNoIHRvIGJlIGNvcnJlY3Q/IEkuZS4sIGFyZSB0aGUgYWJvdmUgdHdvIHJlZ2lv
bnMNCj4gcmVzZXJ2ZWQgUkFNIChhc3N1bXB0aW9uIGFib3ZlKSwgb3IgaXMgdGhpcyByYXRoZXIg
TU1JTyBzaGFkb3dpbmcgUkFNPw0KPiAodGhlbiB3ZSB3b3VsZCBuZWVkIHRvIHVwZGF0ZSB0aGUg
L21lbW9yeSByZWcgYW5kIC9zb2MgcmFuZ2VzIHByb3BlcnRpZXMpDQo+IA0KPiBUaGF0IGFsc28g
YWZmZWN0cyBSVEQxNjE5LCB3aGljaCBjdXJyZW50bHkgaGFzIG5laXRoZXIuDQo+IA0KVGhlIFJQ
QyBjb21tb24gYnVmZmVyIGFuZCBSUEMgcmluZyBidWZmZXIgYWRkcmVzcyBpcyBjb3JyZWN0Lg0K
DQoNClJlZ2FyZHMsDQpKYW1lcw0KDQoNCg==
