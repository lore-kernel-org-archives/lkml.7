Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85D3C4321B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 11:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C021D2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 11:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389499AbfFKL3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 07:29:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1846 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389415AbfFKL33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 07:29:29 -0400
X-UUID: c15b6bf4ca314ef0b2777e638b3cb723-20190611
X-UUID: c15b6bf4ca314ef0b2777e638b3cb723-20190611
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <dehui.sun@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 195555823; Tue, 11 Jun 2019 19:29:20 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Jun 2019 19:29:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Jun 2019 19:29:18 +0800
From:   Dehui Sun <dehui.sun@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <erin.lo@mediatek.com>,
        <weiyi.lu@mediatek.com>, <dehui.sun@mediatek.com>
Subject: [PATCH v1 1/2] dt-bindings: mediatek: update bindings for MT8183 systimer
Date:   Tue, 11 Jun 2019 19:28:53 +0800
Message-ID: <1560252534-11412-2-git-send-email-dehui.sun@mediatek.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1560252534-11412-1-git-send-email-dehui.sun@mediatek.com>
References: <1560252534-11412-1-git-send-email-dehui.sun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds mt8183 compatible node in mtk-timer binding document.

Signed-off-by: Dehui Sun <dehui.sun@mediatek.com>
---
 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 74c3ead..0d25648 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -21,6 +21,7 @@ Required properties:
 	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
 
 	For those SoCs that use SYST
+	* "mediatek,mt8183-timer" for MT8183 compatible timers (SYST)
 	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
 	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
 
-- 
2.1.0

