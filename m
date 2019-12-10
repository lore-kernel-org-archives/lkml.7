Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD922C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B67207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oeZ0H330"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLJFFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 00:05:34 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:1202 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726714AbfLJFFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 00:05:34 -0500
X-UUID: ead2c333e9724bbd9ac1b2fe279dbb0e-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sT8+poW4EDti9+9WpBz/VV2F6sEiz5U6298aIszT21w=;
        b=oeZ0H330g3Z0V18yP7I8H7HT3NYeC/eK4dphDLxq6hkycAsffVFzEqBd/pR13e129i714yleVluMtbtTcC7bXwL73uJK6aUCP/ZQYMyhzvtCeUVf110s/iolQQMaxvC2t7Sq26ea1FzCGaV8cJb6hOZkRqMHQB0SwHg8ZVbrIcw=;
X-UUID: ead2c333e9724bbd9ac1b2fe279dbb0e-20191210
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1457922068; Tue, 10 Dec 2019 13:05:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 13:04:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 13:05:22 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v5 5/7] drm/mediatek: remove unused external function
Date:   Tue, 10 Dec 2019 13:05:24 +0800
Message-ID: <20191210050526.4437-6-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191210050526.4437-1-bibby.hsieh@mediatek.com>
References: <20191210050526.4437-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3BED7911B5E72A5DB3D8D69959DACA4986BBACF8E45FEFE2C4DBD378933972382000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bGF5ZXJfb24gYW5kIGxheWVyX29mZiBib3RoIGFyZSB1bnVzZWQgZXh0ZXJuYWwgZnVuY3Rpb24s
DQpyZW1vdmUgdGhlbSBmcm9tIG10a19kZHBfY29tcF9mdW5jcyBzdHJ1Y3R1cmUuDQoNClNpZ25l
ZC1vZmYtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+DQpSZXZpZXdl
ZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9vdmwuYyAgICAgfCAgMiAtLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2RkcF9jb21wLmggfCAxNiAtLS0tLS0tLS0tLS0tLS0tDQogMiBmaWxlcyBj
aGFuZ2VkLCAxOCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9vdmwuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9vdmwuYw0KaW5kZXggNzIyYTVhZGI3OWRjLi44YTMyMjQ4NjcxYzMgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KQEAgLTMxNCw4ICszMTQsNiBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBtdGtfZGlzcF9vdmxfZnVuY3MgPSB7DQog
CS5kaXNhYmxlX3ZibGFuayA9IG10a19vdmxfZGlzYWJsZV92YmxhbmssDQogCS5zdXBwb3J0ZWRf
cm90YXRpb25zID0gbXRrX292bF9zdXBwb3J0ZWRfcm90YXRpb25zLA0KIAkubGF5ZXJfbnIgPSBt
dGtfb3ZsX2xheWVyX25yLA0KLQkubGF5ZXJfb24gPSBtdGtfb3ZsX2xheWVyX29uLA0KLQkubGF5
ZXJfb2ZmID0gbXRrX292bF9sYXllcl9vZmYsDQogCS5sYXllcl9jaGVjayA9IG10a19vdmxfbGF5
ZXJfY2hlY2ssDQogCS5sYXllcl9jb25maWcgPSBtdGtfb3ZsX2xheWVyX2NvbmZpZywNCiAJLmJn
Y2xyX2luX29uID0gbXRrX292bF9iZ2Nscl9pbl9vbiwNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZGRwX2NvbXAuaA0KaW5kZXggMTlhOTU1YWIwNzQ4Li5kYmZiOTBlOWI5Y2Yg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5o
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQpAQCAt
ODEsOCArODEsNiBAQCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIHsNCiAJdm9pZCAoKnVucHJl
cGFyZSkoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCk7DQogCXVuc2lnbmVkIGludCAoKnN1cHBv
cnRlZF9yb3RhdGlvbnMpKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXApOw0KIAl1bnNpZ25lZCBp
bnQgKCpsYXllcl9ucikoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCk7DQotCXZvaWQgKCpsYXll
cl9vbikoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWduZWQgaW50IGlkeCk7DQotCXZv
aWQgKCpsYXllcl9vZmYpKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVkIGludCBp
ZHgpOw0KIAlpbnQgKCpsYXllcl9jaGVjaykoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwNCiAJ
CQkgICB1bnNpZ25lZCBpbnQgaWR4LA0KIAkJCSAgIHN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnN0
YXRlKTsNCkBAIC0xNjUsMjAgKzE2Myw2IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IG10
a19kZHBfY29tcF9sYXllcl9ucihzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wKQ0KIAlyZXR1cm4g
MDsNCiB9DQogDQotc3RhdGljIGlubGluZSB2b2lkIG10a19kZHBfY29tcF9sYXllcl9vbihzdHJ1
Y3QgbXRrX2RkcF9jb21wICpjb21wLA0KLQkJCQkJIHVuc2lnbmVkIGludCBpZHgpDQotew0KLQlp
ZiAoY29tcC0+ZnVuY3MgJiYgY29tcC0+ZnVuY3MtPmxheWVyX29uKQ0KLQkJY29tcC0+ZnVuY3Mt
PmxheWVyX29uKGNvbXAsIGlkeCk7DQotfQ0KLQ0KLXN0YXRpYyBpbmxpbmUgdm9pZCBtdGtfZGRw
X2NvbXBfbGF5ZXJfb2ZmKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsDQotCQkJCQkgIHVuc2ln
bmVkIGludCBpZHgpDQotew0KLQlpZiAoY29tcC0+ZnVuY3MgJiYgY29tcC0+ZnVuY3MtPmxheWVy
X29mZikNCi0JCWNvbXAtPmZ1bmNzLT5sYXllcl9vZmYoY29tcCwgaWR4KTsNCi19DQotDQogc3Rh
dGljIGlubGluZSBpbnQgbXRrX2RkcF9jb21wX2xheWVyX2NoZWNrKHN0cnVjdCBtdGtfZGRwX2Nv
bXAgKmNvbXAsDQogCQkJCQkgICB1bnNpZ25lZCBpbnQgaWR4LA0KIAkJCQkJICAgc3RydWN0IG10
a19wbGFuZV9zdGF0ZSAqc3RhdGUpDQotLSANCjIuMTguMA0K

