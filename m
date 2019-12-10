Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7757C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D633206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pnYDze4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfLJHu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 02:50:26 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:12613 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726071AbfLJHu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:50:26 -0500
X-UUID: 328127590f9f48e6a0b31a4a1175a6c3-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JL3qkLaljq80IvyBNK1e0OAptSLHH1w7K2FYS4Mu4+8=;
        b=pnYDze4PDw3LNvqsJ9N4j1pEKHzA6nP7bTtf5VdAtRdg62/wshCcXA0I+rXCj4TpesT5BKuR2OnBUtsFti05F5uz5aoa0Dn1bFAyp8bWKaypVtKNJFFueIH+Npb4YKMWPQS7hSoATkJZX6KjTIEtJeVh7L5xYseeyUOkPZ4JRGo=;
X-UUID: 328127590f9f48e6a0b31a4a1175a6c3-20191210
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1483728837; Tue, 10 Dec 2019 15:50:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 15:50:03 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 15:50:26 +0800
Message-ID: <1575964221.13210.1.camel@mtksdaap41>
Subject: Re: [PATCH v2 11/14] soc: mediatek: cmdq: export finalize function
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 10 Dec 2019 15:50:21 +0800
In-Reply-To: <1574819937-6246-13-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-13-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gV2VkLCAyMDE5LTExLTI3IGF0IDA5OjU4ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEV4cG9ydCBmaW5hbGl6ZSBmdW5jdGlvbiB0byBjbGllbnQgd2hp
Y2ggaGVscHMgYXBwZW5kIGVvYyBhbmQganVtcA0KPiBjb21tYW5kIHRvIHBrdC4NCg0KUmV2aWV3
ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDcgKystLS0tLQ0KPiAg
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgfCA4ICsrKysrKysrDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiBpbmRleCAyNDRiODUyOGViMTYu
LjM4ZTBjMTNlMTkyMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEtaGVscGVyLmMNCj4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCj4gQEAgLTM5Miw3ICszOTIsNyBAQCBpbnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdCBjbWRx
X3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKQ0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJP
TChjbWRxX3BrdF9hc3NpZ24pOw0KPiAgDQo+IC1zdGF0aWMgaW50IGNtZHFfcGt0X2ZpbmFsaXpl
KHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiAraW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBj
bWRxX3BrdCAqcGt0KQ0KPiAgew0KPiAgCXN0cnVjdCBjbWRxX2NsaWVudCAqY2wgPSBwa3QtPmNs
Ow0KPiAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KPiBAQCAtNDEy
LDYgKzQxMiw3IEBAIHN0YXRpYyBpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0
ICpwa3QpDQo+ICANCj4gIAlyZXR1cm4gZXJyOw0KPiAgfQ0KPiArRVhQT1JUX1NZTUJPTChjbWRx
X3BrdF9maW5hbGl6ZSk7DQo+ICANCj4gIHN0YXRpYyB2b2lkIGNtZHFfcGt0X2ZsdXNoX2FzeW5j
X2NiKHN0cnVjdCBjbWRxX2NiX2RhdGEgZGF0YSkNCj4gIHsNCj4gQEAgLTQ0NiwxMCArNDQ3LDYg
QEAgaW50IGNtZHFfcGt0X2ZsdXNoX2FzeW5jKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBjbWRxX2Fz
eW5jX2ZsdXNoX2NiIGNiLA0KPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3MgPSAwOw0KPiAgCXN0cnVj
dCBjbWRxX2NsaWVudCAqY2xpZW50ID0gKHN0cnVjdCBjbWRxX2NsaWVudCAqKXBrdC0+Y2w7DQo+
ICANCj4gLQllcnIgPSBjbWRxX3BrdF9maW5hbGl6ZShwa3QpOw0KPiAtCWlmIChlcnIgPCAwKQ0K
PiAtCQlyZXR1cm4gZXJyOw0KPiAtDQo+ICAJcGt0LT5jYi5jYiA9IGNiOw0KPiAgCXBrdC0+Y2Iu
ZGF0YSA9IGRhdGE7DQo+ICAJcGt0LT5hc3luY19jYi5jYiA9IGNtZHFfcGt0X2ZsdXNoX2FzeW5j
X2NiOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEu
aCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gaW5kZXggNGJjZTI0
MGRiYjU2Li45OThiYzkwZjlkYTkgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21l
ZGlhdGVrL210ay1jbWRxLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaA0KPiBAQCAtMjA0LDYgKzIwNCwxNCBAQCBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0
cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ICAgKi8NCj4gIGludCBjbWRxX3BrdF9h
c3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpOw0KPiAg
DQo+ICsvKioNCj4gKyAqIGNtZHFfcGt0X2ZpbmFsaXplKCkgLSBBcHBlbmQgRU9DIGFuZCBqdW1w
IGNvbW1hbmQgdG8gcGt0Lg0KPiArICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+ICsgKg0KPiAr
ICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVk
DQo+ICsgKi8NCj4gK2ludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCk7
DQo+ICsNCj4gIC8qKg0KPiAgICogY21kcV9wa3RfZmx1c2hfYXN5bmMoKSAtIHRyaWdnZXIgQ01E
USB0byBhc3luY2hyb25vdXNseSBleGVjdXRlIHRoZSBDTURRDQo+ICAgKiAgICAgICAgICAgICAg
ICAgICAgICAgICAgcGFja2V0IGFuZCBjYWxsIGJhY2sgYXQgdGhlIGVuZCBvZiBkb25lIHBhY2tl
dA0KDQo=

