Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EACC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE80B2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKRGyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 01:54:04 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51142 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfKRGyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:54:03 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAI6resY006183, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAI6resY006183
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 14:53:40 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Mon, 18 Nov 2019 14:53:40 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 18 Nov 2019 14:53:39 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::5cc4:90a5:6821:926]) by
 RTEXMB03.realtek.com.tw ([fe80::5cc4:90a5:6821:926%8]) with mapi id
 15.01.1779.005; Mon, 18 Nov 2019 14:53:39 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 5/7] ARM: dts: rtd1195: Introduce r-bus
Thread-Topic: [PATCH 5/7] ARM: dts: rtd1195: Introduce r-bus
Thread-Index: AQHVmD0XE9qksqLMuUeBNyO+ccQCh6eIaL1AgAJ0nQCABXPOcA==
Date:   Mon, 18 Nov 2019 06:53:39 +0000
Message-ID: <753c18eee3fb4e9ea25d42798542b3dd@realtek.com>
References: <20191111030434.29977-1-afaerber@suse.de>
 <20191111030434.29977-6-afaerber@suse.de>
 <a43d184d74c34e269714858b2635c35e@realtek.com>
 <960a80b9-b1bf-3709-bbb7-fc2a3c3ae1da@suse.de>
In-Reply-To: <960a80b9-b1bf-3709-bbb7-fc2a3c3ae1da@suse.de>
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

SGkgQW5kcmVhcywNCg0KPiANCj4gRml4ZWQsIGFsc28gZnVydGhlciBhYm92ZSBmb3IgdGhlIHNv
YyBub2RlLiBUaGlzIG5vdyBsZWF2ZXMgYSBnYXAgdW50aWwNCj4gMHgxODEwMDAwMCAtIGlzIHRo
YXQgZ2FwIFJBTSBvciBub24tci1idXMgcmVnaXN0ZXJzIHRoZW4/DQo+IA0KPiAJCXJhbmdlcyA9
IDwweDE4MDAwMDAwIDB4MTgwMDAwMDAgMHgwMDA3MDAwMD4sDQo+IAkJICAgICAgICAgPDB4MTgx
MDAwMDAgMHgxODEwMDAwMCAweDAxMDAwMDAwPiwNCj4gCQkgICAgICAgICA8MHg0MDAwMDAwMCAw
eDQwMDAwMDAwIDB4YzAwMDAwMDA+Ow0KPiANCg0KPiBEaWQgeW91IGFsc28gcmV2aWV3IHRoZSBv
dGhlciB0d28gcmFuZ2VzPyBUaGUgbWlkZGxlIG9uZSB3YXMgbGFiZWxlZCBOT1INCj4gZmxhc2gg
c29tZXdoZXJlIC0gYXJlIHN0YXJ0IGFuZCBzaXplIGNvcnJlY3Q/IFRoZSBmaW5hbCBvbmUgZGVw
ZW5kcyBvbiB0aGUNCj4gbWF4aW11bSBSQU0gc2l6ZSAtIGRvZXMgUlREMTE5NSBhbGxvdyBtb3Jl
IHRoYW4gMSBHaUIgUkFNPyBBbGwNCj4gbm9uLVJBTSByZWdpb25zIHNob3VsZCBiZSBjb3ZlcmVk
IGhlcmUuDQo+IA0KSXQgaXMgcmVzZXJ2ZWQgZm9yIE5PUiBmbGFzaC4gVGhlIHN0YXJ0IGFuZCBz
aXplIGlzIGNvcnJlY3QuDQpUaGUgcnRkMTE5NSBjYW4gc3VwcG9ydCB0byAyR2lCIFJBTS4NCg0K
PiBTbyBhbm90aGVyIHF1ZXN0aW9uLCBhcHBsaWNhYmxlIHRvIGFsbCBTb0NzOiBUaGlzIHJlc2Vy
dmVkIEJvb3QgUk9NIGFyZWEgYXQNCj4gdGhlIHN0YXJ0IG9mIHRoZSBhZGRyZXNzIHNwYWNlLCBo
ZXJlIG9mIHNpemUgMHhhODAwLCBpcyB0aGF0IGNvcGllZCBpbnRvIFJBTSwgb3INCj4gaXMgdGhh
dCB0aGUgYWN0dWFsIFJPTSBvdmVybGFwcGluZyBSQU0/IElmIHRoZSBsYXR0ZXIsIHdlIHNob3Vs
ZCBleGNsdWRlIGl0DQo+IGZyb20gL21lbW9yeUAwJ3MgcmVnIChtYWtpbmcgaXQgL21lbW9yeUBh
ODAwKSwgYW5kIGFkZCBpdCB0byBzb2MncyByYW5nZXMNCj4gaGVyZSBmb3IgY29ycmVjdG5lc3Mu
DQo+IA0KWWVzLCB3ZSBzaG91bGQgZXhjbHVkZSBpdCBmcm9tIC9tZW1vcnlAMCdzIHJlZy4NCg0K
PiBXaXRoIHRoZSBmb2xsb3ctdXAgcXVlc3Rpb246IElzIGl0IGNvcnJlY3QgdGhhdCwgZ2l2ZW4g
dGhlIHNpemUgMHhhODAwLCBJIGhhdmUgYQ0KPiBnYXAgYmV0d2VlbiAvbWVtcmVzZXJ2ZS9zIGZy
b20gMHhhODAwIHRvIDB4YzAwMCwgb3Igc2hvdWxkIHdlIHJlc2VydmUgdGhhdA0KPiBnYXAgYnkg
ZXh0ZW5kaW5nIHRoZSBuZXh0IC9tZW1yZXNlcnZlLyBvciBpbnNlcnRpbmcgb25lPw0KDQpXZSBz
aG91bGQgcmVzZXJ2ZSBtZW1vcnkgYWRkcmVzcyBmcm9tIDB4MDAwMCB0byAweGE4MDAgZm9yIHRo
ZSBpbnRlcm5hbCBST00uDQoNCg0KUmVnYXJkcywNCkphbWVzDQoNCg0K
