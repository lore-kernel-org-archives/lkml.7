Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D9AC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB4F21734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gGXhHvdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgAFDWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 22:22:18 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:5236 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727307AbgAFDWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:22:18 -0500
X-UUID: 57f54413a2e74625b881579fa3447eab-20200106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=RDSho2ud9PkHmo+SliyxkimBGlr7TcmW+AJEdhiBnZU=;
        b=gGXhHvdn6IEqW4MMtZ/uMz9roTigWtx+W6NAewHZn4n1fkM06PCs0Aq2Q63g/wxau/QPEXq37eRvjUyxYcA9kWY12WDVwE0qukyU5Nj2RMMSzNdO+y+IVHkAlKif3yQ1tJzo8YlGWkRaJXuf387J9hLh2dvhw+0ZBtv4L/B+pTE=;
X-UUID: 57f54413a2e74625b881579fa3447eab-20200106
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 359625338; Mon, 06 Jan 2020 11:22:09 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 6 Jan 2020 11:22:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkcas08.mediatek.inc
 (172.21.101.126) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 6 Jan
 2020 11:20:16 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 6 Jan 2020 11:19:00 +0800
Message-ID: <1578280829.5196.4.camel@mtksdaap41>
Subject: Re: [PATCH 2/2] iommu/mediatek: add support for MT8167
From:   CK Hu <ck.hu@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <joro@8bytes.org>, <robh+dt@kernel.org>
Date:   Mon, 6 Jan 2020 11:20:29 +0800
In-Reply-To: <20200103162632.109553-2-fparent@baylibre.com>
References: <20200103162632.109553-1-fparent@baylibre.com>
         <20200103162632.109553-2-fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmllbjoNCg0KT24gRnJpLCAyMDIwLTAxLTAzIGF0IDE3OjI2ICswMTAwLCBGYWJpZW4g
UGFyZW50IHdyb3RlOg0KPiBBZGQgc3VwcG9ydCBmb3IgdGhlIElPTU1VIG9uIE1UODE2Nw0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogRmFiaWVuIFBhcmVudCA8ZnBhcmVudEBiYXlsaWJyZS5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDExICsrKysrKysrKystDQo+ICBk
cml2ZXJzL2lvbW11L210a19pb21tdS5oIHwgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gaW5kZXggNmZj
MWY1ZWNmOTFlLi41ZmM2MTc4YTgyZGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiBAQCAtNTY5LDcg
KzU2OSw4IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3X2luaXQoY29uc3Qgc3RydWN0IG10a19p
b21tdV9kYXRhICpkYXRhKQ0KPiAgCQlGX0lOVF9QUkVURVRDSF9UUkFOU0FUSU9OX0ZJRk9fRkFV
TFQ7DQo+ICAJd3JpdGVsX3JlbGF4ZWQocmVndmFsLCBkYXRhLT5iYXNlICsgUkVHX01NVV9JTlRf
TUFJTl9DT05UUk9MKTsNCj4gIA0KPiAtCWlmIChkYXRhLT5wbGF0X2RhdGEtPm00dV9wbGF0ID09
IE00VV9NVDgxNzMpDQo+ICsJaWYgKGRhdGEtPnBsYXRfZGF0YS0+bTR1X3BsYXQgPT0gTTRVX01U
ODE3MyB8fA0KPiArCSAgICBkYXRhLT5wbGF0X2RhdGEtPm00dV9wbGF0ID09IE00VV9NVDgxNjcp
DQoNCkkgZG8gbm90IGxpa2UgdG8gdXNlIG00dV9wbGF0IGZvciB0aGUgdmFyaWFudCBvZiBlYWNo
IFNvQy4gSWYgeW91IHVzZQ0KbTR1X3BsYXQsIHlvdSBjb3VsZCBkcm9wIGhhc180Z2JfbW9kZSwg
cmVzZXRfYXhpLCBsYXJiaWRfcmVtYXAgYmVjYXVzZQ0KeW91IGNvdWxkIHVzZSBtNHVfcGxhdCB0
byBkZWNpZGUgdGhlIGJlaGF2aW9yIG9mIHRoZXNlIHZhcmlhYmxlIGJ1dCB0aGUNCmNvZGUgd291
bGQgYmUgc28gZGlydHkuIFNvIEkgdGhpbmsgeW91IHNob3VsZCBkcm9wIG00dV9wbGF0IGFuZCB1
c2UgYQ0KdmFyaWFibGUgdG8gaWRlbnRpZnkgdGhpcyBiZWhhdmlvci4NCg0KUmVnYXJkcywNCkNL
DQoNCj4gIAkJcmVndmFsID0gKGRhdGEtPnByb3RlY3RfYmFzZSA+PiAxKSB8IChkYXRhLT5lbmFi
bGVfNEdCIDw8IDMxKTsNCj4gIAllbHNlDQo+ICAJCXJlZ3ZhbCA9IGxvd2VyXzMyX2JpdHMoZGF0
YS0+cHJvdGVjdF9iYXNlKSB8DQo+IEBAIC03ODIsNiArNzgzLDEzIEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDI3MTJfZGF0YSA9IHsNCj4gIAkubGFyYmlkX3Jl
bWFwID0gezAsIDEsIDIsIDMsIDQsIDUsIDYsIDcsIDgsIDl9LA0KPiAgfTsNCj4gIA0KPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE2N19kYXRhID0gew0KPiAr
CS5tNHVfcGxhdCAgICAgPSBNNFVfTVQ4MTY3LA0KPiArCS5oYXNfNGdiX21vZGUgPSB0cnVlLA0K
PiArCS5yZXNldF9heGkgICAgPSB0cnVlLA0KPiArCS5sYXJiaWRfcmVtYXAgPSB7MCwgMSwgMiwg
MywgNCwgNX0sIC8qIExpbmVhciBtYXBwaW5nLiAqLw0KPiArfTsNCj4gKw0KPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE3M19kYXRhID0gew0KPiAgCS5tNHVf
cGxhdCAgICAgPSBNNFVfTVQ4MTczLA0KPiAgCS5oYXNfNGdiX21vZGUgPSB0cnVlLA0KPiBAQCAt
Nzk4LDYgKzgwNiw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBt
dDgxODNfZGF0YSA9IHsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQg
bXRrX2lvbW11X29mX2lkc1tdID0gew0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQy
NzEyLW00dSIsIC5kYXRhID0gJm10MjcxMl9kYXRhfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE2Ny1tNHUiLCAuZGF0YSA9ICZtdDgxNjdfZGF0YX0sDQo+ICAJeyAuY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtbTR1IiwgLmRhdGEgPSAmbXQ4MTczX2RhdGF9LA0KPiAg
CXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLW00dSIsIC5kYXRhID0gJm10ODE4M19k
YXRhfSwNCj4gIAl7fQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCBi
L2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gaW5kZXggZWE5NDlhMzI0ZTMzLi5jYjhmZDU5
NzBjZDQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gKysrIGIv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiBAQCAtMzAsNiArMzAsNyBAQCBzdHJ1Y3QgbXRr
X2lvbW11X3N1c3BlbmRfcmVnIHsNCj4gIGVudW0gbXRrX2lvbW11X3BsYXQgew0KPiAgCU00VV9N
VDI3MDEsDQo+ICAJTTRVX01UMjcxMiwNCj4gKwlNNFVfTVQ4MTY3LA0KPiAgCU00VV9NVDgxNzMs
DQo+ICAJTTRVX01UODE4MywNCj4gIH07DQoNCg==

