Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4C1C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A40C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfDVO5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:57:07 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2991 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbfDVO5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:57:06 -0400
Received: from dggemi406-hub.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 6C2F2CDAE404ADF4B314;
        Mon, 22 Apr 2019 22:56:11 +0800 (CST)
Received: from DGGEMI530-MBX.china.huawei.com ([169.254.7.146]) by
 dggemi406-hub.china.huawei.com ([10.3.17.144]) with mapi id 14.03.0399.000;
 Mon, 22 Apr 2019 22:56:06 +0800
From:   weizhenliang <weizhenliang@huawei.com>
To:     Christian Brauner <christian@brauner.io>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "colona@arista.com" <colona@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] signal: trace_signal_deliver when signal_group_exit
Thread-Topic: [PATCH v2] signal: trace_signal_deliver when signal_group_exit
Thread-Index: AdT4/f2TUdzcmSVWTieuaenNlJkeog==
Date:   Mon, 22 Apr 2019 14:56:05 +0000
Message-ID: <AF4D908CC0E2A24EB308A26962C8C3BDEB152A@DGGEMI530-MBX.china.huawei.com>
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

T24gTW9uLCBBcHIgMjIsIDIwMTkgYXQgNjozNyBQTSBDaHJpc3RpYW4gQnJhdW5lciA8bWFpbHRv
OmNocmlzdGlhbkBicmF1bmVyLmlvPiB3cm90ZToNCj5PbiBNb24sIEFwciAyMiwgMjAxOSBhdCA4
OjU3IEFNIFpoZW5saWFuZyBXZWkgPHdlaXpoZW5saWFuZ0BodWF3ZWkuY29tPiB3cm90ZToNCj4+
DQo+PiBJbiB0aGUgZm9sbG93aW5nIGNvbW1pdCwgcmVtb3ZpbmcgU0lHS0lMTCBmcm9tIGVhY2gg
dGhyZWFkIHNpZ25hbCBtYXNrIA0KPj4gYW5kIGV4ZWN1dGluZyAiZ290byBmYXRhbCIgZGlyZWN0
bHkgd2lsbCBza2lwIHRoZSBjYWxsIHRvIA0KPj4gInRyYWNlX3NpZ25hbF9kZWxpdmVyIi4gQXQg
dGhpcyBwb2ludCwgdGhlIGRlbGl2ZXJ5IHRyYWNraW5nIG9mIHRoZSANCj4+IFNJR0tJTEwgc2ln
bmFsIHdpbGwgYmUgaW5hY2N1cmF0ZS4NCj4+DQo+PiBjb21taXQgY2Y0M2E3NTdmZDQ5NDQgKCJz
aWduYWw6IFJlc3RvcmUgdGhlIHN0b3AgUFRSQUNFX0VWRU5UX0VYSVQiKQ0KPj4NCj4+IFRoZXJl
Zm9yZSwgd2UgbmVlZCB0byBhZGQgdHJhY2Vfc2lnbmFsX2RlbGl2ZXIgYmVmb3JlICJnb3RvIGZh
dGFsIg0KPj4gYWZ0ZXIgZXhlY3V0aW5nIHNpZ2RlbHNldC4NCj4+DQo+PiBOb3RlOiBUaGUgYWN0
aW9uW1NJR0tJTExdIG11c3QgYmUgU0lHX0RGTCwgYW5kIFNFTkRfU0lHX05PSU5GTyBtYXRjaGVz
IA0KPj4gdGhlIGZhY3QgdGhhdCBTSUdLSUxMIGRvZXNuJ3QgaGF2ZSBhbnkgaW5mby4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBaaGVubGlhbmcgV2VpIDx3ZWl6aGVubGlhbmdAaHVhd2VpLmNvbT4N
Cj4NCj5KdXN0IGEgbml0IGJlbG93IG90aGVyd2lzZQ0KPg0KPkFja2VkLWJ5OiBDaHJpc3RpYW4g
QnJhdW5lciA8Y2hyaXN0aWFuQGJyYXVuZXIuaW8+DQo+DQo+WW91IHNob3VsZCBwcm9iYWJseSBt
YWtlIHRoZSBsaW5lOg0KPmNvbW1pdCBjZjQzYTc1N2ZkNDk0NCAoInNpZ25hbDogUmVzdG9yZSB0
aGUgc3RvcCBQVFJBQ0VfRVZFTlRfRVhJVCIpIGEgRml4ZXMtbGluZSByaWdodCBhYm92ZSB5b3Vy
IGNvbW1pdDoNCj5GaXhlcyBjZjQzYTc1N2ZkNDk0NCAoInNpZ25hbDogUmVzdG9yZSB0aGUgc3Rv
cCBQVFJBQ0VfRVZFTlRfRVhJVCIpDQo+DQo+PiAtLS0NCj4+ICBrZXJuZWwvc2lnbmFsLmMgfCAx
ICsNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEva2VybmVsL3NpZ25hbC5jIGIva2VybmVsL3NpZ25hbC5jIGluZGV4IA0KPj4gMjI3YmExNzAy
OThlLi4wZjY5YWRhMzc2ZWYgMTAwNjQ0DQo+PiAtLS0gYS9rZXJuZWwvc2lnbmFsLmMNCj4+ICsr
KyBiL2tlcm5lbC9zaWduYWwuYw0KPj4gQEAgLTI0NDEsNiArMjQ0MSw3IEBAIGJvb2wgZ2V0X3Np
Z25hbChzdHJ1Y3Qga3NpZ25hbCAqa3NpZykNCj4+ICAgICAgICAgaWYgKHNpZ25hbF9ncm91cF9l
eGl0KHNpZ25hbCkpIHsNCj4+ICAgICAgICAgICAgICAgICBrc2lnLT5pbmZvLnNpX3NpZ25vID0g
c2lnbnIgPSBTSUdLSUxMOw0KPj4gICAgICAgICAgICAgICAgIHNpZ2RlbHNldCgmY3VycmVudC0+
cGVuZGluZy5zaWduYWwsIFNJR0tJTEwpOw0KPj4gKyAgICAgICAgICAgICAgIHRyYWNlX3NpZ25h
bF9kZWxpdmVyKFNJR0tJTEwsIFNFTkRfU0lHX05PSU5GTywgDQo+PiArIFNJR19ERkwpOw0KPj4g
ICAgICAgICAgICAgICAgIHJlY2FsY19zaWdwZW5kaW5nKCk7DQo+PiAgICAgICAgICAgICAgICAg
Z290byBmYXRhbDsNCj4+ICAgICAgICAgfQ0KPj4gLS0NCj4+IDIuMTQuMS53aW5kb3dzLjENCj4+
DQo+Pg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIEkgd2lsbCBhZGp1c3QgdGhlIGNvbW1p
dCBtc2cgYW5kIHJlc2VuZCB0aGUgcGF0Y2ggYWNjb3JkaW5nIHRvIHlvdXIgc3VnZ2VzdGlvbnMu
DQpJZiB0aGVyZSBhcmUgb3RoZXIgc3VnZ2VzdGlvbnMsIHBsZWFzZSBsZXQgbWUga25vdy4gVGhh
bmtzIGFnYWlufg0KDQpaaGVubGlhbmcgV2VpLg0K
