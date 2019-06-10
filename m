Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCFCC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 11:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AE020859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 11:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbfFJLJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 07:09:01 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:58955 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbfFJLJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 07:09:00 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x5AB7oe5003271
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Jun 2019 20:07:51 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x5AB7o41027936;
        Mon, 10 Jun 2019 20:07:50 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x5AB7od7014667;
        Mon, 10 Jun 2019 20:07:50 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.138] [10.38.151.138]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-5831018; Mon, 10 Jun 2019 20:07:06 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC10GP.gisp.nec.co.jp ([10.38.151.138]) with mapi id 14.03.0319.002; Mon,
 10 Jun 2019 20:07:05 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Borislav Petkov <bp@alien8.de>, Kairui Song <kasong@redhat.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] x86/kexec: Add ACPI NVS region to the ident map
Thread-Topic: [PATCH] x86/kexec: Add ACPI NVS region to the ident map
Thread-Index: AQHVH19SHHg08a6VFkmqhGhz4rJYp6aUDqEAgAAHiwCAAAt/gIAAAfyA
Date:   Mon, 10 Jun 2019 11:07:05 +0000
Message-ID: <1555938c-e00f-d40f-5f24-146aec7a67eb@ce.jp.nec.com>
References: <20190610073617.19767-1-kasong@redhat.com>
 <20190610095150.GA5488@zn.tnic>
 <CACPcB9f-sussXaOuOau6=CD85pS2KhcsknpJDQH_aEkwvLfvVA@mail.gmail.com>
 <20190610105959.GB5488@zn.tnic>
In-Reply-To: <20190610105959.GB5488@zn.tnic>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A92E1697A0430C4EB905863A22704E42@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2FpcnVpLCBCb3JpcywNCg0KT24gNi8xMC8xOSA3OjU5IFBNLCBCb3Jpc2xhdiBQZXRrb3Yg
d3JvdGU6DQo+IE9uIE1vbiwgSnVuIDEwLCAyMDE5IGF0IDA2OjE4OjUwUE0gKzA4MDAsIEthaXJ1
aSBTb25nIHdyb3RlOg0KPj4gSGkgQm9yaXMsIHVuZm9ydHVuYXRlbHkgSSBkb24ndCBoYXZlIGEg
cmVhbCBtYWNoaW5lIHdoaWNoIG9ubHkgaGF2ZQ0KPj4gdGhlIE5WUyByZWdpb24uIEkgZGlkIGZh
a2UgdGhlIG1lbW1hcCB0byBlbXVsYXRlIHN1Y2ggcHJvYmxlbSBidXQNCj4+IGNhbid0IHJlYWxs
eSBwcm9taXNlIHRoaXMgd2lsbCBmaXggdGhlIHJlYWwgY2FzZS4gU28ganVzdCBkZWNsYXJlIGl0
DQo+PiB3b24ndCBicmVhayBhbnl0aGluZyB0aGF0IGlzIGFscmVhZHkgd29ya2luZy4gQW5kIEkn
bSBhc2tpbmcgSnVuaWNoaQ0KPj4gdG8gaGF2ZSBhIHRyeSBhcyBoZSByZXBvcnRlZCB0aGlzIGlz
c3VlIG9uIHRoZSBtYWNoaW5lcyBoZSBoYXMuDQo+IA0KPiBZZXMsIHRoaXMgaXMgaG93IHlvdSBz
aG91bGQgZG8gaXQuIEZpcnN0IHlvdSB0ZXN0IG9uIGEgcmVhbCBoYXJkd2FyZSAtDQo+IGlmIHRo
ZSBpc3N1ZSBpcyBzdWNoIHRoYXQgbmVlZHMgYSByZWFsIGhhcmR3YXJlIHRvIHZlcmlmeSAtIGFu
ZCBpZiBpdA0KPiBwYXNzZXMsICp0aGVuKiB5b3Ugc2VuZCB0aGUgcGF0Y2guDQo+IA0KPiBJZiB5
b3UgZG9uJ3QgaGF2ZSBhY2Nlc3MgdG8gdGhlIGJveCwgdGhlbiBhc2sgc29tZW9uZSB3aG8gaGFz
Lg0KPiANCj4gQnV0IGZvciB0aGUgZnV0dXJlLCBwbGVhc2UgZG8gbm90IHNlbmQgdW50ZXN0ZWQg
cGF0Y2hlcyBpbiBhIGh1cnJ5LA0KPiBob3BpbmcgdGhhdCB0aGV5IHdvdWxkIHdvcmsuIFRoaXMg
Y291bGQgY2F1c2UgbW9yZSB0cm91YmxlIHRoYW4gdGhlDQo+IGxpdHRsZSB0aW1lIHlvdSBtaWdo
dCBzYXZlIHNwZWN1bGF0aW5nIGl0J2xsIGFsbCBnbyBmaW5lLg0KDQpJIHRlc3RlZCB0aGUgcGF0
Y2ggb24gc3VjaCBhIG1hY2hpbmUgb24gdG9wIG9mIHRoZSBjdXJyZW50IHRpcC9tYXN0ZXINCmY5
ODE4OTUwODQ4ICgiTWFyZ2UgYnJhbmNoICdsaW51cyciKSBhbmQgaXQgd29ya3MgZmluZS4NCldp
dGhvdXQgdGhlIHBhdGNoLCBrZXhlYyAtbCBmYWlscy4NCg0KSSBoYWQgdGVzdGVkIHRoZSB2ZXJz
aW9uIEkgcG9zdGVkIGhlcmUgb24gYnVuY2ggb2YgcGh5c2ljYWwgbWFjaGluZXMNCkkgaGFkIGFj
Y2VzcyBhbmQgY29uZmlybWVkIGl0IGRpZG4ndCBicm9rZSB3b3JraW5nIHNldHVwczoNCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxOTA1MTUwNTE3MTcuR0ExMzcwM0BqZXJ1LmxpbnV4
LmJzMS5mYy5uZWMuY28uanAvDQoNClNpbmNlIHRoZSBsb2dpYyBpbiB0aGUgcGF0Y2ggc2VlbXMg
dW5jaGFuZ2VkLCBJJ20gdmVyeSBzdXJlIGl0J3Mgb2suDQoNCi0tIA0KSnVuJ2ljaGkgTm9tdXJh
LCBORUMgQ29ycG9yYXRpb24gLyBORUMgU29sdXRpb24gSW5ub3ZhdG9ycywgTHRkLg==

