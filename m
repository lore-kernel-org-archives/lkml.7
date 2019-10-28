Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D063CA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2076208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfJ1Luy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:50:54 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:12766 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727193AbfJ1Lux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:50:53 -0400
X-UUID: 6eff7a57a2c14af0a64709c8b466e61c-20191028
X-UUID: 6eff7a57a2c14af0a64709c8b466e61c-20191028
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 141870674; Mon, 28 Oct 2019 19:50:41 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Oct
 2019 19:50:43 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Mon, 28 Oct 2019 19:50:40 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v3 2/3] arm64: dts: mt8183: add pwm0 node
Date:   Mon, 28 Oct 2019 19:50:38 +0800
Message-ID: <20191028115039.96555-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028115039.96555-1-jitao.shi@mediatek.com>
References: <20191028115039.96555-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-SNTS-SMTP: 98A9F57C42DDB5110FC2E23E8EE9E8ADDA526154EFFC73ED1E0BA6EC9E506D522000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pwm0 node to the mt8183

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index bb0d53be6a25..2b6e010d6866 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -643,6 +643,17 @@
 			};
 		};
 
+		pwm0: pwm@1100e000 {
+			compatible = "mediatek,mt8183-disp-pwm";
+			reg = <0 0x1100e000 0 0x1000>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
+			#pwm-cells = <2>;
+			clocks = <&topckgen CLK_TOP_MUX_DISP_PWM>,
+					<&infracfg CLK_INFRA_DISP_PWM>;
+			clock-names = "main", "mm";
+		};
+
 		audiosys: syscon@11220000 {
 			compatible = "mediatek,mt8183-audiosys", "syscon";
 			reg = <0 0x11220000 0 0x1000>;
-- 
2.21.0

