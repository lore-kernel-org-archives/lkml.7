Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDF0FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D802168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393081AbfJPOrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:47:52 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:56550 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbfJPOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:47:52 -0400
Received: from ramsan ([84.194.98.4])
        by baptiste.telenet-ops.be with bizsmtp
        id EEnq2100B05gfCL01Enqly; Wed, 16 Oct 2019 16:47:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iKkac-0003rN-B8; Wed, 16 Oct 2019 16:47:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iKkac-0007hD-8Q; Wed, 16 Oct 2019 16:47:50 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 0/4] clocksource/drivers/timer-of/renesas-ostm improvements
Date:   Wed, 16 Oct 2019 16:47:43 +0200
Message-Id: <20191016144747.29538-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Daniel, Thomas,

This patch series converts the Renesas OSTM driver to the timer-of
framework, and makes device names unique.

Changes compared to v3 ("[PATCH v3 0/3] clocksource/drivers/ostm:
Miscellaneous improvements",
https://lore.kernel.org/lkml/20190807084635.24173-1-geert+renesas@glider.be/):
  - Dropped applied [PATCH 1/3],
  - Dropped obsolete [PATCH 2/3],
  - Convert to timer_of as requested by Daniel,
  - Add new timer-of improvements.

Thanks!

Geert Uytterhoeven (4):
  clocksource/drivers/timer-of: Convert last full_name to %pOF
  clocksource/drivers/timer-of: Use unique device name instead of timer
  clocksource/drivers/renesas-ostm: Convert to timer_of
  clocksource/drivers/renesas-ostm: Use unique device name instead of
    ostm

 drivers/clocksource/Kconfig        |   1 +
 drivers/clocksource/renesas-ostm.c | 189 +++++++++++------------------
 drivers/clocksource/timer-of.c     |   6 +-
 3 files changed, 76 insertions(+), 120 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
