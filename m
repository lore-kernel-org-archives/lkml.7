Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C78C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEB820707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419239;
	bh=iNI6aIqX57rJOwK0WFOJwkCfxZwraFcXPRaFy23k3mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v0+58yW3/MwLAZo+9GgWizbtmZzVN3ijISWrUfybAgGGCEHP0I67wq6xOiVdQC5dV
	 V8ZLIE08VS1VLdF+KD/XCO9FfqUc2b+JxCn8TfUH2RFx4AiFN/YlKlPEV6IlGW6AOu
	 /lyUVUyD9nuKMU5oFFhQnIw/+l31CQ8fSsk4Vzvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfKVKki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbfKVKkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:40:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 592682071F;
        Fri, 22 Nov 2019 10:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419235;
        bh=iNI6aIqX57rJOwK0WFOJwkCfxZwraFcXPRaFy23k3mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QW8O3vt/Z6C2WEbJyspr8+LIxLKxGbpPlJlGp4z3hyGo4eBr1f8zdIV155qeu+GVW
         aVdlXz6ax2CKMTMrttWq3Y1k41cH2VVRpjIpKiGVR+034/DwjqmdPXEVHotXAeaWqb
         Qg8gHdptSWVnx0fSCUv5iZp1bKJk9TmsnAXmcHKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 043/222] ARM: dts: omap3-gta04: give spi_lcd node a label so that we can overwrite in other DTS files
Date:   Fri, 22 Nov 2019 11:26:23 +0100
Message-Id: <20191122100851.148276671@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: H. Nikolaus Schaller <hns@goldelico.com>

[ Upstream commit fa0d7dc355c890725b6178dab0cc11b194203afa ]

needed for device variants based on GTA04 board but with
different display panel (driver).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index b3a8b1f24499a..95c6ac44e307f 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -70,7 +70,7 @@
 		#sound-dai-cells = <0>;
 	};
 
-	spi_lcd {
+	spi_lcd: spi_lcd {
 		compatible = "spi-gpio";
 		#address-cells = <0x1>;
 		#size-cells = <0x0>;
-- 
2.20.1



