Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3302C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6500B2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553518822;
	bh=Oxobca/3z0G2ANPjYLbu7xuZXFSL6KeVTmpPXAT74v0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vyPTtjx7a4sUFMkyQSHEu9X4jnttgdUjVB7in+Jxv/KWwipj7lQ9UuMMxoQcssPZ6
	 zIg06Nvf8QUARL80oLROVpjUmLTD3RiOKxwy2fgSCHWOSUqlm4k6Bk92VNcQKRG1vP
	 wxkhIkX9+uBD8EHy8y3hA8awLYdMCkpnWQG5c8ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbfCYNAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731076AbfCYNAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:00:20 -0400
Received: from localhost.localdomain (unknown [171.61.95.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA5B320830;
        Mon, 25 Mar 2019 13:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553518820;
        bh=Oxobca/3z0G2ANPjYLbu7xuZXFSL6KeVTmpPXAT74v0=;
        h=From:To:Cc:Subject:Date:From;
        b=gxvNhK0fpRfDZTndc4AsXYqnxpvC/BuPPg0pi8bS4A/H7FdzM+3Nctr83MjN/NZC0
         z638uZgv5ab0vKF3iIFWyU1/Tug1KKqDVLcx8G0HR9RQJ4V983Y/iyB9VnCpxZ0UBq
         ZLuuP/QWLDAfpAeHQsuPGHfwvPg/JixjKNnOPFxM=
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
Date:   Mon, 25 Mar 2019 18:29:45 +0530
Message-Id: <20190325125946.6818-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM8XXX RTC driver is used as RTC is bunch of Qualcomm platforms so add
it to defconfig.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..5dbe372ee913 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -603,6 +603,9 @@ CONFIG_LEDS_TRIGGER_PANIC=y
 CONFIG_EDAC=y
 CONFIG_EDAC_GHES=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
 CONFIG_RTC_DRV_S5M=y
@@ -611,6 +614,7 @@ CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_CROS_EC=y
 CONFIG_RTC_DRV_S3C=y
 CONFIG_RTC_DRV_PL031=y
+CONFIG_RTC_DRV_PM8XXX=y
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_ARMADA38X=y
 CONFIG_RTC_DRV_TEGRA=y
-- 
2.20.1

