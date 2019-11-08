Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9390FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9623221D82
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213332;
	bh=Namszi3+CY32Cp3LiVs8v5sb0kNQove0cRjpl1dbsm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p9iD5xIce4F1BEC6p90bMDl4nmKQSMmI3x1ATTnB//YuFnbWDYychlZIsMOHL7S4M
	 ElYs8yjAI/D38DtCrNMcwaL+aDbQNd2praIafKy2bsENE3KWyatfZdSSVmVRpNTsuW
	 60XAaA+NJEbZpRfm+0+KZmvQ4TF3jqXoEhcWeAM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389820AbfKHLmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:42:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389788AbfKHLmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:42:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97CBC222C4;
        Fri,  8 Nov 2019 11:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213327;
        bh=Namszi3+CY32Cp3LiVs8v5sb0kNQove0cRjpl1dbsm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNDRgzAibqVKfFjuL6ARILEbza7nyeX9xAuESpt/IiiUhVE/26TeJis8ERjeJlqB7
         mXSpKDtbNxCznT4dKsgeZv/SN9WzdMm8nzj1LmL3cmPaf8Nre3ruqmIgI8IrBcCOZR
         bmKZ9cDIfJj74u/lEdEVo/1qAWXqymwX8mOwIWpU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 169/205] arm64: dts: renesas: r8a77965: Fix clock/reset for usb2_phy1
Date:   Fri,  8 Nov 2019 06:37:16 -0500
Message-Id: <20191108113752.12502-169-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 7a590fe317488783a229e5a80e91868942e8463f ]

usb2_phy1 accidentally uses the same clock/reset as usb2_phy0.

Fixes: b5857630a829a8d5 ("arm64: dts: renesas: r8a77965: add usb2_phy nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 2ccb1138cdf0c..f1dfd17413b9e 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1479,9 +1479,9 @@
 			compatible = "renesas,usb2-phy-r8a77965",
 				     "renesas,rcar-gen3-usb2-phy";
 			reg = <0 0xee0a0200 0 0x700>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 702>;
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 702>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
-- 
2.20.1

