Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD87C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AF320659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lpZUXKuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKVIGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 03:06:07 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59022 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbfKVIGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:06:06 -0500
X-UUID: 2d3d7d60ec9f4a9aaa1251f4ec97ec15-20191122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=K2QceGAFr4kSuhEVcqRkxVbwPBJiY5InoLtmLU20XiU=;
        b=lpZUXKuDJAQewYko3iuJb+KSPvHi3BagShZhozXm62IM7qCD1TC0FVAyl6PJ0pdAw41ivgQky4F0iZIMByWd7SLXwXby6vm/FzDR5iQerHG/a4+4/Y8bjT70KX3cW8wamaUvCvVt2tONm1krCvbI/41Ozv4PlvwropZTuqsAf70=;
X-UUID: 2d3d7d60ec9f4a9aaa1251f4ec97ec15-20191122
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 640489756; Fri, 22 Nov 2019 16:05:59 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 22 Nov 2019 16:05:51 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 22 Nov 2019 16:06:21 +0800
Message-ID: <1574409958.19450.1.camel@mtksdaap41>
Subject: Re: [PATCH v17 1/6] soc: mediatek: cmdq: fixup wrong input order of
 write api
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
Date:   Fri, 22 Nov 2019 16:05:58 +0800
In-Reply-To: <20191121015410.18852-2-bibby.hsieh@mediatek.com>
References: <20191121015410.18852-1-bibby.hsieh@mediatek.com>
         <20191121015410.18852-2-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBUaHUsIDIwMTktMTEtMjEgYXQgMDk6NTQgKzA4MDAsIEJpYmJ5IEhz
aWVoIHdyb3RlOg0KPiBGaXh1cCBhIGlzc3VlIHdhcyBjYXVzZWQgYnkgdGhlIHByZXZpb3VzIGZp
eHVwIHBhdGNoLg0KPiANCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+
DQoNCj4gRml4ZXM6IDFhOTJmOTg5MTI2ZSAoInNvYzogbWVkaWF0ZWs6IGNtZHE6IHJlb3JkZXIg
dGhlIHBhcmFtZXRlciIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaWJieSBIc2llaCA8YmliYnku
aHNpZWhAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1j
bWRxLWhlbHBlci5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0K
PiBpbmRleCA3YWEwNTE3ZmYyZjMuLjNjODJkZTVmOTQxNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gKysrIGIvZHJpdmVycy9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gQEAgLTE1NSw3ICsxNTUsNyBAQCBpbnQgY21kcV9w
a3Rfd3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiAgCQllcnIg
PSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIENNRFFfQ09ERV9NQVNLLCAwLCB+bWFzayk7
DQo+ICAJCW9mZnNldF9tYXNrIHw9IENNRFFfV1JJVEVfRU5BQkxFX01BU0s7DQo+ICAJfQ0KPiAt
CWVyciB8PSBjbWRxX3BrdF93cml0ZShwa3QsIHZhbHVlLCBzdWJzeXMsIG9mZnNldF9tYXNrKTsN
Cj4gKwllcnIgfD0gY21kcV9wa3Rfd3JpdGUocGt0LCBzdWJzeXMsIG9mZnNldF9tYXNrLCB2YWx1
ZSk7DQo+ICANCj4gIAlyZXR1cm4gZXJyOw0KPiAgfQ0KDQo=

