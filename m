Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24B0C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97C7217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BH0kFVI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgABGCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 01:02:37 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:2170 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgABGCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 01:02:36 -0500
X-UUID: dd7d204af3d64f0a9d0cc923b9ac291b-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=VDLfXcYUJeQkJKhzGgI3LI0lhtwysIGtBl5WGX6utNk=;
        b=BH0kFVI/GfyFnrjxaR1KLl8zPJfGM+eUIy2VW299DXTrYnDB5XZcB2PN0fD+1v2h7vZacl6yO7aSkzSrotC4BXYTcfJBczEu3kato1AB6+5lIyIJUd6rpreIV8dsNiiPj690hxK37PAgc304s0V1m90JPvz6RvJGQPK99qCwqrE=;
X-UUID: dd7d204af3d64f0a9d0cc923b9ac291b-20200102
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1129739519; Thu, 02 Jan 2020 14:02:31 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 14:02:00 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 14:02:56 +0800
Message-ID: <1577944949.32066.1.camel@mtksdaap41>
Subject: Re: [PATCH v6, 02/14] drm/mediatek: move dsi/dpi select input into
 mtk_ddp_sel_in
From:   CK Hu <ck.hu@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 2 Jan 2020 14:02:29 +0800
In-Reply-To: <1577943579.15116.1.camel@mhfsdcap03>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
         <1577937624-14313-3-git-send-email-yongqiang.niu@mediatek.com>
         <1577941388.24650.2.camel@mtksdaap41> <1577943579.15116.1.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A1684504572D72737A9A3F6FE56B804FCF8791910A3C4C4D11C54BBD967F1E9D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gVGh1LCAyMDIwLTAxLTAyIGF0IDEzOjM5ICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBPbiBUaHUsIDIwMjAtMDEtMDIgYXQgMTM6MDMgKzA4MDAsIENL
IEh1IHdyb3RlOg0KPiA+IEhpLCBZb25ncWlhbmc6DQo+ID4gDQo+ID4gT24gVGh1LCAyMDIwLTAx
LTAyIGF0IDEyOjAwICswODAwLCBZb25ncWlhbmcgTml1IHdyb3RlOg0KPiA+ID4gbW92ZSBkc2kv
ZHBpIHNlbGVjdCBpbnB1dCBpbnRvIG10a19kZHBfc2VsX2luDQo+ID4gPiANCj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KPiA+
ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMgfCAx
MCArKysrKystLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2RkcC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwLmMNCj4gPiA+IGluZGV4IDM5NzAwYjkuLjkxYzliMTkgMTAwNjQ0DQo+ID4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KPiA+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMNCj4gPiA+IEBAIC0zNzYsNiArMzc2LDEy
IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbXRrX2RkcF9zZWxfaW4oZW51bSBtdGtfZGRwX2NvbXBf
aWQgY3VyLA0KPiA+ID4gIAl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyAmJiBu
ZXh0ID09IEREUF9DT01QT05FTlRfRFNJMCkgew0KPiA+ID4gIAkJKmFkZHIgPSBESVNQX1JFR19D
T05GSUdfRFNJX1NFTDsNCj4gPiA+ICAJCXZhbHVlID0gRFNJX1NFTF9JTl9CTFM7DQo+ID4gPiAr
CX0gZWxzZSBpZiAoY3VyID09IEREUF9DT01QT05FTlRfUkRNQTEgJiYgbmV4dCA9PSBERFBfQ09N
UE9ORU5UX0RTSTApIHsNCj4gPiA+ICsJCSphZGRyID0gRElTUF9SRUdfQ09ORklHX0RTSV9TRUw7
DQo+ID4gPiArCQl2YWx1ZSA9IERTSV9TRUxfSU5fUkRNQTsNCj4gPiANCj4gPiBJbiBvcmlnaW5h
bCBjb2RlLCB0aGlzIGlzIHNldCB3aGVuIGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyBhbmQgbmV4
dCA9PQ0KPiA+IEREUF9DT01QT05FTlRfRFBJMC4gV2h5IGRvIHlvdSBjaGFuZ2UgdGhlIGNvbmRp
dGlvbj8NCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IENLDQo+IA0KPiBpZiBibHMgY29ubmVjdCB3
aXRoIGRwaTAsIHJkbWExIHNob3VsZCBjb25uZWN0IHdpdGggZHNpMCwgdGhlIGNvbmRpdGlvbg0K
PiBpcyBzYW1lIHdpdGggYmVmb3JlLg0KDQpZb3Ugc3VnZ2VzdCB0aGF0IHR3byBjcnRjcyBhcmUg
Ym90aCBlbmFibGVkLiBJZiBvbmx5IG9uZSBjcnRjIGlzDQplbmFibGVkLCBqdXN0IG9uZSBvZiB0
aGVzZSB0d28gd291bGQgYmUgc2V0Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiA+IA0KPiA+ID4gKwl9
IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyAmJiBuZXh0ID09IEREUF9DT01QT05F
TlRfRFBJMCkgew0KPiA+ID4gKwkJKmFkZHIgPSBESVNQX1JFR19DT05GSUdfRFBJX1NFTDsNCj4g
PiA+ICsJCXZhbHVlID0gRFBJX1NFTF9JTl9CTFM7DQo+ID4gPiAgCX0gZWxzZSB7DQo+ID4gPiAg
CQl2YWx1ZSA9IDA7DQo+ID4gPiAgCX0NCj4gPiA+IEBAIC0zOTMsMTAgKzM5OSw2IEBAIHN0YXRp
YyB2b2lkIG10a19kZHBfc291dF9zZWwoc3RydWN0IHJlZ21hcCAqY29uZmlnX3JlZ3MsDQo+ID4g
PiAgCX0gZWxzZSBpZiAoY3VyID09IEREUF9DT01QT05FTlRfQkxTICYmIG5leHQgPT0gRERQX0NP
TVBPTkVOVF9EUEkwKSB7DQo+ID4gPiAgCQlyZWdtYXBfd3JpdGUoY29uZmlnX3JlZ3MsIERJU1Bf
UkVHX0NPTkZJR19PVVRfU0VMLA0KPiA+ID4gIAkJCQlCTFNfVE9fRFBJX1JETUExX1RPX0RTSSk7
DQo+ID4gPiAtCQlyZWdtYXBfd3JpdGUoY29uZmlnX3JlZ3MsIERJU1BfUkVHX0NPTkZJR19EU0lf
U0VMLA0KPiA+ID4gLQkJCQlEU0lfU0VMX0lOX1JETUEpOw0KPiA+ID4gLQkJcmVnbWFwX3dyaXRl
KGNvbmZpZ19yZWdzLCBESVNQX1JFR19DT05GSUdfRFBJX1NFTCwNCj4gPiA+IC0JCQkJRFBJX1NF
TF9JTl9CTFMpOw0KPiA+ID4gIAl9DQo+ID4gPiAgfQ0KPiA+ID4gIA0KPiA+IA0KPiA+IA0KPiAN
Cj4gDQoNCg==

