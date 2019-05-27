Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A98C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537032173C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfE0JFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:05:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33850 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726684AbfE0JFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:05:42 -0400
X-UUID: f1a760e490f7477390f796c5b5565aa0-20190527
X-UUID: f1a760e490f7477390f796c5b5565aa0-20190527
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1113039921; Mon, 27 May 2019 17:05:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 27 May 2019 17:05:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 27 May 2019 17:05:09 +0800
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <erin.lo@mediatek.com>,
        <mars.cheng@mediatek.com>, <eddie.huang@mediatek.com>,
        "Hsin-Yi, Wang" <hsinyi@chromium.org>
Subject: [PATCH v11 2/6] arm64: dts: mt8183: add capacity-dmips-mhz
Date:   Mon, 27 May 2019 17:04:43 +0800
Message-ID: <1558947887-31084-3-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
References: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BEBDBD6161B4C7896DDE90CE14127A1A65E236348D2D7160142575FA14673EBB2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Hsin-Yi, Wang" <hsinyi@chromium.org>

Pinned the frequency to the max and run dhrystone to get the value.
little cpu: 11071 (max freq: 1989000)
big cpu: 15293 (max freq: 1989000)

11071 : 15293 ~= 741 : 1024

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 08274bf..5b34ec6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -56,6 +56,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x000>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <741>;
 		};
 
 		cpu1: cpu@1 {
@@ -63,6 +64,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x001>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <741>;
 		};
 
 		cpu2: cpu@2 {
@@ -70,6 +72,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x002>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <741>;
 		};
 
 		cpu3: cpu@3 {
@@ -77,6 +80,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x003>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <741>;
 		};
 
 		cpu4: cpu@100 {
@@ -84,6 +88,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x100>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 		};
 
 		cpu5: cpu@101 {
@@ -91,6 +96,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x101>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 		};
 
 		cpu6: cpu@102 {
@@ -98,6 +104,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x102>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 		};
 
 		cpu7: cpu@103 {
@@ -105,6 +112,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x103>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 		};
 	};
 
-- 
1.8.1.1.dirty

