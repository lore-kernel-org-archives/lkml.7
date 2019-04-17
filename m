Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AFDC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB4E206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbfDQMGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:06:25 -0400
Received: from mx23.baidu.com ([61.135.165.120]:44612 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731704AbfDQMGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:06:25 -0400
Received: from M1-MAIL-EX15.internal.baidu.com (unknown [10.44.89.55])
        by Forcepoint Email with ESMTPS id F1522FB3FD717;
        Wed, 17 Apr 2019 20:06:17 +0800 (CST)
Received: from BC-Mail-EX06.internal.baidu.com (172.31.40.46) by
 M1-MAIL-EX15.internal.baidu.com (10.44.89.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Wed, 17 Apr 2019 20:06:18 +0800
Received: from BC-Mail-Ex13.internal.baidu.com (172.31.40.49) by
 BC-Mail-Ex06.internal.baidu.com (172.31.40.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Wed, 17 Apr 2019 20:06:18 +0800
Received: from BC-Mail-Ex13.internal.baidu.com ([172.31.40.49]) by
 Bc-Mail-Ex13.internal.baidu.com ([172.31.40.49]) with mapi id 15.01.1531.010;
 Wed, 17 Apr 2019 20:06:18 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Jiri Slaby <jslaby@suse.cz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wang,Li(ACG Cloud)" <wangli39@baidu.com>,
        "Zhang,Yu(ACG Cloud)" <zhangyu31@baidu.com>,
        stable <stable@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBUVFk6IHNlcmlhbF9jb3JlLCBhZGQgLT5pbnN0YWxs?=
Thread-Topic: [PATCH] TTY: serial_core, add ->install
Thread-Index: AQHU9PvMzqf/co2MIU2pSYzxeW40hKZAQMkA
Date:   Wed, 17 Apr 2019 12:06:18 +0000
Message-ID: <9a7d8f6a38d54e70b379dfa615c7edee@baidu.com>
References: <20190417085853.21708-1-jslaby@suse.cz>
In-Reply-To: <20190417085853.21708-1-jslaby@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.150.217]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogbGludXgta2VybmVsLW93bmVyQHZn
ZXIua2VybmVsLm9yZw0KPiBbbWFpbHRvOmxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5v
cmddILT6se0gSmlyaSBTbGFieQ0KPiC3osvNyrG85DogMjAxOcTqNNTCMTfI1SAxNjo1OQ0KPiDK
1bz+yMs6IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnDQo+ILOty806IGxpbnV4LXNlcmlhbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEppcmkgU2xhYnkN
Cj4gPGpzbGFieUBzdXNlLmN6PjsgTGksUm9uZ3FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPjsg
V2FuZyxMaShBQ0cgQ2xvdWQpDQo+IDx3YW5nbGkzOUBiYWlkdS5jb20+OyBaaGFuZyxZdShBQ0cg
Q2xvdWQpIDx6aGFuZ3l1MzFAYmFpZHUuY29tPjsNCj4gc3RhYmxlIDxzdGFibGVAdmdlci5rZXJu
ZWwub3JnPg0KPiDW98ziOiBbUEFUQ0hdIFRUWTogc2VyaWFsX2NvcmUsIGFkZCAtPmluc3RhbGwN
Cj4gDQo+IFdlIG5lZWQgdG8gY29tcHV0ZSB0aGUgdWFydCBzdGF0ZSBvbmx5IG9uIHRoZSBmaXJz
dCBvcGVuLiBUaGlzIGlzIHVzdWFsbHkgd2hhdCBpcw0KPiBkb25lIGluIHRoZSAtPmluc3RhbGwg
aG9vay4gc2VyaWFsX2NvcmUgdXNlZCB0byBkbyB0aGlzIGluIC0+b3BlbiBvbiBldmVyeSBvcGVu
Lg0KPiBTbyBtb3ZlIGl0IHRvIC0+aW5zdGFsbC4NCj4gDQo+IEFzIGEgc2lkZSBlZmZlY3QsIGl0
IGVuc3VyZXMgdGhlIHN0YXRlIGlzIHNldCBwcm9wZXJseSBpbiB0aGUgd2luZG93IGFmdGVyDQo+
IHR0eV9pbml0X2RldiBpcyBjYWxsZWQsIGJ1dCBiZWZvcmUgdWFydF9vcGVuLiBUaGlzIGZpeGVz
IGEgYnVuY2ggb2YgcmFjZXMNCj4gYmV0d2VlbiB0dHlfb3BlbiBhbmQgZmx1c2hfdG9fbGRpc2Mg
d2Ugd2VyZSBkZWFsaW5nIHdpdGggcmVjZW50bHkuDQo+IA0KPiBPbmUgb2Ygc3VjaCBidWdzIHdh
cyBhdHRlbXB0ZWQgdG8gZml4IGluIGNvbW1pdCBmZWRiNTc2MDY0OGEgKHNlcmlhbDoNCj4gZml4
IHJhY2UgYmV0d2VlbiBmbHVzaF90b19sZGlzYyBhbmQgdHR5X29wZW4pLCBidXQgaXQgb25seSB0
b29rIGNhcmUgb2YgYSBjb3VwbGUNCj4gb2YgZnVuY3Rpb25zICh1YXJ0X3N0YXJ0IGFuZCB1YXJ0
X3VudGhyb3R0bGUpLiAgSSB3YXMgYWJsZSB0byByZXByb2R1Y2UgdGhlDQo+IGNyYXNoIG9uIGEg
U0xFIHN5c3RlbSwgYnV0IGluIHVhcnRfd3JpdGVfcm9vbSB3aGljaCBpcyBhbHNvIGNhbGxlZCBm
cm9tDQo+IGZsdXNoX3RvX2xkaXNjIHZpYSBwcm9jZXNzX2VjaG9lcy4gSSB3YXMgKnVuYWJsZSog
dG8gcmVwcm9kdWNlIHRoZSBidWcgbG9jYWxseS4NCj4gSXQgaXMgZHVlIHRvIGhhdmluZyB0aGlz
IHBhdGNoIGluIG15IHF1ZXVlIHNpbmNlIDIwMTIhDQo+IA0KPiAgZ2VuZXJhbCBwcm90ZWN0aW9u
IGZhdWx0OiAwMDAwIFsjMV0gU01QIEtBU0FOIFBUSQ0KPiAgQ1BVOiAxIFBJRDogNSBDb21tOiBr
d29ya2VyL3U0OjAgVGFpbnRlZDogRyAgICAgICAgICAgICBMDQo+IDQuMTIuMTQtMzk2LWRlZmF1
bHQgIzEgU0xFMTUtU1AxICh1bnJlbGVhc2VkKQ0KPiAgSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFu
ZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MNCj4gcmVsLTEuMTIuMC0wLWdhNjk4
Yzg5LXByZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQNCj4gIFdvcmtxdWV1ZTogZXZlbnRzX3Vu
Ym91bmQgZmx1c2hfdG9fbGRpc2MNCj4gIHRhc2s6IGZmZmY4ODAwNDI3ZDgwNDAgdGFzay5zdGFj
azogZmZmZjg4MDA0MjdmMDAwMA0KPiAgUklQOiAwMDEwOnVhcnRfd3JpdGVfcm9vbSsweGM0LzB4
NTkwDQo+ICBSU1A6IDAwMTg6ZmZmZjg4MDA0MjdmNzA4OCBFRkxBR1M6IDAwMDEwMjAyDQo+ICBS
QVg6IGRmZmZmYzAwMDAwMDAwMDAgUkJYOiAwMDAwMDAwMDAwMDAwMDAwIFJDWDogMDAwMDAwMDAw
MDAwMDAwMA0KPiAgUkRYOiAwMDAwMDAwMDAwMDAwMDJmIFJTSTogMDAwMDAwMDAwMDAwMDBlZSBS
REk6IGZmZmY4ODAwMzg4OGJkOTANCj4gIFJCUDogZmZmZmZmZmZiOTU0NTg1MCBSMDg6IDAwMDAw
MDAwMDAwMDAwMDEgUjA5OiAwMDAwMDAwMDAwMDAwNDAwDQo+ICBSMTA6IGZmZmY4ODAwNDI3ZDgy
NWMgUjExOiAwMDAwMDAwMDAwMDAwMDZlIFIxMjogMWZmZmYxMDAwODRmZWUxMg0KPiAgUjEzOiBm
ZmZmYzkwMDAwNGM1MDAwIFIxNDogZmZmZjg4MDAzODg4YmIyOCBSMTU6IDAwMDAwMDAwMDAwMDAx
NzgNCj4gIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmODgwMDQzMzAwMDAwKDAw
MDApDQo+IGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4gIENTOiAgMDAxMCBEUzogMDAwMCBFUzog
MDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gIENSMjogMDAwMDU2MWRhMDc5NDE0OCBDUjM6
IDAwMDAwMDAwMGViZjQwMDAgQ1I0OiAwMDAwMDAwMDAwMDAwNmUwDQo+IENhbGwgVHJhY2U6DQo+
ICAgdHR5X3dyaXRlX3Jvb20rMHg2ZC8weGMwDQo+ICAgX19wcm9jZXNzX2VjaG9lcysweDU1LzB4
ODcwDQo+ICAgbl90dHlfcmVjZWl2ZV9idWZfY29tbW9uKzB4MTA1ZS8weDI2ZDANCj4gICB0dHlf
bGRpc2NfcmVjZWl2ZV9idWYrMHhiNy8weDFjMA0KPiAgIHR0eV9wb3J0X2RlZmF1bHRfcmVjZWl2
ZV9idWYrMHgxMDcvMHgxODANCj4gICBmbHVzaF90b19sZGlzYysweDM1ZC8weDVjMA0KPiAuLi4N
Cj4gDQo+IDAgaW4gcmJ4IG1lYW5zIHR0eS0+ZHJpdmVyX2RhdGEgaXMgTlVMTCBpbiB1YXJ0X3dy
aXRlX3Jvb20uIDB4MTc4IGlzIHRyaWVkIHRvDQo+IGJlIGRlcmVmZXJlbmNlZCAoMHgxNzggPj4g
MyBpcyAweDJmIGluIHJkeCkgYXQgdWFydF93cml0ZV9yb29tKzB4YzQuIDB4MTc4IGlzDQo+IGV4
YWN0bHkgKHN0cnVjdCB1YXJ0X3N0YXRlICopTlVMTC0+cmVmY291bnQgdXNlZCBpbiB1YXJ0X3Bv
cnRfbG9jayBmcm9tDQo+IHVhcnRfd3JpdGVfcm9vbS4NCj4gDQo+IFNvIHJldmVydCB0aGUgdXBz
dHJlYW0gY29tbWl0IGhlcmUgYXMgbXkgbG9jYWwgcGF0Y2ggc2hvdWxkIGZpeCB0aGUgd2hvbGUN
Cj4gZmFtaWx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmlyaSBTbGFieSA8anNsYWJ5QHN1c2Uu
Y3o+DQo+IENjOiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+IENjOiBXYW5n
IExpIDx3YW5nbGkzOUBiYWlkdS5jb20+DQo+IENjOiBaaGFuZyBZdSA8emhhbmd5dTMxQGJhaWR1
LmNvbT4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+DQo+IENjOiBzdGFibGUgPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+IC0tLQ0KPiANCj4g
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0gTk9URSA9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KPiANCj4gQ291bGQgeW91IHRlc3QgeW91ciB1c2UtY2FzZSBhdCBCYWlkdSwgZ3V5
cywgcGxlYXNlPw0KPiANCg0KU29ycnksIHdlIGhhdmUgbm90IHRoZSBlbnZpcm9ubWVudCB0byB0
ZXN0IGl0LCBpdCBoYXBwZW5zIHdoZW4gd2UgdXBncmFkZXMgQk1DDQoNCi1Sb25nUWluZw0KDQo=
