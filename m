Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC9DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2E72075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Xd/K+jCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfCLOZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:25:11 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3199 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfCLOZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:25:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c87c1450002>; Tue, 12 Mar 2019 07:25:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Mar 2019 07:25:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Mar 2019 07:25:10 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Mar
 2019 14:25:10 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 12 Mar 2019 14:25:10 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c87c1440000>; Tue, 12 Mar 2019 07:25:10 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <treding@nvidia.com>
CC:     <jonathanh@nvidia.com>, <josephl@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] arm64: tegra: dts: enable aconnect, adma and agic
Date:   Tue, 12 Mar 2019 19:55:04 +0530
Message-ID: <1552400705-1179-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552400709; bh=0TBTWXGdsIk2e4gu1wVle+UWJwE/UTaqzozX79FMPHc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=Xd/K+jCYsdJLfrdiUUtCrtSDMq2UZHztZbaozVn/e4yTuhBRDXZkwMPPcckWCGY0v
         TvTI5z9jX/GLMgTSrTdKG+jX5Lye9x7F9vdA+XUV5Xev2s//4NevZpKcZgyMLkdIW9
         6p+cYZzdwFih7As9HsLFa0QAqiw6MsNeXKN3aTvdBiCGL0UGJoN9KN/7a9l3WMLy2j
         Bs18WCqsd8tzkXIG4egI5KzncjUQ3CbeVpAyr4RUHF4iH4fi4/VXcSJ0ldCbm11hP9
         TMDSqWoSlINA0dX6d3DmbKDiwJm15YVHj9YYIMPuOJ52hknGRpMXFiO2niOGlUworq
         WIhjRbIHqIqdg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable aconnect, adma and agic for Tegra Jetson TX1.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index 9fad0d2..5a57396 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -99,4 +99,16 @@
 		pinctrl-0 = <&dvfs_pwm_active_state>;
 		pinctrl-1 = <&dvfs_pwm_inactive_state>;
 	};
+
+	aconnect@702c0000 {
+		status = "okay";
+
+		dma@702e2000 {
+			status = "okay";
+		};
+
+		agic@702f9000 {
+			status = "okay";
+		};
+	};
 };
-- 
2.7.4

