Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1EEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0C020685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfDWIqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:46:03 -0400
Received: from mail4.tencent.com ([183.57.53.109]:60225 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWIqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:46:03 -0400
Received: from EXHUB-SZMail03.tencent.com (unknown [10.14.6.33])
        by mail4.tencent.com (Postfix) with ESMTP id 46F45504FD;
        Tue, 23 Apr 2019 16:45:36 +0800 (CST)
Received: from EXMBX-SZMAIL025.tencent.com ([fe80::8dac:cfdc:cc02:7d7d]) by
 EXHUB-SZMail03.tencent.com ([::1]) with mapi id 14.03.0415.000; Tue, 23 Apr
 2019 16:45:36 +0800
From:   =?gb2312?B?YmVuYmppYW5nKL2vsesp?= <benbjiang@tencent.com>
To:     "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>
CC:     "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu/tree_exp: cleanup initialized but not used
 rdp(Internet mail)
Thread-Topic: [PATCH] rcu/tree_exp: cleanup initialized but not used
 rdp(Internet mail)
Thread-Index: AQHU+auFIENuP63FjkuExxuxqSbrKaZI6D0A
Date:   Tue, 23 Apr 2019 08:45:33 +0000
Message-ID: <EE593048-7443-49B6-B99E-E551AF2B7048@tencent.com>
References: <20190423012155.30606-1-benbjiang@tencent.com>
 <20190423080644.GC3923@linux.ibm.com>
In-Reply-To: <20190423080644.GC3923@linux.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.14.87.228]
Content-Type: text/plain; charset="gb2312"
Content-ID: <60A7EF6A5CFE194D945E12CC08CE6E25@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4g1NogMjAxOcTqNNTCMjPI1aOsz8LO5zQ6MDajrFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxt
Y2tAbGludXguaWJtLmNvbT4g0LS1wKO6DQo+IA0KPiBPbiBUdWUsIEFwciAyMywgMjAxOSBhdCAw
OToyMTo1NUFNICswODAwLCBKaWFuZyBCaWFvIHdyb3RlOg0KPj4gcmRwIGlzIGluaXRpYWxpemVk
IGJ1dCBuZXZlciB1c2VkIGluIHN5bmNocm9uaXplX3JjdV9leHBlZGl0ZWQoKSwNCj4+IGp1c3Qg
cmVtb3ZlIGl0Lg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBKaWFuZyBCaWFvIDxiZW5iamlhbmdA
dGVuY2VudC5jb20+DQo+IA0KPiBJIHF1ZXVlZCBhbmQgcHVzaGVkIGJvdGggcGF0Y2hlcyBmb3Ig
dGVzdGluZyBhbmQgcmV2aWV3LCBnb29kIGV5ZXMsDQo+IHRoYW5rIHlvdSEgIEkgcmV3b3JkZWQg
dGhlIHN1YmplY3QgYW5kIGNvbW1pdCBsb2dzLCBzbyBjb3VsZCB5b3UgcGxlYXNlDQo+IGNoZWNr
IHRvIG1ha2Ugc3VyZSB0aGF0IEkgZGlkbid0IG1lc3MgYW55dGhpbmcgdXA/DQo+IA0KPiAJCQkJ
CQkJVGhhbngsIFBhdWwNCj4gDQpBbHJlYWR5IGNoZWNrZWQsIGV2ZXJ5dGhpbmehr3MgZ29vZCB0
byBtZS4gVGhhbmtzIGEgbG90Lg0KSmlhbmcsDQoNCj4+IC0tLQ0KPj4ga2VybmVsL3JjdS90cmVl
X2V4cC5oIHwgMiAtLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+PiANCj4+
IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWVfZXhwLmggYi9rZXJuZWwvcmN1L3RyZWVfZXhw
LmgNCj4+IGluZGV4IDRjMmEwMTg5ZTc0OC4uNTc3MjYxMjM3OWU0IDEwMDY0NA0KPj4gLS0tIGEv
a2VybmVsL3JjdS90cmVlX2V4cC5oDQo+PiArKysgYi9rZXJuZWwvcmN1L3RyZWVfZXhwLmgNCj4+
IEBAIC03MzMsNyArNzMzLDYgQEAgc3RhdGljIHZvaWQgc3luY19zY2hlZF9leHBfb25saW5lX2Ns
ZWFudXAoaW50IGNwdSkNCj4+ICAqLw0KPj4gdm9pZCBzeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVk
KHZvaWQpDQo+PiB7DQo+PiAtCXN0cnVjdCByY3VfZGF0YSAqcmRwOw0KPj4gCXN0cnVjdCByY3Vf
ZXhwX3dvcmsgcmV3Ow0KPj4gCXN0cnVjdCByY3Vfbm9kZSAqcm5wOw0KPj4gCXVuc2lnbmVkIGxv
bmcgczsNCj4+IEBAIC03NzAsNyArNzY5LDYgQEAgdm9pZCBzeW5jaHJvbml6ZV9yY3VfZXhwZWRp
dGVkKHZvaWQpDQo+PiAJfQ0KPj4gDQo+PiAJLyogV2FpdCBmb3IgZXhwZWRpdGVkIGdyYWNlIHBl
cmlvZCB0byBjb21wbGV0ZS4gKi8NCj4+IC0JcmRwID0gcGVyX2NwdV9wdHIoJnJjdV9kYXRhLCBy
YXdfc21wX3Byb2Nlc3Nvcl9pZCgpKTsNCj4+IAlybnAgPSByY3VfZ2V0X3Jvb3QoKTsNCj4+IAl3
YWl0X2V2ZW50KHJucC0+ZXhwX3dxW3JjdV9zZXFfY3RyKHMpICYgMHgzXSwNCj4+IAkJICAgc3lu
Y19leHBfd29ya19kb25lKHMpKTsNCj4+IC0tIA0KPj4gMi4xNy4yIChBcHBsZSBHaXQtMTEzKQ0K
Pj4gDQo+IA0KPiANCg0K
