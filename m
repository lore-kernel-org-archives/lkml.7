Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D42C47409
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC1A21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RPUI1b+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfLRIAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:00:14 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:41727 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725797AbfLRIAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:00:12 -0500
X-UUID: ac71a844ec244869b2a8472310dabc50-20191218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=aNiLrGJZwK0lvEyneiSTQQEeAe5Qvk/0jbjSDQ3VN2c=;
        b=RPUI1b+aKYkqYxlxBVt65fXuDdhXfdF/maf7zJ6L0bciqcu7iis8vuM2Ih7e+vA7WboexmR9qy0/ysYZMLx63ZoYn3PISoparTcxqqGjXgGAqBOPW/j4rpYPRayXKuLjBK8w59SdXXg3UmnK3seFdvqYH13lvU+XNPvF31FgJ80=;
X-UUID: ac71a844ec244869b2a8472310dabc50-20191218
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1564332786; Wed, 18 Dec 2019 16:00:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 18 Dec 2019 15:59:48 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 18 Dec 2019 15:59:38 +0800
Message-ID: <1576656006.5933.3.camel@mtkswgap22>
Subject: Re: [PATCH v2 06/14] soc: mediatek: cmdq: return send msg error code
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 18 Dec 2019 16:00:06 +0800
In-Reply-To: <1575604966.6151.1.camel@mtksdaap41>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-8-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1575604966.6151.1.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmliYnksDQoNCk9uIEZyaSwgMjAxOS0xMi0wNiBhdCAxMjowMiArMDgwMCwgQmliYnkgSHNp
ZWggd3JvdGU6DQo+IE9uIFdlZCwgMjAxOS0xMS0yNyBhdCAwOTo1OCArMDgwMCwgRGVubmlzIFlD
IEhzaWVoIHdyb3RlOg0KPiA+IFJldHVybiBlcnJvciBjb2RlIHRvIGNsaWVudCBpZiBzZW5kIG1l
c3NhZ2UgZmFpbCwNCj4gPiBzbyB0aGF0IGNsaWVudCBoYXMgY2hhbmNlIHRvIGVycm9yIGhhbmRs
aW5nLg0KPiA+IA0KPiBUaGlzIHBhdGNoZXMgc2VlbXMgbGlrZSBhIGZpeCBwYXRjaC4NCj4gUGxl
YXNlIGFkZCBmaXhlcywgdGhhbmtzLg0KPiANCj4gQmliYnkNCg0KRG8geW91IG1lYW4gYWRkICpm
aXhlcyogaW4gdGl0bGU/DQpIb3cgYWJvdXQgKmZpeGVzIGZsdXNoIGFzeW5jIGZ1bmN0aW9uIHJl
dHVybiBlcnJvciB3aGVuIHNlbmQgZmFpbCogPw0KDQoNClJlZ2FyZHMsDQpEZW5uaXMNCg0KPiA+
IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0K
PiA+IGluZGV4IDI3NGY2ZjMxMWQwNS4uODQyMWI0MDkwMzA0IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gKysrIGIvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBAQCAtMzUzLDExICszNTMsMTEgQEAg
aW50IGNtZHFfcGt0X2ZsdXNoX2FzeW5jKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBjbWRxX2FzeW5j
X2ZsdXNoX2NiIGNiLA0KPiA+ICAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNsaWVudC0+bG9j
aywgZmxhZ3MpOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAtCW1ib3hfc2VuZF9tZXNzYWdlKGNsaWVu
dC0+Y2hhbiwgcGt0KTsNCj4gPiArCWVyciA9IG1ib3hfc2VuZF9tZXNzYWdlKGNsaWVudC0+Y2hh
biwgcGt0KTsNCj4gPiAgCS8qIFdlIGNhbiBzZW5kIG5leHQgcGFja2V0IGltbWVkaWF0ZWx5LCBz
byBqdXN0IGNhbGwgdHhkb25lLiAqLw0KPiA+ICAJbWJveF9jbGllbnRfdHhkb25lKGNsaWVudC0+
Y2hhbiwgMCk7DQo+ID4gIA0KPiA+IC0JcmV0dXJuIDA7DQo+ID4gKwlyZXR1cm4gZXJyOw0KPiA+
ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0woY21kcV9wa3RfZmx1c2hfYXN5bmMpOw0KPiA+ICANCj4g
DQo+IA0KDQo=

