Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA5FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1AF20748
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbfKTO7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:59:31 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:50570 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731086AbfKTO7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:59:31 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id UEzU2100S5USYZQ01EzU6D; Wed, 20 Nov 2019 15:59:28 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iXRS4-0002Ii-JA; Wed, 20 Nov 2019 15:59:28 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iXRS4-0002EE-Gd; Wed, 20 Nov 2019 15:59:28 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/2] reset: Miscellaneous improvements
Date:   Wed, 20 Nov 2019 15:59:25 +0100
Message-Id: <20191120145927.8523-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Philipp,

This patch series contains a resource optimization for the managed
helpers, and an enhancement to make the reset controller code more
uniform.

Changes compared to v1:
  - Use IS_ERR_OR_NULL(),
  - Drop accepted patch.

Thanks!

Geert Uytterhoeven (2):
  reset: Do not register resource data for missing resets
  reset: Align logic and flow in managed helpers

 drivers/reset/core.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
