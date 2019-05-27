Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBD2C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABB22146F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfE0MET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:04:19 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:54326 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfE0MEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:04:16 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id HQ4D2000M3XaVaC01Q4DqQ; Mon, 27 May 2019 14:04:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEMP-0001PW-Fq; Mon, 27 May 2019 14:04:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEMP-00015U-DQ; Mon, 27 May 2019 14:04:13 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/5] irqchip/renesas-irqc: Miscellaneous cleanups and improvements
Date:   Mon, 27 May 2019 14:04:07 +0200
Message-Id: <20190527120412.4071-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Thomas, Jason, Marc,

This is a set of miscellaneous cleanups and improvements for the Renesas
R-Mobile APE6 and R-Car interrupt controller for external interrupts
(IRQC/INTC-EX) driver.

Changes compared to v1:
  - Add Reviewed-by,
  - s/devm_kzalloc/kzalloc/ in patch description, reword.

Thanks!

Geert Uytterhoeven (5):
  irqchip/renesas-irqc: Remove unneeded inclusion of <linux/spinlock.h>
  irqchip/renesas-irqc: Remove error messages on out-of-memory
    conditions
  irqchip/renesas-irqc: Add helper variable dev = &pdev->dev
  irqchip/renesas-irqc: Replace irqc_priv.pdev by irqc_priv.dev
  irqchip/renesas-irqc: Convert to managed initializations

 drivers/irqchip/irq-renesas-irqc.c | 88 ++++++++++--------------------
 1 file changed, 30 insertions(+), 58 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
