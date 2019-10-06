Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAF3C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6937720700
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384849;
	bh=zL1w5syTRE29MPGD3HK6k4a/25ozxavpM0xkeCziFPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QvKvXwtReHPqay5HOOcFKO8l2sjsBqLXYaYtfr0ECI1CtZPIuVTXBNbPgwYSi8HLn
	 VBC8zQeWXVsLInsQtmDVMWXiA4+5V706q+C8O6VAZm030rSouym9YDtMDznjxEAtvr
	 eKeP5XZFS6sVCPcHg9Yr3RclpEJBkMALsZFoMQZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfJFR20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbfJFR2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:28:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C5652087E;
        Sun,  6 Oct 2019 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382902;
        bh=zL1w5syTRE29MPGD3HK6k4a/25ozxavpM0xkeCziFPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+89mkUe6PrCFU8tJ0KVfIJG+xUvtX09gKHCfjeSY1U5BZMOsb9PWJOhItisqKqvP
         ID7x0eyNdT1hk6Ez9r5y9Bj9pfKNII2csqUDDRuVkKTN+f77lf7GSuOq4EsTnMW4H7
         0SE8qgFk97wUvs73gAu3JE/Gq1eh+WmRztj+bbkM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 014/106] clk: sunxi-ng: v3s: add missing clock slices for MMC2 module clocks
Date:   Sun,  6 Oct 2019 19:20:20 +0200
Message-Id: <20191006171131.298859425@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171124.641144086@linuxfoundation.org>
References: <20191006171124.641144086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

[ Upstream commit 720099603d1f62e37b789366d7e89824b009ca28 ]

The MMC2 clock slices are currently not defined in V3s CCU driver, which
makes MMC2 not working.

Fix this issue.

Fixes: d0f11d14b0bc ("clk: sunxi-ng: add support for V3s CCU")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index ac12f261f8caa..9e3f4088724b4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -499,6 +499,9 @@ static struct clk_hw_onecell_data sun8i_v3s_hw_clks = {
 		[CLK_MMC1]		= &mmc1_clk.common.hw,
 		[CLK_MMC1_SAMPLE]	= &mmc1_sample_clk.common.hw,
 		[CLK_MMC1_OUTPUT]	= &mmc1_output_clk.common.hw,
+		[CLK_MMC2]		= &mmc2_clk.common.hw,
+		[CLK_MMC2_SAMPLE]	= &mmc2_sample_clk.common.hw,
+		[CLK_MMC2_OUTPUT]	= &mmc2_output_clk.common.hw,
 		[CLK_CE]		= &ce_clk.common.hw,
 		[CLK_SPI0]		= &spi0_clk.common.hw,
 		[CLK_USB_PHY0]		= &usb_phy0_clk.common.hw,
-- 
2.20.1



