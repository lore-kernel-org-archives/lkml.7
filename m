Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC9C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA1C20659
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfGaN3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:29:20 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:33478 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfGaN3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:29:19 -0400
Received: from ramsan ([84.194.98.4])
        by andre.telenet-ops.be with bizsmtp
        id jRVJ2000905gfCL01RVJnN; Wed, 31 Jul 2019 15:29:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hsofO-0001Ag-Dn; Wed, 31 Jul 2019 15:29:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hsofO-0004al-Az; Wed, 31 Jul 2019 15:29:18 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] pinctrl: Avoid hardcoded string offsets and buffer lengths
Date:   Wed, 31 Jul 2019 15:29:14 +0200
Message-Id: <20190731132917.17607-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

This patch series gets rid of hardcoded string offsets and buffer
lengths, in favor of using strlen() and (devm_)kasprintf().

Thanks!

Geert Uytterhoeven (3):
  pinctrl: devicetree: Use strlen() instead of hardcoded number
  pinctrl: lantiq: Use kasprintf() instead of fixed buffer formatting
  pinctrl: xway: Use devm_kasprintf() instead of fixed buffer formatting

 drivers/pinctrl/devicetree.c     | 6 ++----
 drivers/pinctrl/pinctrl-falcon.c | 6 +-----
 drivers/pinctrl/pinctrl-xway.c   | 4 +---
 3 files changed, 4 insertions(+), 12 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
