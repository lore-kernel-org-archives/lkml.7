Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17020C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52B22133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCSF5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:57:22 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:51430 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfCSF5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 01:57:20 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1h67kU-00065H-MQ from Jiada_Wang@mentor.com ; Mon, 18 Mar 2019 22:57:18 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 18 Mar 2019 22:57:15 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <horms@verge.net.au>, <magnus.damm@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kuninori.morimoto.gx@renesas.com>,
        <geert@linux-m68k.org>, <jiada_wang@mentor.com>
Subject: [PATCH v3 2/3] arm64: dts: renesas: r8a7796: use extended audio dmac register
Date:   Tue, 19 Mar 2019 14:57:04 +0900
Message-ID: <20190319055705.24115-3-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190319055705.24115-1-jiada_wang@mentor.com>
References: <20190319055705.24115-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SVR-ORW-MBX-06.mgc.mentorg.com (147.34.90.206) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basic audio dmac register only supports busif from 0 to 3,
in order to use busif4 ~ busif7, extended audio dmac register
need to be used

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index cdf784899cf8..13c6b5b3e8e0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1775,7 +1775,7 @@
 				<0 0xec5a0000 0 0x100>,  /* ADG */
 				<0 0xec540000 0 0x1000>, /* SSIU */
 				<0 0xec541000 0 0x280>,  /* SSI */
-				<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+				<0 0xec760000 0 0x200>;  /* Audio DMAC peri peri*/
 			reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
 			clocks = <&cpg CPG_MOD 1005>,
-- 
2.19.2

