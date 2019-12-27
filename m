Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49970C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC5320722
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577470738;
	bh=ToLPPtJfE+wN/2xv6SeS8tOQ77wFmdJQl3445EtNQdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J0i1+zgHU1YwHQVoRy5PUF94Ph7tDBMk5KFopDdEPVwVLWhca91tg/ebOhSL95TxM
	 zElYXyyyBC2HdL1TLK/UxQzhHCHlFAeSaUHD2Va3J0cHsjJi9MkTRp82+2BrGVDrdD
	 tEEtzC0OnR8fNZ/BqL2067TO3u20b/HcUmmzU1Oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfL0SO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:14:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbfL0SOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:14:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CF7721744;
        Fri, 27 Dec 2019 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577470494;
        bh=ToLPPtJfE+wN/2xv6SeS8tOQ77wFmdJQl3445EtNQdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VzLjhrMUqAkHDOHBe8FLeS80UX9VJKxdHQ2fBYUm2KZWgLtfsvFas1B5luaJ64ALJ
         RA/Uc/T+zH2pYqZewcGUveldXk4qzcWLQMzkTFLUv3/C9zctmKe2LW0ha13DBtZv21
         kqjK81jtnuSpiZgbHYW+AsiKrIVRziMpD566d0Pw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 14/38] ARM: dts: am437x-gp/epos-evm: fix panel compatible
Date:   Fri, 27 Dec 2019 13:14:11 -0500
Message-Id: <20191227181435.7644-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227181435.7644-1-sashal@kernel.org>
References: <20191227181435.7644-1-sashal@kernel.org>
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
index 957840cc7b78..b55c094893c6 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -79,7 +79,7 @@
 		};
 
 	lcd0: display {
-		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
+		compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
 		label = "lcd";
 
 		panel-timing {
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 9d35c3f07cad..21918807c9f6 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -41,7 +41,7 @@
 	};
 
 	lcd0: display {
-		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
+		compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
 		label = "lcd";
 
 		panel-timing {
-- 
2.20.1

