Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BECC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493DB217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563958878;
	bh=yBAnck0a4ywFG/ldgxyJv4Ottr0LI7k/WsimCCQatO8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uCKejGshSyN4SpnwfagaOzxwYLMVOlQWRBC6vdge725jPilqXPgRn14C5cS10XoZr
	 1n2fb88ZjXlFO/AiiFiiXxmB5vj9N+CeqYdc6Vb+/dJAAp6oNZdbhahTmI4SUgaV/+
	 A62ZrnelN97zdoKdgAV1+WulABnDlKiXvf7QQ3Pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfGXJBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 05:01:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:64872 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726824AbfGXJBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:01:16 -0400
X-UUID: 66cd01796bfa41d598860e4b8dbef898-20190724
X-UUID: 66cd01796bfa41d598860e4b8dbef898-20190724
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@kernel.org>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 919272540; Wed, 24 Jul 2019 17:01:03 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 17:01:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Jul 2019 17:01:02 +0800
From:   <ryder.lee@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Weijie Gao <weijie.gao@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] dt-bindings: gpu: mali-utgard: add mediatek, mt7623-mali compatible
Date:   Wed, 24 Jul 2019 17:01:00 +0800
Message-ID: <efeadefe3895bcadf1d2e9847b82206dd8c7ec35.1563867856.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <af7b5a2e00eb3a4b6262807c378e43afd5f74779.1563867856.git.ryder.lee@mediatek.com>
References: <af7b5a2e00eb3a4b6262807c378e43afd5f74779.1563867856.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The MediaTek MT7623 SoC contains a Mali-450, so add a compatible for it
and define its own vendor-specific properties.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index ae63f09fda7d..73021e2dda25 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -17,6 +17,7 @@ Required properties:
       + amlogic,meson8b-mali
       + amlogic,meson-gxbb-mali
       + amlogic,meson-gxl-mali
+      + mediatek,mt7623-mali
       + rockchip,rk3036-mali
       + rockchip,rk3066-mali
       + rockchip,rk3188-mali
@@ -88,6 +89,10 @@ to specify one more vendor-specific compatible, among:
     Required properties:
       * resets: phandle to the reset line for the GPU
 
+  - mediatek,mt7623-mali
+     Required properties:
+      * resets: phandle to the reset line for the GPU
+
   - Rockchip variants:
     Required properties:
       * resets: phandle to the reset line for the GPU
-- 
2.18.0

