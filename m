Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DA2C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 02:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147D72175B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 02:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388612AbfDYCJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 22:09:05 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2995 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728744AbfDYCJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 22:09:05 -0400
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 56BC7ADEEB07BAC5BE17;
        Thu, 25 Apr 2019 10:09:03 +0800 (CST)
Received: from DGGEMI530-MBX.china.huawei.com ([169.254.7.146]) by
 dggemi403-hub.china.huawei.com ([10.3.17.136]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 10:08:59 +0800
From:   weizhenliang <weizhenliang@huawei.com>
To:     Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>
CC:     "ebiederm@xmission.com" <ebiederm@xmission.com>,
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
Thread-Index: AdT7CacHunsFVT1GTeOOIJe3X18fmw==
Date:   Thu, 25 Apr 2019 02:08:58 +0000
Message-ID: <AF4D908CC0E2A24EB308A26962C8C3BDEB1ADF@DGGEMI530-MBX.china.huawei.com>
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

T24gMDQvMjUgQ2hyaXN0aWFuIHdyb3RlOg0KPk9uIFdlZCwgQXByIDI0LCAyMDE5IGF0IDY6MTYg
UE0gT2xlZyBOZXN0ZXJvdiA8b2xlZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4+DQo+PiBPbiAwNC8y
NCwgd2VpemhlbmxpYW5nIHdyb3RlOg0KPj4gPg0KPj4gPiBPbiAwNC8yNCwgT2xlZyB3cm90ZToN
Cj4+ID4gPk9uIDA0LzI0LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4+ID4gPj4NCj4+ID4g
Pj4gT24gV2VkLCBBcHIgMjQsIDIwMTkgYXQgMDg6NTI6MzhQTSArMDgwMCwgWmhlbmxpYW5nIFdl
aSB3cm90ZToNCj4+ID4gPj4NCj4+ID4gPj4gPiBSZXZpZXdlZC1ieTogT2xlZyBOZXN0ZXJvdiA8
b2xlZ0ByZWRoYXQuY29tPg0KPj4gPiA+DQo+PiA+ID5ZZXMsIGJ1dCAuLi4NCj4+ID4gPg0KPj4g
PiA+PiA+IFJlcG9ydGVkLWJ5OiBrYnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4+
ID4gPg0KPj4gPiA+SG1tLCByZWFsbHk/DQo+PiA+DQo+PiA+IFllcywgdGhlIGtidWlsZCB0ZXN0
IHJvYm90IHNheXMgdGhhdCBpZiBJIGZpeCB0aGUgcHJvYmxlbSB3aXRoIHRoZSANCj4+ID4gdGhp
cmQgcGFyYW1ldGVyIHR5cGUsIEkgc2hvdWxkIGFkZCB0aGlzIHRhZy4gV2hhdCBpcyB3cm9uZyBv
ciBtaXNzaW5nPw0KPj4NCj4+IEJ1dCB0aGlzIHBhdGNoIGRvZXMgbm90IGZpeCB0aGUgcHJvYmxl
bSByZXBvcnRlZCBieSByb2JvdCwgeW91ciBwYXRjaCANCj4+ICh3aGljaCBpbnRyb2R1Y2VkIHRo
YXQgcHJvYmxlbSkgd2FzIGRyb3BwZWQsIHRoZSBwcm9ibGVtIGhhcyBnb25lLg0KPj4NCj4+IFdp
dGggdGhpcyAiUmVwb3J0ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPiIg
dGFnIGl0IA0KPj4gbG9va3MgYXMgaWYgdGVzdC1yb2JvdCBoYXMgZm91bmQgdGhlIHByb2JsZW0g
eW91IGFyZSB0cnlpbmcgdG8gZml4OiANCj4+IHRoZSBsYWNrIG9mIHRyYWNlX3NpZ25hbF9kZWxp
dmVyKFNJR0tJTEwpLg0KPg0KPlllYWgsIE9sZWcncyBhYnNvbHV0ZWx5IHJpZ2h0LiBUaGF0IHRh
ZyBzaG91bGQganVzdCBnby4NCj5UaGUgRml4ZXMgbGluZSBpcyBhbGwgdGhhdCB3ZSB3YW50LCBJ
IHRoaW5rLg0KDQpHb3QgaXQgfiANClRoYW5rIHlvdSAoT2xlZyBhbmQgQ2hyaXN0aWFuKSBmb3Ig
dGhlIGtpbmQgZ3VpZGFuY2UNCkFuZCBJIHdpbGwgdXBkYXRlIHRoZSBwYXRjaCBhcyBzb29uIGFz
IHBvc3NpYmxlDQoNCldlaS4NCg==
