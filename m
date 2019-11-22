Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5796DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B4A20658
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UBj+tYl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKVH6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 02:58:48 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:31415 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726248AbfKVH6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 02:58:47 -0500
X-UUID: 995ad331f2ab4f46a3820f39bf312b57-20191122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=biiWaCmeF2zekF9ph9b3ZsgnAyXW/XZddTvqnNdWtZI=;
        b=UBj+tYl7o9PnBzb8JAMkkcAghNv1ZKFDCo9BnYhfPiCD+tgcKL5SWitrbPEE07xrbjCFBmvsH/G+upGp27sMPLuxWXBotj+fV6v4HMdYPyl9nkdv9QeTBV5eIvEwp+FdjeN7tZTgqjoPB+f2ewwuSZU/YumK1cR4RBquWG74viE=;
X-UUID: 995ad331f2ab4f46a3820f39bf312b57-20191122
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 62595625; Fri, 22 Nov 2019 15:58:42 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 22 Nov 2019 15:59:03 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 22 Nov 2019 15:59:04 +0800
Message-ID: <1574409521.12825.0.camel@mtksdaap41>
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
Date:   Fri, 22 Nov 2019 15:58:41 +0800
In-Reply-To: <20191118061806.52781-1-pihsun@chromium.org>
References: <20191118061806.52781-1-pihsun@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBpLUhzdW46DQoNCk9uIE1vbiwgMjAxOS0xMS0xOCBhdCAxNDoxOCArMDgwMCwgUGktSHN1
biBTaGloIHdyb3RlOg0KPiBUaGUgbXRrX2RybV9kZHBfY29tcF9mb3JfcGxhbmUgY2FuIHJldHVy
biBOVUxMLCBidXQgdGhlIHVzYWdlIGRvZXNuJ3QNCj4gY2hlY2sgZm9yIGl0LiBBZGQgY2hlY2sg
Zm9yIGl0Lg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiAN
Cj4gRml4ZXM6IGQ2YjUzZjY4MzU2ZiAoImRybS9tZWRpYXRlazogQWRkIGhlbHBlciB0byBnZXQg
Y29tcG9uZW50IGZvciBhIHBsYW5lIikNCj4gU2lnbmVkLW9mZi1ieTogUGktSHN1biBTaGloIDxw
aWhzdW5AY2hyb21pdW0ub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2NydGMuYyB8IDEzICsrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fY3J0Yy5jDQo+IGluZGV4IGY4MGE4YmE3NTk3Ny4uNGM0Zjk3NmM5OTRlIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IEBAIC0zMTAsNyAr
MzEwLDkgQEAgc3RhdGljIGludCBtdGtfY3J0Y19kZHBfaHdfaW5pdChzdHJ1Y3QgbXRrX2RybV9j
cnRjICptdGtfY3J0YykNCj4gIA0KPiAgCQlwbGFuZV9zdGF0ZSA9IHRvX210a19wbGFuZV9zdGF0
ZShwbGFuZS0+c3RhdGUpOw0KPiAgCQljb21wID0gbXRrX2RybV9kZHBfY29tcF9mb3JfcGxhbmUo
Y3J0YywgcGxhbmUsICZsb2NhbF9sYXllcik7DQo+IC0JCW10a19kZHBfY29tcF9sYXllcl9jb25m
aWcoY29tcCwgbG9jYWxfbGF5ZXIsIHBsYW5lX3N0YXRlKTsNCj4gKwkJaWYgKGNvbXApDQo+ICsJ
CQltdGtfZGRwX2NvbXBfbGF5ZXJfY29uZmlnKGNvbXAsIGxvY2FsX2xheWVyLA0KPiArCQkJCQkJ
ICBwbGFuZV9zdGF0ZSk7DQo+ICAJfQ0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+IEBAIC0zODYsOCAr
Mzg4LDkgQEAgc3RhdGljIHZvaWQgbXRrX2NydGNfZGRwX2NvbmZpZyhzdHJ1Y3QgZHJtX2NydGMg
KmNydGMpDQo+ICAJCQljb21wID0gbXRrX2RybV9kZHBfY29tcF9mb3JfcGxhbmUoY3J0YywgcGxh
bmUsDQo+ICAJCQkJCQkJICAmbG9jYWxfbGF5ZXIpOw0KPiAgDQo+IC0JCQltdGtfZGRwX2NvbXBf
bGF5ZXJfY29uZmlnKGNvbXAsIGxvY2FsX2xheWVyLA0KPiAtCQkJCQkJICBwbGFuZV9zdGF0ZSk7
DQo+ICsJCQlpZiAoY29tcCkNCj4gKwkJCQltdGtfZGRwX2NvbXBfbGF5ZXJfY29uZmlnKGNvbXAs
IGxvY2FsX2xheWVyLA0KPiArCQkJCQkJCSAgcGxhbmVfc3RhdGUpOw0KPiAgCQkJcGxhbmVfc3Rh
dGUtPnBlbmRpbmcuY29uZmlnID0gZmFsc2U7DQo+ICAJCX0NCj4gIAkJbXRrX2NydGMtPnBlbmRp
bmdfcGxhbmVzID0gZmFsc2U7DQo+IEBAIC00MDEsNyArNDA0LDkgQEAgaW50IG10a19kcm1fY3J0
Y19wbGFuZV9jaGVjayhzdHJ1Y3QgZHJtX2NydGMgKmNydGMsIHN0cnVjdCBkcm1fcGxhbmUgKnBs
YW5lLA0KPiAgCXN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXA7DQo+ICANCj4gIAljb21wID0gbXRr
X2RybV9kZHBfY29tcF9mb3JfcGxhbmUoY3J0YywgcGxhbmUsICZsb2NhbF9sYXllcik7DQo+IC0J
cmV0dXJuIG10a19kZHBfY29tcF9sYXllcl9jaGVjayhjb21wLCBsb2NhbF9sYXllciwgc3RhdGUp
Ow0KPiArCWlmIChjb21wKQ0KPiArCQlyZXR1cm4gbXRrX2RkcF9jb21wX2xheWVyX2NoZWNrKGNv
bXAsIGxvY2FsX2xheWVyLCBzdGF0ZSk7DQo+ICsJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gIHN0
YXRpYyB2b2lkIG10a19kcm1fY3J0Y19hdG9taWNfZW5hYmxlKHN0cnVjdCBkcm1fY3J0YyAqY3J0
YywNCj4gDQo+IGJhc2UtY29tbWl0OiA1YTZmY2JlYWJlM2UyMDQ1OWVkODUwNDY5MGIyNTE1ZGFj
YzUyNDZmDQoNCg==

