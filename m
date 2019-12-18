Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FE1C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F408424691
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pjCqawpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfLRIOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:14:53 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:53403 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725535AbfLRIOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:14:53 -0500
X-UUID: 403bec14a5164ba19b8242291e181357-20191218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Elil3OPD7BxgukHrj970HA8QSwLyzRiTBYIu7u0CL3U=;
        b=pjCqawprPuYx1Dv0fBfU4v8esvm5TCTrUBCyWIlWUwXPjoMXiifMA7rZZrgblypdkw4zygr9ls9zS3L47zOepYNzDLQr7dkV0ot6p5LqeVO/ZsXS96T8d8a4Fbmm76DTCVg6JYyJKkbQn1xrZ6g7mtsJxhArEK/YLS8oRsJC0Aw=;
X-UUID: 403bec14a5164ba19b8242291e181357-20191218
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1818728933; Wed, 18 Dec 2019 16:14:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 18 Dec 2019 16:14:29 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 18 Dec 2019 16:13:51 +0800
Message-ID: <1576656880.9598.0.camel@mtksdaap41>
Subject: Re: [PATCH v2 06/14] soc: mediatek: cmdq: return send msg error code
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 18 Dec 2019 16:14:40 +0800
In-Reply-To: <1576656006.5933.3.camel@mtkswgap22>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-8-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1575604966.6151.1.camel@mtksdaap41> <1576656006.5933.3.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTEyLTE4IGF0IDE2OjAwICswODAwLCBEZW5uaXMtWUMgSHNpZWggd3JvdGU6
DQo+IEhpIEJpYmJ5LA0KPiANCj4gT24gRnJpLCAyMDE5LTEyLTA2IGF0IDEyOjAyICswODAwLCBC
aWJieSBIc2llaCB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMTktMTEtMjcgYXQgMDk6NTggKzA4MDAs
IERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiA+IFJldHVybiBlcnJvciBjb2RlIHRvIGNsaWVu
dCBpZiBzZW5kIG1lc3NhZ2UgZmFpbCwNCj4gPiA+IHNvIHRoYXQgY2xpZW50IGhhcyBjaGFuY2Ug
dG8gZXJyb3IgaGFuZGxpbmcuDQo+ID4gPiANCj4gPiBUaGlzIHBhdGNoZXMgc2VlbXMgbGlrZSBh
IGZpeCBwYXRjaC4NCj4gPiBQbGVhc2UgYWRkIGZpeGVzLCB0aGFua3MuDQo+ID4gDQo+ID4gQmli
YnkNCj4gDQo+IERvIHlvdSBtZWFuIGFkZCAqZml4ZXMqIGluIHRpdGxlPw0KPiBIb3cgYWJvdXQg
KmZpeGVzIGZsdXNoIGFzeW5jIGZ1bmN0aW9uIHJldHVybiBlcnJvciB3aGVuIHNlbmQgZmFpbCog
Pw0KPiANCj4gDQpIaSwgRGVubmlzLA0KDQpQbGVhc2UgcmVmZXIgdG8NCmh0dHBzOi8vd3d3Lmtl
cm5lbC5vcmcvZG9jL2h0bWwvdjQuMTcvcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbA0K
YW5kIGZpbmQgImZpeGVzIi4gDQoNClRoYW5rcyA6RA0KDQpCaWJieQ0KPiBSZWdhcmRzLA0KPiBE
ZW5uaXMNCj4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15
Yy5oc2llaEBtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDQgKystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gPiBpbmRleCAyNzRmNmYzMTFkMDUuLjg0MjFi
NDA5MDMwNCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYw0KPiA+ID4gQEAgLTM1MywxMSArMzUzLDExIEBAIGludCBjbWRxX3BrdF9mbHVzaF9hc3lu
YyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgY21kcV9hc3luY19mbHVzaF9jYiBjYiwNCj4gPiA+ICAJ
CXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNsaWVudC0+bG9jaywgZmxhZ3MpOw0KPiA+ID4gIAl9
DQo+ID4gPiAgDQo+ID4gPiAtCW1ib3hfc2VuZF9tZXNzYWdlKGNsaWVudC0+Y2hhbiwgcGt0KTsN
Cj4gPiA+ICsJZXJyID0gbWJveF9zZW5kX21lc3NhZ2UoY2xpZW50LT5jaGFuLCBwa3QpOw0KPiA+
ID4gIAkvKiBXZSBjYW4gc2VuZCBuZXh0IHBhY2tldCBpbW1lZGlhdGVseSwgc28ganVzdCBjYWxs
IHR4ZG9uZS4gKi8NCj4gPiA+ICAJbWJveF9jbGllbnRfdHhkb25lKGNsaWVudC0+Y2hhbiwgMCk7
DQo+ID4gPiAgDQo+ID4gPiAtCXJldHVybiAwOw0KPiA+ID4gKwlyZXR1cm4gZXJyOw0KPiA+ID4g
IH0NCj4gPiA+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2ZsdXNoX2FzeW5jKTsNCj4gPiA+ICAN
Cj4gPiANCj4gPiANCj4gDQo+IA0KDQo=

