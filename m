Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6082FC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2477B218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366680;
	bh=34dAHLmsVT7El8v0rSwtE6rlcyWfPIp/xWRZCbafj30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CDqsqqYww/N1rlkjZ0joruN4GgETDFnL/iHMZZJGf3l2b5XL5LR5xS9sC4YYzMoom
	 YzTPIF8FapuRMmo6ErtAvaD51Rkh+OSW1ihHdAQA2NfZiEvFBVwJV+DHSfmms3e8E6
	 CmKZTh6yPH1ifzw9K7Ocu68yLqQ1HOcnPScWBOmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbfB1PLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:11:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732403AbfB1PLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EC05218E0;
        Thu, 28 Feb 2019 15:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366674;
        bh=34dAHLmsVT7El8v0rSwtE6rlcyWfPIp/xWRZCbafj30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6zlDfBxrlW8B9jQANitYwGDBfUQLYm2T7QBUVK601pV+TuQM7VHLt6Frks+p911I
         BglI/RzM8ST/FqK12US6RH5ieP+c9tmhv9LhVju0GMKc3rsBKCmT4eVJquEjwWXfIH
         RDoOMJ8iDKAe26vHlpI1NI67J87imXvvjy/8CjlA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anson Huang <anson.huang@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 07/64] ARM: dts: imx6sx: correct backward compatible of gpt
Date:   Thu, 28 Feb 2019 10:10:08 -0500
Message-Id: <20190228151105.11277-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
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
index 844caa39364ff..50083cecc6c97 100644
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

