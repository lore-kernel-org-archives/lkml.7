Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71F1C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97E920830
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfDHRyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:54:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46576 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHRyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:54:10 -0400
Received: from localhost.localdomain (unknown [IPv6:2a02:2450:102f:3e0:206d:2b5a:d2bf:2bc6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1AE33282B7E;
        Mon,  8 Apr 2019 18:54:09 +0100 (BST)
From:   Robert Foss <robert.foss@collabora.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Foss <robert.foss@collabora.com>
Subject: [PATCH] ARM: dts: imx6qdl-nitrogen6_max: Disable LVDS channels
Date:   Mon,  8 Apr 2019 19:53:19 +0200
Message-Id: <20190408175319.9106-1-robert.foss@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a LVDS device is not connected, having the LVDS channels
enabled will prevent imx-ldb from probing correctly even
if other CRTCs are connected.

Signed-off-by: Robert Foss <robert.foss@collabora.com>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index 39200e5dc896..5b413cf4c250 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -703,7 +703,7 @@
 	status = "okay";
 
 	lvds-channel@0 {
-		status = "okay";
+		status = "disabled";
 
 		port@4 {
 			reg = <4>;
@@ -715,7 +715,7 @@
 	};
 
 	lvds-channel@1 {
-		status = "okay";
+		status = "disabled";
 
 		port@4 {
 			reg = <4>;
-- 
2.19.1

