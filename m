Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33238C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9A0222FC
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfHGIqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:46:43 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:55918 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfHGIqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:46:42 -0400
Received: from ramsan ([84.194.98.4])
        by michel.telenet-ops.be with bizsmtp
        id m8md2000r05gfCL068meTU; Wed, 07 Aug 2019 10:46:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hvHaf-0002dn-SU; Wed, 07 Aug 2019 10:46:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hvHaf-0006If-QX; Wed, 07 Aug 2019 10:46:37 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 0/3] clocksource/drivers/ostm: Miscellaneous improvements
Date:   Wed,  7 Aug 2019 10:46:32 +0200
Message-Id: <20190807084635.24173-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series contains various improvements for the Renesas OSTM
timer driver, as used on the RZ/A1 and RZ/A2 SoCs.

The last patch is v3 of a patch that was sent before to a limited
audience:
  - https://lore.kernel.org/linux-renesas-soc/1507727130-17641-1-git-send-email-jacopo+renesas@jmondi.org/
  - https://lore.kernel.org/linux-renesas-soc/1507725113-18070-1-git-send-email-geert+renesas@glider.be/

Thanks!

Geert Uytterhoeven (3):
  clocksource/drivers/renesas-ostm: Use DIV_ROUND_CLOSEST() helper
  clocksource/drivers/renesas-ostm: Fix probe error path
  clocksource/drivers/ostm: Use unique device name instead of ostm

 drivers/clocksource/renesas-ostm.c | 95 ++++++++++++++++++------------
 1 file changed, 57 insertions(+), 38 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
