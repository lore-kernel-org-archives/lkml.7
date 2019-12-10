Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF12C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 01:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1262073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 01:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gcPpE+/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfLJBYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:24:43 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59029 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727221AbfLJBYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 20:24:43 -0500
X-UUID: fbdde645f9ff44fdae3a6e96192052c8-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=uS+vnIodKcC3nYeOH364CYiGDOfQNtI3mPSCouI1v0o=;
        b=gcPpE+/50n18No5AZmiEkd3C3cSllzyT7fYi6K8YFsPoZyqwFQ8VQr1H2plHvwffV2EGBag/Cckd/SwXSWTBqGaote7w/Hq4JfhE4QZKBaowDBMJh227YsKXJyFTZK0F1urZXGKKCvxMLNQOL8qPlpg9/UyM1RanJjrOPlNzus4=;
X-UUID: fbdde645f9ff44fdae3a6e96192052c8-20191210
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1852598995; Tue, 10 Dec 2019 09:24:36 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 09:23:39 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 09:24:16 +0800
Message-ID: <1575941074.9782.0.camel@mtksdaap41>
Subject: Re: [PATCH v2 24/28] drm/mediatek: hdmi: Use drm_bridge_init()
From:   CK Hu <ck.hu@mediatek.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 10 Dec 2019 09:24:34 +0800
In-Reply-To: <20191204114732.28514-25-mihail.atanassov@arm.com>
References: <20191204114732.28514-1-mihail.atanassov@arm.com>
         <20191204114732.28514-25-mihail.atanassov@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C2053D4113A1F6C2D03FB17F90EEE848F312EC60C58E129E95C51A71E518A3AF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1paGFpbDoNCg0KT24gV2VkLCAyMDE5LTEyLTA0IGF0IDExOjQ4ICswMDAwLCBNaWhhaWwg
QXRhbmFzc292IHdyb3RlOg0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gDQoNCkFja2VkLWJ5
OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IE1paGFpbCBB
dGFuYXNzb3YgPG1paGFpbC5hdGFuYXNzb3ZAYXJtLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfaGRtaS5jDQo+IGluZGV4IGY2ODQ5NDdjNTI0My4uOTc2MWE4MDY3NGQ5IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYw0KPiBAQCAtMTcwOCw4ICsxNzA4LDggQEAgc3Rh
dGljIGludCBtdGtfZHJtX2hkbWlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gIA0KPiAgCW10a19oZG1pX3JlZ2lzdGVyX2F1ZGlvX2RyaXZlcihkZXYpOw0KPiAgDQo+IC0J
aGRtaS0+YnJpZGdlLmZ1bmNzID0gJm10a19oZG1pX2JyaWRnZV9mdW5jczsNCj4gLQloZG1pLT5i
cmlkZ2Uub2Zfbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiArCWRybV9icmlkZ2VfaW5pdCgm
aGRtaS0+YnJpZGdlLCAmcGRldi0+ZGV2LCAmbXRrX2hkbWlfYnJpZGdlX2Z1bmNzLA0KPiArCQkJ
TlVMTCwgTlVMTCk7DQo+ICAJZHJtX2JyaWRnZV9hZGQoJmhkbWktPmJyaWRnZSk7DQo+ICANCj4g
IAlyZXQgPSBtdGtfaGRtaV9jbGtfZW5hYmxlX2F1ZGlvKGhkbWkpOw0KDQo=

