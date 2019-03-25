Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBDDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891412087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553518828;
	bh=QkIuCUg1TpGGMYoP+yb6nSRh3mbNuGY7tGOH4j1SGwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mcwTBoUtGsjuaBPCNGAajoCWCTQ5uW+YfqqH1t8g2uRACaBWTy56ieBZibkWDma8G
	 sPAxTfCGyADBPxILIbPTpciN3n7QMsDxCWkBsfGdt1sD9AcaZo/YmkEH2UYd6ryUjb
	 rpDvqhiGACxGcDSN0lHk+jF5+Q+fosKO9SabUsAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbfCYNA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731229AbfCYNAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:00:25 -0400
Received: from localhost.localdomain (unknown [171.61.95.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE0E120879;
        Mon, 25 Mar 2019 13:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553518825;
        bh=QkIuCUg1TpGGMYoP+yb6nSRh3mbNuGY7tGOH4j1SGwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVnZ3Cpz1HtvOZRrI9Wrc7s09NUjZEk5i5R+Lcubhg+kGTK6o2A/bhoTm3uFJALdj
         QxX0dSfxNMQFKlCWqSXq5bXsrs7lmipPbAS2zLk11aopzV4bmsZdDl7cKR91/bFQWk
         HHdQs0C+L+H+AzZSwUERXuc+oBO5DNSmYIX0dkKg=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: defconfig: Enable RTC driver PM8XXX
Date:   Mon, 25 Mar 2019 18:29:46 +0530
Message-Id: <20190325125946.6818-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325125946.6818-1-vkoul@kernel.org>
References: <20190325125946.6818-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sun, 24 Mar 2019 21:44:31 +0530
Subject: [PATCH 2/2] arm64: defconfig: Enable stmmac qualcomm ethernet config

Some platforms like QCS404 sport stmmac ethernet conrollers, enable the
configs and phy drivers for it.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/configs/defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5dbe372ee913..417ca71475c2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -173,6 +173,10 @@ CONFIG_IP6_NF_NAT=m
 CONFIG_IP6_NF_TARGET_MASQUERADE=m
 CONFIG_BRIDGE=m
 CONFIG_BRIDGE_VLAN_FILTERING=y
+CONFIG_HAVE_NET_DSA=y
+CONFIG_NET_DSA=y
+CONFIG_NET_DSA_LEGACY=y
+CONFIG_NET_DSA_TAG_QCA=y
 CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
 CONFIG_VLAN_8021Q_MVRP=y
@@ -243,6 +247,7 @@ CONFIG_MACVTAP=m
 CONFIG_TUN=y
 CONFIG_VETH=m
 CONFIG_VIRTIO_NET=y
+CONFIG_NET_DSA_QCA8K=y
 CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
 CONFIG_ATL1C=m
@@ -268,6 +273,10 @@ CONFIG_SMSC911X=y
 CONFIG_SNI_AVE=y
 CONFIG_SNI_NETSEC=y
 CONFIG_STMMAC_ETH=m
+CONFIG_STMMAC_PLATFORM=m
+CONFIG_DWMAC_QCOM_ETHQOS=m
+CONFIG_MDIO_DEVICE=y
+CONFIG_MDIO_BUS=y
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
 CONFIG_AT803X_PHY=m
 CONFIG_MARVELL_PHY=m
-- 
2.20.1

