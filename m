Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A4BC4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 08:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF15206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 08:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="eAWPAgXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfJMIIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 04:08:48 -0400
Received: from onstation.org ([52.200.56.107]:42520 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbfJMIIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 04:08:13 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 20CFA3F23F;
        Sun, 13 Oct 2019 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1570954092;
        bh=RFVcO9gNV5m28sPqWhNYJuMIlJLrDv2gh/shvbSVCKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAWPAgXhu/zLzu/tIO9VKC21LDCT1yLHYXIU2BBh3mm5Bj60waonRBKKpK+YpjaKT
         iL0LRToFu87l/7LLYHFqgQLzBSkhyH+ODJDhNeNMqIqB6moDQLXnaUmwAoEHnR+unz
         FO2GvpasrZqWSfegYO5Q2ZfR3kJjOzZf1s1foEsw=
From:   Brian Masney <masneyb@onstation.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] ARM: qcom_defconfig: add anx78xx HDMI bridge support
Date:   Sun, 13 Oct 2019 04:08:02 -0400
Message-Id: <20191013080804.10231-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191013080804.10231-1-masneyb@onstation.org>
References: <20191013080804.10231-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Analogix anx78xx driver so that the external display over HDMI
can be used on Nexus 5 phones.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 32fc8a24e5c7..f95cc49a1ddb 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -149,6 +149,7 @@ CONFIG_MEDIA_SUPPORT=y
 CONFIG_DRM=y
 CONFIG_DRM_MSM=m
 CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_ANALOGIX_ANX78XX=m
 CONFIG_FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 # CONFIG_LCD_CLASS_DEVICE is not set
-- 
2.21.0

