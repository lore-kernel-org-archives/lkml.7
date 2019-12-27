Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBECC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A694206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469955;
	bh=ZMe5PCi44onBsQSMmx6BzVqwcH/iyoiNk7gBWQzdsZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QTAlH2gp3Yq16XLNUAW5WSYe/T9WZk50YiEyLQMmwDnqolWFRSfzoEXLUwRL+ivc6
	 jyBqu4jpOIKJPiUL7X/LX4oV0M4wdO2VpC2/woUxZMV7bMlFlkTZSiFh3UUacS22oq
	 rvXJW+dcdxNzx5QpjGpk3RPeQeqMGvtlJwnoH+e8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfL0SC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:02:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbfL0SCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:02:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DDE021927;
        Fri, 27 Dec 2019 18:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577469772;
        bh=ZMe5PCi44onBsQSMmx6BzVqwcH/iyoiNk7gBWQzdsZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zPvrCdYqC5CRsXNeV1rSYi44n0lXpZsdDOsDJcCePn5+vVqOiDeDOQgMBnMYN16wO
         eDWmCt5T7DFTXV3tQZ8GGsYoMGrp6wPS1puI3M2LGzy0TK/KcJt0oO8PkoZ9Tfx9vU
         awx8zALydic10fwkmYqW+3gJ/VpqXvx/cL/FG/To=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 23/57] ARM: dts: am437x-gp/epos-evm: fix panel compatible
Date:   Fri, 27 Dec 2019 13:01:48 -0500
Message-Id: <20191227180222.7076-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227180222.7076-1-sashal@kernel.org>
References: <20191227180222.7076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit c6b16761c6908d3dc167a0a566578b4b0b972905 ]

The LCD panel on AM4 GP EVMs and ePOS boards seems to be
osd070t1718-19ts. The current dts files say osd057T0559-34ts. Possibly
the panel has changed since the early EVMs, or there has been a mistake
with the panel type.

Update the DT files accordingly.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am437x-gp-evm.dts  | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index afb8eb0a0a16..051823b7e5a1 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -83,7 +83,7 @@
 		};
 
 	lcd0: display {
-		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
+		compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
 		label = "lcd";
 
 		panel-timing {
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 081fa68b6f98..c4279b0b9f12 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -45,7 +45,7 @@
 	};
 
 	lcd0: display {
-		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
+		compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
 		label = "lcd";
 
 		panel-timing {
-- 
2.20.1

