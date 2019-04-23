Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F49C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B91320645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfDWOCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:02:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbfDWOCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:02:32 -0400
Received: from dggemi401-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 4EFF179E4F69FBEFC053;
        Tue, 23 Apr 2019 22:02:26 +0800 (CST)
Received: from DGGEMI422-HUB.china.huawei.com (10.1.199.151) by
 dggemi401-hub.china.huawei.com (10.3.17.134) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 23 Apr 2019 22:02:25 +0800
Received: from DGGEMI530-MBX.china.huawei.com ([169.254.7.146]) by
 dggemi422-hub.china.huawei.com ([10.1.199.151]) with mapi id 14.03.0399.000;
 Tue, 23 Apr 2019 22:02:21 +0800
From:   weizhenliang <weizhenliang@huawei.com>
To:     Christian Brauner <christian@brauner.io>
CC:     Oleg Nesterov <oleg@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "colona@arista.com" <colona@arista.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] signal: trace_signal_deliver when signal_group_exit
Thread-Topic: [PATCH v3] signal: trace_signal_deliver when signal_group_exit
Thread-Index: AdT53KXPKZ/rlwOkQKWG95RpVhMV9Q==
Date:   Tue, 23 Apr 2019 14:02:21 +0000
Message-ID: <AF4D908CC0E2A24EB308A26962C8C3BDEB16D1@DGGEMI530-MBX.china.huawei.com>
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

T24gVHVlLCBBcHIgMjMsIDIwMTkgYXQgMDk6NDEgUE0gQ2hyaXN0aWFuIHdyb3RlOg0KPk9uIFR1
ZSwgQXByIDIzLCAyMDE5IGF0IDAxOjEwOjUyUE0gKzAwMDAsIHdlaXpoZW5saWFuZyB3cm90ZToN
Cj4+IE9uIE1vbiwgQXByIDIyLCAyMDE5IGF0IDExOjI1IFBNIE9sZWcgTmVzdGVyb3YgPG9sZWdA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+PiA+T24gMDQvMjIsIFpoZW5saWFuZyBXZWkgd3JvdGU6DQo+
PiA+Pg0KPj4gPj4gLS0tIGEva2VybmVsL3NpZ25hbC5jDQo+PiA+PiArKysgYi9rZXJuZWwvc2ln
bmFsLmMNCj4+ID4+IEBAIC0yNDQxLDYgKzI0NDEsNyBAQCBib29sIGdldF9zaWduYWwoc3RydWN0
IGtzaWduYWwgKmtzaWcpDQo+PiA+PiAgCWlmIChzaWduYWxfZ3JvdXBfZXhpdChzaWduYWwpKSB7
DQo+PiA+PiAgCQlrc2lnLT5pbmZvLnNpX3NpZ25vID0gc2lnbnIgPSBTSUdLSUxMOw0KPj4gPj4g
IAkJc2lnZGVsc2V0KCZjdXJyZW50LT5wZW5kaW5nLnNpZ25hbCwgU0lHS0lMTCk7DQo+PiA+PiAr
CQl0cmFjZV9zaWduYWxfZGVsaXZlcihTSUdLSUxMLCBTRU5EX1NJR19OT0lORk8sIFNJR19ERkwp
Ow0KPj4gPj4gIAkJcmVjYWxjX3NpZ3BlbmRpbmcoKTsNCj4+ID4+ICAJCWdvdG8gZmF0YWw7DQo+
PiA+PiAgCX0NCj4+ID4NCj4+ID5SZXZpZXdlZC1ieTogT2xlZyBOZXN0ZXJvdiA8b2xlZ0ByZWRo
YXQuY29tPg0KPj4gDQo+PiBMYXN0IHRpbWUgT2xlZyBzdWdnZXN0ZWQgdXNpbmcgU0lHX0RGTCBh
cyB0aGUgdGhpcmQgcGFyYW1ldGVyLCBidXQgaXRzIHR5cGUgaXMgJ3ZvaWQgKCopKGludCknLCBi
dXQgbm90IGV4cGVjdGVkICdzdHJ1Y3Qga19zaWdhY3Rpb24gKicuDQo+DQo+U2lnaCwgSSBzaG91
bGQndmUgY2F1Z2h0IHRoYXQgaW4gdGhlIGZpcnN0IGNvbW1pdC4NCj5BbHRob3VnaCBpdCBzdWdn
ZXN0cyB5b3UgZGlkbid0IGV2ZW4gY29tcGlsZSB5b3VyIHBhdGNoLi4uDQo+DQo+PiANCj4+IEhv
dyBhYm91dA0KPj4gCXRyYWNlX3NpZ25hbF9kZWxpdmVyKFNJR0tJTEwsIFNFTkRfU0lHX05PSU5G
TywgJnNpZ2hhbmQtPmFjdGlvbltzaWduciANCj4+IC0gMV0pOyA/DQo+DQo+VGhhdCBzaG91bGQg
d29yaywgeWVzLg0KDQpTb3JyeSBhYm91dCB0aGF0LCBJIHdhcyB0b28gZm9jdXNlZCBvbiB0aGUg
ZnVuY3Rpb25hbGl0eSBhbmQgZGlkbid0IG5vdGljZSB0aGUgY29tcGlsZSB3YXJuaW5nLg0KQW5k
IHRoYW5rcyBmb3IgeW91ciByZXBseSwgSSB3aWxsIHBheSBtb3JlIGF0dGVudGlvbiB0byBpdCBp
biB0aGUgZnV0dXJlLg0KDQpaaGVubGlhbmcgV2VpDQo=
