Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962A6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4872073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfDPBJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 21:09:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2536 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfDPBJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 21:09:37 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 36ED998C1695B1094E73;
        Tue, 16 Apr 2019 09:09:34 +0800 (CST)
Received: from DGGEML422-HUB.china.huawei.com (10.1.199.39) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Apr 2019 09:09:33 +0800
Received: from DGGEML522-MBS.china.huawei.com ([169.254.8.248]) by
 dggeml422-hub.china.huawei.com ([10.1.199.39]) with mapi id 14.03.0439.000;
 Tue, 16 Apr 2019 09:09:33 +0800
From:   Linhaifeng <haifeng.lin@huawei.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Paul Clarke <pc@us.ibm.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: perf tools:Is there any tools to found out the max latency by
 irq or cpu idle
Thread-Topic: perf tools:Is there any tools to found out the max latency by
 irq or cpu idle
Thread-Index: AQHU8TjwQPH5fZKzxkKUF8YFzmG5zqY5l6vwgAMUFYCAAFWIgIAA+83Q
Date:   Tue, 16 Apr 2019 01:09:33 +0000
Message-ID: <4099DE2E54AFAD489356C6C9161D53339592850D@dggeml522-mbs.china.huawei.com>
References: <4099DE2E54AFAD489356C6C9161D53339591D64A@DGGEML502-MBX.china.huawei.com>
 <8ce8c596-123e-1342-5ccc-06a5fd8a60ec@redhat.com>
 <4099DE2E54AFAD489356C6C9161D53339591DE6D@DGGEML502-MBX.china.huawei.com>
 <6e6a98a4-a442-1e10-cf5a-56b6792d42ba@us.ibm.com>
 <20190415175907.GC11294@kernel.org>
In-Reply-To: <20190415175907.GC11294@kernel.org>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.20.223]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rIHlvdSBldmVyeSBtdWNoIQ0KSSBmb3VuZCBNU0kgaW4gbXkgc3lzdGVtIHRv
byBhbmQgdGhlcmUgYXJlIHNvbWUgZXJyb3JzIGZvdW5kIGluIGJpb3MgbG9nLiBSZXBsYWNlIHRo
ZSBtZW1vcnlzIGNhbiBmaXggaXQuDQoNCg0KTDJHV18yNjgwOi9ob21lL2ZzcC95Y2IgIyBwZXJm
IHN0YXQgLUMgMS0xMSwxNC0yNSwyOS0zOSw0Mi01MiAtLXNtaS1jb3N0DQpeQw0KUGVyZm9ybWFu
Y2UgY291bnRlciBzdGF0cyBmb3IgJ0NQVShzKSAxLTExLDE0LTI1LDI5LTM5LDQyLTUyJzoNCg0K
U01JIGN5Y2xlcyUgU01JIyANCi0wLjIlIDkwIA0KDQo0NDcyLjQ4MzQxMzcxMiBzZWNvbmRzIHRp
bWUgZWxhcHNlZA0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBcm5hbGRv
IENhcnZhbGhvIGRlIE1lbG8gW21haWx0bzphcm5hbGRvLm1lbG9AZ21haWwuY29tXSANClNlbnQ6
IDIwMTnlubQ05pyIMTbml6UgMTo1OQ0KVG86IFBhdWwgQ2xhcmtlIDxwY0B1cy5pYm0uY29tPg0K
Q2M6IExpbmhhaWZlbmcgPGhhaWZlbmcubGluQGh1YXdlaS5jb20+OyBsaW51eC1wZXJmLXVzZXJz
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDog
UmU6IHBlcmYgdG9vbHM6SXMgdGhlcmUgYW55IHRvb2xzIHRvIGZvdW5kIG91dCB0aGUgbWF4IGxh
dGVuY3kgYnkgaXJxIG9yIGNwdSBpZGxlDQoNCkVtIE1vbiwgQXByIDE1LCAyMDE5IGF0IDA3OjUy
OjU5QU0gLTA1MDAsIFBhdWwgQ2xhcmtlIGVzY3JldmV1Og0KPiBPbiA0LzEzLzE5IDE6MDEgQU0s
IExpbmhhaWZlbmcgd3JvdGU6DQo+ID4gU29ycnksIHRoZSB2YWx1ZSAxMzEwODE0MDggaXMganVz
dCBmb3IgZXhhbXBsZS4gQWN0dWFsbHkgdGhlIHJlc3VsdCBpcyBsaWtlIHRoaXM6DQo+ID4gIHNx
cnQgMjAxOS0wNC0xMCAyMzo1Mzo1MDogNDM5NjgNCj4gPiAgc3FydCAyMDE5LTA0LTEwIDIzOjUz
OjUxOiA0NDA2MA0KPiA+ICBzcXJ0IDIwMTktMDQtMTAgMjM6NTM6NTI6IDQ5MDEyDQo+ID4gIHNx
cnQgMjAxOS0wNC0xMCAyMzo1Mzo1MzogMzgxNzINCj4gPiAgc3FydCAyMDE5LTA0LTEwIDIzOjUz
OjU0OiAxMzEwODE0MDggIHNxcnQgMjAxOS0wNC0xMCAyMzo1Mzo1NTogDQo+ID4gNDM2MDAgIHNx
cnQgMjAxOS0wNC0xMCAyMzo1Mzo1NjogNDY3MDQgIHNxcnQgMjAxOS0wNC0xMCAyMzo1Mzo1Nzog
DQo+ID4gNDY4ODAgIHNxcnQgMjAxOS0wNC0xMCAyMzo1Mzo1ODogNDQzMzIgIOKApuKApiAgc3Fy
dCAyMDE5LTA0LTEwIA0KPiA+IDAyOjE3OjE1OiAxMzYzNDU4NzYgIOKApuKApiAgc3FydCAyMDE5
LTA0LTEwIDA0OjQwOjM1OiAxMzYzMzU2NDQgIOKApuKApg0KPiANCj4gR2l2ZW4gdGhlIHBlcmlv
ZGljaXR5LCBJJ20gd29uZGVyaW5nIGlmIGl0IGNvdWxkIGJlIFN5c3RlbSBNYW5hZ2VtZW50IElu
dGVycnVwdHMgKFNNSXMpPw0KPiANCj4gSWYgc28sIHNvbWUgQklPU2VzIGhhdmUgc2V0dGluZ3Mg
dG8gbWl0aWdhdGUsIG90aGVyd2lzZSwgdGhlcmUncyBub3QgbXVjaCB0aGF0IGNhbiBiZSBkb25l
LCBwZXIgbXkgdW5kZXJzdGFuZGluZy4NCg0KW3Jvb3RAcXVhY28gcGVyZl0jIHBlcmYgbGlzdCBz
bWkNCg0KTGlzdCBvZiBwcmUtZGVmaW5lZCBldmVudHMgKHRvIGJlIHVzZWQgaW4gLWUpOg0KDQog
IG1zci9zbWkvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtLZXJu
ZWwgUE1VIGV2ZW50XQ0KDQogIHN1bnJwYzp4cHJ0X3RyYW5zbWl0ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFtUcmFjZXBvaW50IGV2ZW50XQ0KICB0Y3A6dGNwX3JldHJhbnNtaXRfc2ti
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbVHJhY2Vwb2ludCBldmVudF0NCiAgdGNwOnRj
cF9yZXRyYW5zbWl0X3N5bmFjayAgICAgICAgICAgICAgICAgICAgICAgICAgW1RyYWNlcG9pbnQg
ZXZlbnRdDQoNCiAgc2R0X3FlbXU6cW1wX2Jsb2NrX2pvYl9kaXNtaXNzICAgICAgICAgICAgICAg
ICAgICAgW1NEVCBldmVudF0NCiAgc2R0X3FlbXU6cW1wX2pvYl9kaXNtaXNzICAgICAgICAgICAg
ICAgICAgICAgICAgICAgW1NEVCBldmVudF0NCg0KTWV0cmljIEdyb3VwczoNCg0KW3Jvb3RAcXVh
Y28gcGVyZl0jDQoNCkhlcmUsIHVzaW5nIGl0Og0KDQpbcm9vdEBxdWFjbyBwZXJmXSMgcGVyZiBz
dGF0IC1JIDEwMDAgLWUgbXNyL3NtaS8NCiMgICAgICAgICAgIHRpbWUgICAgICAgICAgICAgY291
bnRzIHVuaXQgZXZlbnRzDQogICAgIDEuMDAwOTE5ODE5ICAgICAgICAgICAgICAgICAgMCAgICAg
IG1zci9zbWkvICAgICAgICAgICAgICAgICANCiAgICAgMi4wMDE2ODk5NTAgICAgICAgICAgICAg
ICAgICAwICAgICAgbXNyL3NtaS8gICAgICAgICAgICAgICAgIA0KICAgICAzLjAwMjI2Njk4OCAg
ICAgICAgICAgICAgICAgIDAgICAgICBtc3Ivc21pLyAgICAgICAgICAgICAgICAgDQogICAgIDQu
MDAzMDQ5NDM5ICAgICAgICAgICAgICAgICAxNiAgICAgIG1zci9zbWkvICAgICAgICAgICAgICAg
ICANCiAgICAgNS4wMDM2NzYwNjQgICAgICAgICAgICAgICAgICAwICAgICAgbXNyL3NtaS8gICAg
ICAgICAgICAgICAgIA0KICAgICA2LjAwNDQyMDYxMyAgICAgICAgICAgICAgICAgMTYgICAgICBt
c3Ivc21pLyAgICAgICAgICAgICAgICAgDQpeQyAgICAgNi42MDk0MDU2NjYgICAgICAgICAgICAg
ICAgICAwICAgICAgbXNyL3NtaS8gICAgICAgICAgICAgICAgIA0KDQpbcm9vdEBxdWFjbyBwZXJm
XSMgDQoNCg0KSW4gdGhpcyBMZW5vdm8gVDQ4MHMgSSBnZW5lcmF0ZSBTTUlzIGJ5IHByZXNzaW5n
IHRoZSBtdXRlIGJ1dHRvbiA6LSkNCg0KLSBBcm5hbGRvDQo=
