Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96B0FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A24218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393261AbfJPMsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:48:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53124 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390639AbfJPMsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:48:31 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A20E7200534;
        Wed, 16 Oct 2019 14:48:29 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 94E9C20052F;
        Wed, 16 Oct 2019 14:48:29 +0200 (CEST)
Received: from fsr-ub1664-026.ea.freescale.net (fsr-ub1664-026.ea.freescale.net [10.171.81.59])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E789D205D2;
        Wed, 16 Oct 2019 14:48:28 +0200 (CEST)
From:   Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     corbet@lwn.net, robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com
Cc:     jslaby@suse.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@nxp.com>
Subject: [PATCH v7 1/5] dt-bindings: arm: fsl: Add the S32V234-EVB board
Date:   Wed, 16 Oct 2019 15:48:23 +0300
Message-Id: <1571230107-8493-2-git-send-email-stefan-gabriel.mirea@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571230107-8493-1-git-send-email-stefan-gabriel.mirea@nxp.com>
References: <1571230107-8493-1-git-send-email-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddy Petrișor <eddy.petrisor@nxp.com>

Add entry for the NXP S32V234 Customer Evaluation Board to the board/SoC
bindings.

Signed-off-by: Eddy Petrișor <eddy.petrisor@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1b4b4e6573b5..c211f4f82e25 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -335,4 +335,10 @@ properties:
               - fsl,ls2088a-rdb
           - const: fsl,ls2088a
 
+      - description: S32V234 based Boards
+        items:
+          - enum:
+              - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
+          - const: fsl,s32v234
+
 ...
-- 
2.22.0

