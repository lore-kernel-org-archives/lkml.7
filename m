Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87378C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5479520685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfDVJWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:22:47 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44806 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfDVJWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:22:46 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BEF391A0025;
        Mon, 22 Apr 2019 11:22:44 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C44521A008F;
        Mon, 22 Apr 2019 11:22:40 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8B6AF402A6;
        Mon, 22 Apr 2019 17:22:35 +0800 (SGT)
From:   andy.tang@nxp.com
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 1/2] dt-bindings: qoriq-clock: add more PLL divider clocks support
Date:   Mon, 22 Apr 2019 17:15:08 +0800
Message-Id: <20190422091509.3181-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

More PLL divider clocks are needed by clock consumer IP. So update
the PLL divider description to make it more general.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 .../devicetree/bindings/clock/qoriq-clock.txt      |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index c655f28..27aeed0 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -83,8 +83,8 @@ second cell is the clock index for the specified type.
 	1	cmux		index (n in CLKCnCSR)
 	2	hwaccel		index (n in CLKCGnHWACSR)
 	3	fman		0 for fm1, 1 for fm2
-	4	platform pll	0=pll, 1=pll/2, 2=pll/3, 3=pll/4
-				4=pll/5, 5=pll/6, 6=pll/7, 7=pll/8
+	4	platform pll	n=pll/(n+1). For example, when n=1,
+				that means output_freq=PLL_freq/2.
 	5	coreclk		must be 0
 
 3. Example
-- 
1.7.1

