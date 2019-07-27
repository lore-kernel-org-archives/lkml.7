Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84B4C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 14:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E5E2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564237692;
	bh=bYISLdJ+F7qw2nctD3/WBahrNFRy0w70PfyOPJ7kIy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wtTRyuoyK7aLO1z6sXX11KuVh/uG/LZkfgJVEdXnrgCpGDso3OX2TWzzX461LPFOG
	 gnUYoIMLfzgb5yjcPByRKRCAFGthGu0+QcZLcn8GjldfbzaTdOGt9rHK7b+bk3Ha6P
	 wW0NDmiuCCZsvF+i/HrVNOL/x58OvEd6SOIEhFD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfG0O2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 10:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfG0O2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 10:28:10 -0400
Received: from localhost.localdomain (unknown [194.230.155.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBDBC2084C;
        Sat, 27 Jul 2019 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564237689;
        bh=bYISLdJ+F7qw2nctD3/WBahrNFRy0w70PfyOPJ7kIy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zi02F05HUej5+7FkK/HByH0RM+B3tXPISFtSAD6Y8J/ZiKzVC5RFYNR0uLuAacgMB
         5fDnwcjtZQD4B/NdA0Tp2T7ZQWUVtqW9OrhQBNQNQktfyFykpEDLztksIPPiP5tp8y
         XAD64mtDOd/J2/SUE6t6B1/axxrZeXCsHK1Gxo2o=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] ARM: dts: rockchip: Add missing unit address to memory node on rk3288-veyron
Date:   Sat, 27 Jul 2019 16:27:36 +0200
Message-Id: <20190727142736.23188-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190727142736.23188-1-krzk@kernel.org>
References: <20190727142736.23188-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix DTC warning:

    arch/arm/boot/dts/rk3288-veyron.dtsi:21.9-24.4:
    Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/rk3288-veyron.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 8fc8eac699bf..02243ff46a65 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -18,7 +18,7 @@
 	 * The default coreboot on veyron devices ignores memory@0 nodes
 	 * and would instead create another memory node.
 	 */
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
-- 
2.17.1

