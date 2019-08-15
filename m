Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85A0C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5402171F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="EWhD6+a7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfHOAtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:49:41 -0400
Received: from onstation.org ([52.200.56.107]:44380 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbfHOAtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:49:16 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 718363EA1E;
        Thu, 15 Aug 2019 00:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1565830156;
        bh=RQi7NgzWoBfqg8AYplLP5izcyVgpI38ozyAN9bUXL0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EWhD6+a7wngQEzTa1GokP9KHGWvgK5XoZo2l4cdMlZVpQDtOEpWl3pik4MKSVH/9W
         QX8TFjUKALlS3Q+3aEv2im8IE1HpEngE04TtzouMNESZmwd34RuXUoKDy8ululGHJ3
         h9MqhZZoYUJIY8DJDykIjtu7akNaFybaiMmq82fc=
From:   Brian Masney <masneyb@onstation.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, agross@kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com, robdclark@gmail.com,
        sean@poorly.run
Cc:     airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, linus.walleij@linaro.org,
        enric.balletbo@collabora.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 07/11] ARM: qcom_defconfig: add CONFIG_DRM_ANALOGIX_ANX78XX
Date:   Wed, 14 Aug 2019 20:48:50 -0400
Message-Id: <20190815004854.19860-8-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815004854.19860-1-masneyb@onstation.org>
References: <20190815004854.19860-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CONFIG_DRM_ANALOGIX_ANX78XX as a module so that the external display
can be used on the Nexus 5 phones.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 34433bf5885d..139e6610f034 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -148,6 +148,7 @@ CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_DRM=y
 CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_ANALOGIX_ANX78XX=m
 CONFIG_FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 # CONFIG_LCD_CLASS_DEVICE is not set
-- 
2.21.0

