Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08351C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FA52084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDLA52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 20:57:28 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2477 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfDLA52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 20:57:28 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id BFC2B3EA51BC2F215F54;
        Fri, 12 Apr 2019 08:57:25 +0800 (CST)
Received: from DGGEML502-MBX.china.huawei.com ([169.254.2.153]) by
 dggeml406-hub.china.huawei.com ([10.3.17.50]) with mapi id 14.03.0415.000;
 Fri, 12 Apr 2019 08:57:24 +0800
From:   Linhaifeng <haifeng.lin@huawei.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: perf tools:Is there any tools  to found out the max latency by irq
 or cpu idle 
Thread-Topic: perf tools:Is there any tools  to found out the max latency by
 irq or cpu idle 
Thread-Index: AdTwypFCWbA+6SJGRxm1JN4pevZ4ZA==
Date:   Fri, 12 Apr 2019 00:57:24 +0000
Message-ID: <4099DE2E54AFAD489356C6C9161D53339591D64A@DGGEML502-MBX.china.huawei.com>
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

SGksIA0KSSBoYXZlIGEgc2luZ2xlIHRocmVhZCBhcHBsaWNhdGlvbiBsaWtlIHRoaXM6DQoNCldo
aWxlICgxKSB7DQrCoMKgwqAgc3RhcnQgPSByZHRzYygpOw0KwqDCoMKgIHNxcnQgKDEwMjQpO8Kg
wqDCoMKgwqAgDQrjgIDjgIBlbmQgPSByZHRzYygpOw0K44CA44CAY3ljbGVzID0gZW5kIOKAkyBz
dGFydDsNCuOAgOOAgHByaW50ZigiY3ljbGVzOiAlZC0lMDJkLSUwMmQgJTAyZDolMDJkOiUwMmQ6
ICVsdVxuIiwgDQrjgIDjgIDjgIDjgIDjgIDjgIAxOTAwK3RpbWVpbmZvLT50bV95ZWFyLCAxK3Rp
bWVpbmZvLT50bV9tb24sIHRpbWVpbmZvLT50bV9tZGF5LCB0aW1laW5mby0+dG1faG91ciwgdGlt
ZWluZm8tPnRtX21pbiwgdGltZWluZm8tPnRtX3NlYywNCuOAgOOAgOOAgOOAgOOAgOOAgGN5Y2xl
cyk7DQp9DQpJdCBwcmludCB0aGUgY3ljbGVzIG9mIHNxcnQgZXZlcnkgc2Vjb25kIGFuZCBydW4g
d2l0aCB0YXNrc2V0IOKAk2MgMSAuL3NxcnQuDQpUaGUgcmVzdWx0IG9mIHRlc3QgaXM6DQoNCnNx
cnQgMjAxOS0wNC0xMCAyMzo1Mzo1MDogNDM5NjgNCnNxcnQgMjAxOS0wNC0xMCAyMzo1Mzo1MTog
NDQwNjANCnNxcnQgMjAxOS0wNC0xMCAyMzo1Mzo1MjogNDkwMTINCnNxcnQgMjAxOS0wNC0xMCAy
Mzo1Mzo1MzogMzgxNzINCnNxcnQgMjAxOS0wNC0xMCAyMzo1Mzo1NDogMTMxMDgxNDA4DQpzcXJ0
IDIwMTktMDQtMTAgMjM6NTM6NTU6IDQzNjAwDQpzcXJ0IDIwMTktMDQtMTAgMjM6NTM6NTY6IDQ2
NzA0DQpzcXJ0IDIwMTktMDQtMTAgMjM6NTM6NTc6IDQ2ODgwDQpzcXJ0IDIwMTktMDQtMTAgMjM6
NTM6NTg6IDQ0MzMyDQrigKbigKYNCnNxcnQgMjAxOS0wNC0xMCAwMjoxNzoxNTogMTMxMDgxNDA4
DQrigKbigKYNCnNxcnQgMjAxOS0wNC0xMCAwNDo0MDozNTogMTMxMDgxNDA4DQrigKbigKYNCg0K
RXZlcnkgMmhvdXIyM21pbiB0aGVyZSB3b3VsZCBiZSBhIGxhcmdlIGN5Y2xlcy4gSSB1c2UgcGVy
ZiBzY2hlZCBub3QgZm91bmQgYW55IHNjaGVkX3N3aXRjaCBldmVudHMuDQoNCkwyR1dfMjY4MDov
aG9tZS9mc3Avem4gIyBwZXJmIHNjaGVkIHJlY29yZCAtQyA2LTExIC1vIHBlcmYuc2NoZWQNCl5D
WyBwZXJmIHJlY29yZDogV29rZW4gdXAgNjQgdGltZXMgdG8gd3JpdGUgZGF0YSBdDQpbIHBlcmYg
cmVjb3JkOiBDYXB0dXJlZCBhbmQgd3JvdGUgMjA0Ljg3OCBNQiBwZXJmLnNjaGVkICgxOTExMTg5
IHNhbXBsZXMpIF0NCg0KTDJHV18yNjgwOi9ob21lL2ZzcC96biAjIHBlcmYgc2NoZWQgbGF0ZW5j
eSAtaSBwZXJmLnNjaGVkIA0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KwqAgVGFza8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgUnVudGltZSBtc8KgIHwgU3dpdGNoZXMgfCBBdmVyYWdlIGRlbGF5IG1zIHwg
TWF4aW11bSBkZWxheSBtcyB8IE1heGltdW0gZGVsYXkgYXTCoMKgwqDCoMKgwqAgfA0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQrCoCBU
T1RBTDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqAgMC4wMDAgbXMg
fCDCoMKgwqDCoMKgwqDCoDAgfA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQoNCg0KDQpJcyB0aGVyZSBhbnkgb3RoZXIgdG9vbHMgb2YgcGVyZiB0
byBmb3VuZCBvdXQgdGhlIG1heCBsYXRlbmN5IGJ5IGlycSBvciBjcHUgaWRsZSA/DQoNCg0K
