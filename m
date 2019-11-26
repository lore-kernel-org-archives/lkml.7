Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DDFC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92F72071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nTmrKgF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKZGsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 01:48:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:14539 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725765AbfKZGsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 01:48:06 -0500
X-UUID: db699e4521d2452290f4e1aecce9bf05-20191126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nJCMS+Zb2KV7c0nSvZbugfFbLOeQLmtQW9fHLXvNcd8=;
        b=nTmrKgF6DdCMqV6Xarm3fgQ1xcW7h0+fzhjtyUo+Q+xbeAQJcXcLMtTf1xGRSpCLuknPNhAjNVRG0unFJAGAuEV14nwYQYF7F7DSTZ6jJAldnk0iSt5qrqfDgpHFCe78+/a6JhJCD3XbGRtZY6KrC+EA/996YN5RKvlxEjpaetA=;
X-UUID: db699e4521d2452290f4e1aecce9bf05-20191126
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1907628759; Tue, 26 Nov 2019 14:48:01 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Nov 2019 14:47:51 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Nov 2019 14:48:23 +0800
From:   <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1] drm/mediatek: fix up 1440x900 dp display black screen issue
Date:   Tue, 26 Nov 2019 14:47:49 +0800
Message-ID: <1574750869-12611-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQoNClRoaXMg
cGF0Y2ggZml4IHVwIDE0NDB4OTAwIGRwIGRpc3BsYXkgYmxhY2sgc2NyZWVuIGlzc3VlDQp0aGUg
Y29tcHV0ZWQgcmVzdWx0IHdpbGwgb3ZlcmZsb3cgcmRtYTEgZmlmbyBtYXggc2l6ZQ0Kd2hlbiBl
eHRlcm5hbCBkaXNwbGF5IHBpeGVsIGNsb2NrIGJpZ2dlciB0aGFuIDc0TUhaDQoNClNpZ25lZC1v
ZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYyB8IDQgKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3BfcmRtYS5jDQppbmRleCBjMWFiZGUzLi40MTE0M2Y1IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX3JkbWEuYw0KQEAgLTE1Miw2ICsxNTIsMTAgQEAgc3RhdGljIHZv
aWQgbXRrX3JkbWFfY29uZmlnKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVkIGlu
dCB3aWR0aCwNCiAJICogYWNjb3VudCBmb3IgYmxhbmtpbmcsIGFuZCB3aXRoIGEgcGl4ZWwgZGVw
dGggb2YgNCBieXRlczoNCiAJICovDQogCXRocmVzaG9sZCA9IHdpZHRoICogaGVpZ2h0ICogdnJl
ZnJlc2ggKiA0ICogNyAvIDEwMDAwMDA7DQorDQorCWlmICh0aHJlc2hvbGQgPiByZG1hX2ZpZm9f
c2l6ZSkNCisJCXRocmVzaG9sZCA9IHJkbWFfZmlmb19zaXplOw0KKw0KIAlyZWcgPSBSRE1BX0ZJ
Rk9fVU5ERVJGTE9XX0VOIHwNCiAJICAgICAgUkRNQV9GSUZPX1BTRVVET19TSVpFKHJkbWFfZmlm
b19zaXplKSB8DQogCSAgICAgIFJETUFfT1VUUFVUX1ZBTElEX0ZJRk9fVEhSRVNIT0xEKHRocmVz
aG9sZCk7DQotLSANCjEuOC4xLjEuZGlydHkNCg==

