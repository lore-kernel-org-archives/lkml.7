Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030DDC2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8D42067D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468987;
	bh=Ph4eGXzhNUrMfMJ+w7vrBMob23ualE7r8SGPNrE8qdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BRjP73WpWIx5s+4YQR6fW1nO7sfPRYvuLhbem1ep86n2boBBXsz1Scpq7eylRoWIM
	 itN09xNJozH/fTJSMj5P4OdSE/swTQOnFZXY49uDh4KND8lcNsAkFcI3nzfBom5aVg
	 GuoOTIVb2eHYMQu4UwN5Yy/tq1YJz3S7zYDa0Ihw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfL0Rtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:49:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbfL0RoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:44:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F16B24653;
        Fri, 27 Dec 2019 17:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468664;
        bh=Ph4eGXzhNUrMfMJ+w7vrBMob23ualE7r8SGPNrE8qdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUGDplx58yJKvE5icCZQdeowepaj/1GRkeuS51zEe5ctSiBGn0h7nFxK0DGin2+xU
         K5wKiBIpOc4NRzR3VN8GxVny1qvpc1SVNDnAALVhoGqgy2spp/qcDDMhYYTmNkgI0S
         jcegMkN0BnhwE+/nBTiOWZ9u1WBvxCj8q3fFTLrs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Simon Horman <simon.horman@netronome.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 25/84] ARM: dts: Cygnus: Fix MDIO node address/size cells
Date:   Fri, 27 Dec 2019 12:42:53 -0500
Message-Id: <20191227174352.6264-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit fac2c2da3596d77c343988bb0d41a8c533b2e73c ]

The MDIO node on Cygnus had an reversed #address-cells and
 #size-cells properties, correct those.

Fixes: 40c26d3af60a ("ARM: dts: Cygnus: Add the ethernet switch and ethernet PHY")
Reported-by: Simon Horman <simon.horman@netronome.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 253df7170a4e..887a60c317e9 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -169,8 +169,8 @@
 		mdio: mdio@18002000 {
 			compatible = "brcm,iproc-mdio";
 			reg = <0x18002000 0x8>;
-			#size-cells = <1>;
-			#address-cells = <0>;
+			#size-cells = <0>;
+			#address-cells = <1>;
 			status = "disabled";
 
 			gphy0: ethernet-phy@0 {
-- 
2.20.1

