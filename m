Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A4DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D1C2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbfDXNol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:44:41 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:45158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730573AbfDXNoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:44:39 -0400
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 24782B446D772BE67D1F;
        Wed, 24 Apr 2019 21:44:36 +0800 (CST)
Received: from DGGEMI421-HUB.china.huawei.com (10.1.199.150) by
 dggemi402-hub.china.huawei.com (10.3.17.135) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 24 Apr 2019 21:44:35 +0800
Received: from DGGEMI530-MBX.china.huawei.com ([169.254.7.146]) by
 dggemi421-hub.china.huawei.com ([10.1.199.150]) with mapi id 14.03.0415.000;
 Wed, 24 Apr 2019 21:44:31 +0800
From:   weizhenliang <weizhenliang@huawei.com>
To:     Christian Brauner <christian@brauner.io>
CC:     "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "colona@arista.com" <colona@arista.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Re: [PATCH v4] signal: trace_signal_deliver when
 signal_group_exit
Thread-Topic: Re: [PATCH v4] signal: trace_signal_deliver when
 signal_group_exit
Thread-Index: AdT6omoJGuAXuaa4TgmwwsGmQ23m2A==
Date:   Wed, 24 Apr 2019 13:44:31 +0000
Message-ID: <AF4D908CC0E2A24EB308A26962C8C3BDEB1A17@DGGEMI530-MBX.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.99.192]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQvMjQsIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPk9uIFdlZCwgQXByIDI0LCAyMDE5
IGF0IDA4OjUyOjM4UE0gKzA4MDAsIFpoZW5saWFuZyBXZWkgd3JvdGU6DQo+PiANCj4+IEFja2Vk
LWJ5OiBDaHJpc3RpYW4gQnJhdW5lciA8Y2hyaXN0aWFuQGJyYXVuZXIuaW8+DQo+DQo+SSB0aGlu
ayB3ZSdyZSBzdXBwb3NlZCB0byB1c2UgbW9yZSBSZXZpZXdlZC1ieXMgc28gZmVlbCBmcmVlIChv
ciBBbmRyZXcpIHRvIGNoYW5nZSB0aGlzIHRvOg0KPg0KPlJldmlld2VkLWJ5OiBDaHJpc3RpYW4g
QnJhdW5lciA8Y2hyaXN0aWFuQGJyYXVuZXIuaW8+DQoNCk9rLCBJIHdpbGwgY2hhbmdlIHRoaXMg
aW4gcGF0Y2ggdjUuDQoNCj4+IC0tLSBhL2tlcm5lbC9zaWduYWwuYw0KPj4gKysrIGIva2VybmVs
L3NpZ25hbC5jDQo+PiBAQCAtMjQ0MSw2ICsyNDQxLDggQEAgYm9vbCBnZXRfc2lnbmFsKHN0cnVj
dCBrc2lnbmFsICprc2lnKQ0KPj4gIAlpZiAoc2lnbmFsX2dyb3VwX2V4aXQoc2lnbmFsKSkgew0K
Pj4gIAkJa3NpZy0+aW5mby5zaV9zaWdubyA9IHNpZ25yID0gU0lHS0lMTDsNCj4+ICAJCXNpZ2Rl
bHNldCgmY3VycmVudC0+cGVuZGluZy5zaWduYWwsIFNJR0tJTEwpOw0KPj4gKwkJdHJhY2Vfc2ln
bmFsX2RlbGl2ZXIoU0lHS0lMTCwgU0VORF9TSUdfTk9JTkZPLA0KPj4gKwkJCSZzaWdoYW5kLT5h
Y3Rpb25bc2lnbnIgLSAxXSk7DQo+DQo+SG0sIHNvcnJ5IGZvciBiZWluZyB0aGUgcmVhbGx5IG5p
dHBpY2t5IHBlcnNvbiBoZXJlLiBKdXN0IGZvciB0aGUgc2FrZSBvZiBjb25zaXN0ZW5jeSBob3cg
YWJvdXQgd2UgZG8gZWl0aGVyOg0KPg0KPisJCXRyYWNlX3NpZ25hbF9kZWxpdmVyKFNJR0tJTEws
IFNFTkRfU0lHX05PSU5GTywNCj4rCQkJJnNpZ2hhbmQtPmFjdGlvbltTSUdLSUxMIC0gMV0pOw0K
Pg0KPm9yDQo+DQo+KwkJdHJhY2Vfc2lnbmFsX2RlbGl2ZXIoc2lnbnIsIFNFTkRfU0lHX05PSU5G
TywNCj4rCQkJJnNpZ2hhbmQtPmFjdGlvbltzaWduciAtIDFdKTsNCj4NCj5JJ20gbm90IGdvaW5n
IHRvIGFyZ3VlIGFib3V0IHRoaXMgdGhvdWdoLiBDYW4ganVzdCBhbHNvIGxlYXZlIGl0IGFzIGlz
Lg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMgYW5kIGxlYXJuIGZyb20gcmlnb3JvdXMg
cGVvcGxlISBJIHdpbGwgdGFrZToNCg0KKwkJdHJhY2Vfc2lnbmFsX2RlbGl2ZXIoU0lHS0lMTCwg
U0VORF9TSUdfTk9JTkZPLA0KKwkJCSZzaWdoYW5kLT5hY3Rpb25bU0lHS0lMTCAtIDFdKTsNCg0K
QW55IG90aGVyIHN1Z2dlc3Rpb25zIGFib3V0IHRoZSBwYXRjaD8NCg0KV2VpDQo=
