Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C129C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF9621655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IPUJTxwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfLLEtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 23:49:12 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57056 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726689AbfLLEtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 23:49:12 -0500
X-UUID: d8f23ae9e30540f2b273bd87852f6fe0-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=E+WerAWO7LXcxAkqLk99bj1sr3WlUYbo9Q9kI8fEORY=;
        b=IPUJTxwI2NNddllHMyhFySNdSF1bZRmbJz/aH5sxtX9jyyRd44Mj3teUXlS+8/PFMrAQBZBGCiDn6VwPsrrwrfeBOJvTgGP0CNsZitfo3H/5tv+JaMuBb92Nzj0Y7EdMg/JCv0NUb6qs6MK/ev3OiB2qRjTbpHQT/VP7lxDZObU=;
X-UUID: d8f23ae9e30540f2b273bd87852f6fe0-20191212
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1797774077; Thu, 12 Dec 2019 12:49:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 12:48:44 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 12:48:54 +0800
Message-ID: <1576126139.29693.2.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: Check return value of
 mtk_drm_ddp_comp_for_plane.
From:   CK Hu <ck.hu@mediatek.com>
To:     Pi-Hsun Shih <pihsun@chromium.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        "open list:DRM DRIVERS FOR MEDIATEK" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Dec 2019 12:48:59 +0800
In-Reply-To: <1574409521.12825.0.camel@mtksdaap41>
References: <20191118061806.52781-1-pihsun@chromium.org>
         <1574409521.12825.0.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBpLUhzdW46DQoNCk9uIEZyaSwgMjAxOS0xMS0yMiBhdCAxNTo1OCArMDgwMCwgQ0sgSHUg
d3JvdGU6DQo+IEhpLCBQaS1Ic3VuOg0KPiANCj4gT24gTW9uLCAyMDE5LTExLTE4IGF0IDE0OjE4
ICswODAwLCBQaS1Ic3VuIFNoaWggd3JvdGU6DQo+ID4gVGhlIG10a19kcm1fZGRwX2NvbXBfZm9y
X3BsYW5lIGNhbiByZXR1cm4gTlVMTCwgYnV0IHRoZSB1c2FnZSBkb2Vzbid0DQo+ID4gY2hlY2sg
Zm9yIGl0LiBBZGQgY2hlY2sgZm9yIGl0Lg0KPiANCj4gUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5o
dUBtZWRpYXRlay5jb20+DQo+IA0KDQpBcHBsaWVkIHRvIG1lZGlhdGVrLWRybS1maXhlcy01LjUg
WzFdLCB0aGFua3MuDQoNClsxXQ0KaHR0cHM6Ly9naXRodWIuY29tL2NraHUtbWVkaWF0ZWsvbGlu
dXguZ2l0LXRhZ3MvY29tbWl0cy9tZWRpYXRlay1kcm0tZml4ZXMtNS41DQoNClJlZ2FyZHMsDQpD
Sw0KDQo+ID4gDQo+ID4gRml4ZXM6IGQ2YjUzZjY4MzU2ZiAoImRybS9tZWRpYXRlazogQWRkIGhl
bHBlciB0byBnZXQgY29tcG9uZW50IGZvciBhIHBsYW5lIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBQ
aS1Ic3VuIFNoaWggPHBpaHN1bkBjaHJvbWl1bS5vcmc+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyB8IDEzICsrKysrKysrKy0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gaW5kZXggZjgwYThi
YTc1OTc3Li40YzRmOTc2Yzk5NGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fY3J0Yy5jDQo+ID4gQEAgLTMxMCw3ICszMTAsOSBAQCBzdGF0aWMgaW50IG10a19j
cnRjX2RkcF9od19pbml0KHN0cnVjdCBtdGtfZHJtX2NydGMgKm10a19jcnRjKQ0KPiA+ICANCj4g
PiAgCQlwbGFuZV9zdGF0ZSA9IHRvX210a19wbGFuZV9zdGF0ZShwbGFuZS0+c3RhdGUpOw0KPiA+
ICAJCWNvbXAgPSBtdGtfZHJtX2RkcF9jb21wX2Zvcl9wbGFuZShjcnRjLCBwbGFuZSwgJmxvY2Fs
X2xheWVyKTsNCj4gPiAtCQltdGtfZGRwX2NvbXBfbGF5ZXJfY29uZmlnKGNvbXAsIGxvY2FsX2xh
eWVyLCBwbGFuZV9zdGF0ZSk7DQo+ID4gKwkJaWYgKGNvbXApDQo+ID4gKwkJCW10a19kZHBfY29t
cF9sYXllcl9jb25maWcoY29tcCwgbG9jYWxfbGF5ZXIsDQo+ID4gKwkJCQkJCSAgcGxhbmVfc3Rh
dGUpOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAgCXJldHVybiAwOw0KPiA+IEBAIC0zODYsOCArMzg4
LDkgQEAgc3RhdGljIHZvaWQgbXRrX2NydGNfZGRwX2NvbmZpZyhzdHJ1Y3QgZHJtX2NydGMgKmNy
dGMpDQo+ID4gIAkJCWNvbXAgPSBtdGtfZHJtX2RkcF9jb21wX2Zvcl9wbGFuZShjcnRjLCBwbGFu
ZSwNCj4gPiAgCQkJCQkJCSAgJmxvY2FsX2xheWVyKTsNCj4gPiAgDQo+ID4gLQkJCW10a19kZHBf
Y29tcF9sYXllcl9jb25maWcoY29tcCwgbG9jYWxfbGF5ZXIsDQo+ID4gLQkJCQkJCSAgcGxhbmVf
c3RhdGUpOw0KPiA+ICsJCQlpZiAoY29tcCkNCj4gPiArCQkJCW10a19kZHBfY29tcF9sYXllcl9j
b25maWcoY29tcCwgbG9jYWxfbGF5ZXIsDQo+ID4gKwkJCQkJCQkgIHBsYW5lX3N0YXRlKTsNCj4g
PiAgCQkJcGxhbmVfc3RhdGUtPnBlbmRpbmcuY29uZmlnID0gZmFsc2U7DQo+ID4gIAkJfQ0KPiA+
ICAJCW10a19jcnRjLT5wZW5kaW5nX3BsYW5lcyA9IGZhbHNlOw0KPiA+IEBAIC00MDEsNyArNDA0
LDkgQEAgaW50IG10a19kcm1fY3J0Y19wbGFuZV9jaGVjayhzdHJ1Y3QgZHJtX2NydGMgKmNydGMs
IHN0cnVjdCBkcm1fcGxhbmUgKnBsYW5lLA0KPiA+ICAJc3RydWN0IG10a19kZHBfY29tcCAqY29t
cDsNCj4gPiAgDQo+ID4gIAljb21wID0gbXRrX2RybV9kZHBfY29tcF9mb3JfcGxhbmUoY3J0Yywg
cGxhbmUsICZsb2NhbF9sYXllcik7DQo+ID4gLQlyZXR1cm4gbXRrX2RkcF9jb21wX2xheWVyX2No
ZWNrKGNvbXAsIGxvY2FsX2xheWVyLCBzdGF0ZSk7DQo+ID4gKwlpZiAoY29tcCkNCj4gPiArCQly
ZXR1cm4gbXRrX2RkcF9jb21wX2xheWVyX2NoZWNrKGNvbXAsIGxvY2FsX2xheWVyLCBzdGF0ZSk7
DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIHZvaWQgbXRrX2Ry
bV9jcnRjX2F0b21pY19lbmFibGUoc3RydWN0IGRybV9jcnRjICpjcnRjLA0KPiA+IA0KPiA+IGJh
c2UtY29tbWl0OiA1YTZmY2JlYWJlM2UyMDQ1OWVkODUwNDY5MGIyNTE1ZGFjYzUyNDZmDQo+IA0K
DQo=

