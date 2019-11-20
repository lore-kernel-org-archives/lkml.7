Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B504C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B0C2246A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfKTGye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:54:34 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51156 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKTGye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:54:34 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAK6rwUM004452, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (mapi.realtek.com[172.21.6.95])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAK6rwUM004452
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 20 Nov 2019 14:53:58 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 20 Nov 2019 14:53:58 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 20 Nov 2019 14:53:57 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::a4bf:5be3:6e60:69f9]) by
 RTEXMB03.realtek.com.tw ([fe80::a4bf:5be3:6e60:69f9%8]) with mapi id
 15.01.1779.005; Wed, 20 Nov 2019 14:53:57 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v3 6/8] ARM: dts: rtd1195: Add reset nodes
Thread-Topic: [PATCH v3 6/8] ARM: dts: rtd1195: Add reset nodes
Thread-Index: AQHVnRfWQHpokuCZUUmFW9fO0MELfKeQpIVQgAEDlACAAZ/isA==
Date:   Wed, 20 Nov 2019 06:53:57 +0000
Message-ID: <4363fb2d71724974bd7969c93bd9d7a2@realtek.com>
References: <20191117072109.20402-1-afaerber@suse.de>
 <20191117072109.20402-7-afaerber@suse.de>
 <20b3d0956bed4338a540216df07f16e5@realtek.com>
 <ed7c483d-b518-c74f-f66d-a812d0858f4c@suse.de>
In-Reply-To: <ed7c483d-b518-c74f-f66d-a812d0858f4c@suse.de>
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

DQpIaSBBbmRyZWFzLA0KDQo+ID4NCj4gPiBXZSBkb24ndCB1c2UgdGhlIERlc2lnbldhcmUgSVAg
Zm9yIHRoZSByZXNldCBjb250cm9sbGVyLg0KPiANCj4gVGhhbmtzIGZvciByZXZpZXdpbmcuDQo+
IA0KPiBXZSBhbHJlYWR5IG1lcmdlZCB0aGUgZXF1aXZhbGVudCBub2RlcyBmb3IgUlREMTI5eCBp
bnRvIGFybS1zb2MuZ2l0Lg0KPiBObyBSZWFsdGVrIHJldmlldyB3YXMgcmVjZWl2ZWQgYmFjayB3
aGVuIGl0IHdhcyBwb3N0ZWQgWzFdLCBzYWRseS4NCj4gDQo+IEhvdyBkb2VzIHlvdXIgcmVzZXQg
Y29udHJvbGxlciBkaWZmZXIgZnJvbSBEZXNpZ25XYXJlLCBhbmQgaG93IHdvdWxkIHlvdQ0KPiBw
cmVmZXIgdG8gaGFuZGxlIGl0Pw0KPiANCj4gYSkgRG8geW91IHdhbnQgdG8gc2VuZCBwYXRjaGVz
IGZvciBhIG5ldyBSZWFsdGVrLXNwZWNpZmljIGR0LWJpbmRpbmcgWzJdIGFuZA0KPiBleHRlbmQg
cmVzZXQtc2ltcGxlIGRyaXZlciB0byBjb3ZlciBpdCBhcyBhIGNvcHkmcGFzdGUgb2YgdGhlIERl
c2lnbldhcmUNCj4gb2ZfZGV2aWNlX2lkPw0KPiANCj4gYikgRG8geW91IGJlbGlldmUgeW91IG5l
ZWQgdG8gc3VibWl0IGEgY29tcGxldGVseSBuZXcgcmVzZXQgZHJpdmVyPw0KPiANCg0KVGhlIFJU
RDExOTUsIFJURDEyOTUgYW5kIFJURDEzOTUgcmVzZXQgY29udHJvbGxlciBpcyBjb21wYXRpYmxl
IHdpdGggdGhlIHJlc2V0LXNpbXBsZSBkcml2ZXIuDQpJIHdhbnQgdG8gdXNlIHBsYW4gYSkgZm9y
IHRoZW0uDQoNCkJlc2lkZXMsIEknbGwgc3VibWl0IGEgY29tcGxldGVseSBuZXcgcmVzZXQgZHJp
dmVyIGZvciB0aGUgUlREMTYxOSANCmJlY2F1c2UgdGhlIHJlc2V0IGNvbnRyb2xsZXIgbm90IGNv
bXBhdGlibGUgd2l0aCB0aGUgcmVzZXQtc2ltcGxlIGRyaXZlci4NCg0KUmVnYXJkcywNCkphbWVz
DQoNCg0K
