Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099B2C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4400214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="siHC5Sv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfLLJr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:47:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:7967 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726382AbfLLJr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:47:57 -0500
X-UUID: 6e79bea5163d41eeb21e4f5f05621e07-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=jjUFyhr70q5Qwl+cMOFBMZpPatFW/kw0aENfH71RXPE=;
        b=siHC5Sv0bod7DC+uDh1agxAwNc0q3H+wb4uE/xWH/GaNfvZ1ubRB4K18lY+N771dFzHAX7D+5JpH9d7HLI2FBrWocJ9n832TbQZCpDb/eTNCTeTCUlWZQphEiGO5i3i/rZXp8ZxNRT7QNzM4qiSIvhnbe1FrMg6LlAC6/GEc3Ww=;
X-UUID: 6e79bea5163d41eeb21e4f5f05621e07-20191212
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1503291767; Thu, 12 Dec 2019 17:47:50 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 17:47:29 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 17:47:46 +0800
Message-ID: <1576144069.16442.3.camel@mtksdaap41>
Subject: Re: [PATCH v17 0/6] support gce on mt8183 platform
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>,
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
Date:   Thu, 12 Dec 2019 17:47:49 +0800
In-Reply-To: <cb5cd58e-dc62-ae30-9ddd-7c2b95fde3e3@gmail.com>
References: <20191121015410.18852-1-bibby.hsieh@mediatek.com>
         <CANMq1KCTJQL+GFqo8HYM8cEpzXJmebJ=9ju4CzHLwyuQfbZEAA@mail.gmail.com>
         <cb5cd58e-dc62-ae30-9ddd-7c2b95fde3e3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTEyLTEyIGF0IDA4OjQ5ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTEvMTIvMjAxOSAyMzowOSwgTmljb2xhcyBCb2ljaGF0IHdyb3RlOg0KPiA+
IEhpIE1hdHRoaWFzLA0KPiA+IA0KPiA+IFF1aWNrIHF1ZXN0aW9uLCBhbnkgcmVhc29uIHlvdSBw
aWNrZWQgb25seSBwYXRjaGVzIDIrMys2IGZyb20gdGhpcw0KPiA+IHNlcmllcywgYW5kIG5vdCB0
aGUgMyBvdGhlcnM/DQo+ID4gDQo+IA0KPiBUaGUgcXVpY2sgYW5zd2VyLCB0aW1lIDopDQo+IFRo
ZSBsb25nZXIgb25lOg0KPiAxLzYgd2VudCBhbHJlYWR5IGluIHRocm91Z2ggZml4ZXMgZm9yIHY1
LjQNCj4gNC82IGl0IHRvdWNoZXMgbWFpbGJveCBjb2RlLCBzbyB3ZSB3aWxsIG5lZWQgYSBhY2tl
ZC1ieSBmcm9tIEphc3NpDQoNCkhpLCBKYXNzaSwNCg0KU29ycnkgZm9yIHRoZSBtYWlsaW5nIGxv
c2luZy4NCkNvdWxkIHlvdSBoZWxwIG1lIHRvIHJldmlldyBbUEFUQ0ggNC82IHNvYzogbWVkaWF0
ZWs6IGNtZHE6IGFkZCBwb2xsaW5nDQpmdW5jdGlvbl0gaWYgeW91IGFyZSBmcmVlPw0KDQpCaWJi
eQ0KDQo+IDUvNiB0aW1lLCBJIHdhbnQgdG8gaGF2ZSBhIGJldHRlciBsb29rIG9udG8gdGhpcyB0
byBzZWUgaWYgdGhhdCBtYWtlcyBzZW5zZSAoSQ0KPiBzbGlnaHRseSByZW1lbWJlciBzb21lIG9s
ZCBjb21tZW50IEkgaGFkIG9uIHRoaXMpDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KPiAN
Cj4gPiBUaGFua3MuDQo+ID4gDQo+ID4gT24gV2VkLCBOb3YgMjAsIDIwMTkgYXQgNTo1NCBQTSBC
aWJieSBIc2llaCA8YmliYnkuaHNpZWhAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4g
Q2hhbmdlcyBzaW5jZSB2MTY6DQo+ID4+ICAtIG5hbWluZyB0aGUgcG9sbCBtYXNrIGVuYWJsZSBi
aXQNCj4gPj4gIC0gYWRkIGEgcGF0Y2ggdG8gZml1cCB0aGUgaW5wdXQgb3JkZXIgb2Ygd3JpdGUg
YXBpDQo+ID4+DQo+ID4+IENoYW5nZXMgc2luY2UgdjE1Og0KPiA+PiAgLSByZWJhc2Ugb250byA1
LjQtcmMxDQo+ID4+ICAtIHJvbGxiYWNrIHRoZSB2MTQgY2hhbmdlDQo+ID4+ICAtIGFkZCBhIHBh
dGNoIHRvIGZpeHVwIHRoZSBjb21iaW5hdGlvbiBvZiByZXR1cm4gdmFsdWUNCj4gPj4NCj4gPj4g
Q2hhbmdlcyBzaW5jZSB2MTQ6DQo+ID4+ICAtIGNoYW5nZSBpbnB1dCBhcmd1bWVudCBhcyBwb2lu
dGVyIGluIGFwcGVuZF9jb21tZW5kKCkNCj4gPj4NCj4gPj4gQ2hhbmdlcyBzaW5jZSB2MTM6DQo+
ID4+ICAtIHNlcGFyYXRlIHBvbGwgZnVuY3Rpb24gYXMgcG9sbCB3LyAmIHcvbyBtYXNrIGZ1bmN0
aW9uDQo+ID4+ICAtIGRpcmVjdGx5IHBhc3MgaW5zdCBpbnRvIGFwcGVuZF9jb21tYW5kIGZ1bmN0
aW9uIGluc3RlYWQNCj4gPj4gICAgb2YgcmV0dXJucyBhIHBvaW50ZXINCj4gPj4gIC0gZml4dXAg
Y29kaW5nIHN0eWxlDQo+ID4+ICAtIHJlYmFzZSBvbnRvIDUuMy1yYzENCj4gPj4NCj4gPj4gWy4u
LiBzbmlwIC4uLl0NCj4gPj4NCj4gPj4gQmliYnkgSHNpZWggKDYpOg0KPiA+PiAgIHNvYzogbWVk
aWF0ZWs6IGNtZHE6IGZpeHVwIHdyb25nIGlucHV0IG9yZGVyIG9mIHdyaXRlIGFwaQ0KPiA+PiAg
IHNvYzogbWVkaWF0ZWs6IGNtZHE6IHJlbW92ZSBPUiBvcGVydGFpb24gZnJvbSBlcnIgcmV0dXJu
DQo+ID4+ICAgc29jOiBtZWRpYXRlazogY21kcTogZGVmaW5lIHRoZSBpbnN0cnVjdGlvbiBzdHJ1
Y3QNCj4gPj4gICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgcG9sbGluZyBmdW5jdGlvbg0KPiA+
PiAgIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBjbWRxX2Rldl9nZXRfY2xpZW50X3JlZyBmdW5j
dGlvbg0KPiA+PiAgIGFybTY0OiBkdHM6IGFkZCBnY2Ugbm9kZSBmb3IgbXQ4MTgzDQo+ID4+DQo+
ID4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpIHwgIDEwICsrDQo+
ID4+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwgMTQ3ICsrKysr
KysrKysrKysrKysrKystLS0tDQo+ID4+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEt
bWFpbGJveC5oIHwgIDExICsrDQo+ID4+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGst
Y21kcS5oICAgIHwgIDUzICsrKysrKysrDQo+ID4+ICA0IGZpbGVzIGNoYW5nZWQsIDE5NSBpbnNl
cnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gLS0NCj4gPj4gMi4xOC4wDQoN
Cg==

