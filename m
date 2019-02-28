Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BFAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864FD206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551368066;
	bh=DUnOeCFvpzCOS6PjhCHMNZtzPbgQJJyWkFYb5HLC++Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jyTJXCFBvD13R7ZZYQnj0a1c5LhclftB0YcAylEo8LzsjRflGDSmr4VSx6WJaPBIq
	 PBGJCb85PzrXzHyfRgLez91eOIofq11uNdTTaNb69rM0IAntdywKkChk3R14zDBVjf
	 NM9iryoom7LMJXUPD+y4JJFPFSyVXVPnNQPQ7j9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbfB1PeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:34:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732800AbfB1PI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20083218C3;
        Thu, 28 Feb 2019 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366506;
        bh=DUnOeCFvpzCOS6PjhCHMNZtzPbgQJJyWkFYb5HLC++Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6AUPb1pdkv5enFFgoFmAOMVuaITjOAYubb5trs6Goh8Hp9yGW5Xvt1IdvHrXV/zi
         zZmI5QhD4wbpF3U2cy/GhZugr4quQ1obr7mTVWpa0M99pf3Wx0+v5ZwTfbU205sXT7
         f37wmUkZLxbIGWr581UECfbe/aLprdSamiESwHxA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anson Huang <anson.huang@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 09/81] ARM: dts: imx6sx: correct backward compatible of gpt
Date:   Thu, 28 Feb 2019 10:07:01 -0500
Message-Id: <20190228150813.10256-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

[ Upstream commit ba0f4560526ba19300c07ed5a3c1df7592815dc6 ]

i.MX6SX has same GPT type as i.MX6DL, in GPT driver, it uses
below TIMER_OF_DECLARE, so the backward compatible should be
"fsl,imx6dl-gpt", correct it.

TIMER_OF_DECLARE(imx6sx_timer, "fsl,imx6sx-gpt", imx6dl_timer_init_dt);

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 95a3c1cb877db..89ba48f4273b2 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -462,7 +462,7 @@
 			};
 
 			gpt: gpt@2098000 {
-				compatible = "fsl,imx6sx-gpt", "fsl,imx31-gpt";
+				compatible = "fsl,imx6sx-gpt", "fsl,imx6dl-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_GPT_BUS>,
-- 
2.19.1

