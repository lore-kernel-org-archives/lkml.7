Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DDBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428D721848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566453923;
	bh=+7nxHi8rv149QAhfc4+oEo5xk2MSe8WAq+/diXH6oVA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WMAWiz3nA6GSX9t6YuBiys+nnIcNe5ZU7QsqtGR4G9DPUWoD5sPoxyO60NPtiKwrU
	 VXTQOUUTqUi6pm2ZLaRBZJNQfaKKRyff1rbnjTXgz62wZLtzwuXQHJmYRsaf2Tauyn
	 b1qaQkQfBokpWBoj9LEe8GBp0T/hFpf+uArXYbko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbfHVGFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbfHVGFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:05:22 -0400
Received: from localhost.localdomain (unknown [171.61.89.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD502214DA;
        Thu, 22 Aug 2019 06:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566453921;
        bh=+7nxHi8rv149QAhfc4+oEo5xk2MSe8WAq+/diXH6oVA=;
        h=From:To:Cc:Subject:Date:From;
        b=wTdSPrch+yuem99mnZj5Oqxh7nigC9f3WeadOFXpbaR1bpkujVjRilAIWTY3K+cpM
         NVvmAvIQZb5BRKNxogQYhwzZNq4orTRwZpi0ILTL032u8BRCVx/etodAsno5JKrYpO
         n0YM+jRdEMcBRj8koZ003uAztF6k1uTTiZn0CfBE=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable SM8150 GCC and pinctrl driver
Date:   Thu, 22 Aug 2019 11:33:47 +0530
Message-Id: <20190822060347.15549-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable GCC config CONFIG_SM_GCC_8150 and pinctrl config
CONFIG_PINCTRL_SM8150 to make it possible to boot the SM8150 MTP.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0e58ef02880c..09be33cb4d76 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -403,6 +403,7 @@ CONFIG_PINCTRL_QCS404=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_SDM845=y
+CONFIG_PINCTRL_SM8150=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_MB86S7X=y
 CONFIG_GPIO_PL061=y
@@ -690,6 +691,7 @@ CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SDM_GCC_845=y
+CONFIG_SM_GCC_8150=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
-- 
2.20.1

