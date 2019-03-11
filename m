Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92B6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77614206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfCKH0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:26:45 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43548 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfCKH0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:26:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 875C4200078;
        Mon, 11 Mar 2019 08:26:42 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 37722200244;
        Mon, 11 Mar 2019 08:26:37 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 59146402BC;
        Mon, 11 Mar 2019 15:26:30 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     axboe@kernel.dk, robh+dt@kernel.org, shawnguo@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        andy.tang@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Ma <peng.ma@nxp.com>
Subject: [PATCH 1/3] dt-bindings: ahci-fsl-qoriq: add ls1028a chip name to the list
Date:   Mon, 11 Mar 2019 15:20:12 +0800
Message-Id: <20190311072014.36565-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ls1028a compatible to bindings documentation.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
depends on:
	- http://patchwork.ozlabs.org/patch/1045217/

 .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
index 9ecc019..72fdeef 100644
--- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
@@ -3,7 +3,8 @@ Binding for Freescale QorIQ AHCI SATA Controller
 Required properties:
   - reg: Physical base address and size of the controller's register area.
   - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
-    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a, lx2160a, etc.
+    chip could be ls1021a, ls1028a, ls1043a, ls1046a, ls1088a, ls2080a,
+    lx2160a, etc.
   - clocks: Input clock specifier. Refer to common clock bindings.
   - interrupts: Interrupt specifier. Refer to interrupt binding.
 
-- 
1.7.1

