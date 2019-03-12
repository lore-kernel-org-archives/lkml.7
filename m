Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DCBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA16205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413600;
	bh=+gHtMiYJj1uC2B/qWV4OUIjcsQQmbMY9o0J+upa4PX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M1dwmO6x3D9/+qbVKikbkbNWgTmzD+NeusnsMpBwRhJLNcvpkU+Cxy2ibLU3bSJc7
	 I0L78TzXCvnUXnaRtcri6y1kWbDDoVndLgr8WFZx4XevlM7hpImhwDkFvkgfmOP/d1
	 pAMmcC2j5Vg1H3kGltV7hOVkCDG6mcGOzOuTDY+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfCLRN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfCLRMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:53 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE1D6217D4;
        Tue, 12 Mar 2019 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410773;
        bh=+gHtMiYJj1uC2B/qWV4OUIjcsQQmbMY9o0J+upa4PX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b78Mk6wWF9dq4HNjBRUO3LoA4AQkyizG+Nqnq+cZr+XFls6lUgKYzdrKu1vDoOAhY
         VKJaG5LHe//naQ2JeBilHc//qRLOX10muVtQpqxwfFPbRsAcdCWRuS+wOHviIjsZUV
         X/CyM1bZUZQ+AdMggJX4xOzenmwUivozmgVJifa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 079/171] ARM: dts: imx6sx: correct backward compatible of gpt
Date:   Tue, 12 Mar 2019 10:07:39 -0700
Message-Id: <20190312170354.865359411@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 95a3c1cb877d..89ba48f4273b 100644
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



