Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0CCC282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 12:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083EA2087F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 12:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDFMG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 08:06:56 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48523 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfDFMG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 08:06:56 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E413F1BF207;
        Sat,  6 Apr 2019 12:06:53 +0000 (UTC)
Date:   Sat, 6 Apr 2019 14:06:53 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC fixes for 5.1
Message-ID: <20190406120653.GA10170@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here are a few fixes for 5.1, please pull.

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.1-2

for you to fetch changes up to 882c5e552ffd06856de42261460f46e18319d259:

  rtc: da9063: set uie_unsupported when relevant (2019-04-02 23:33:09 +0200)

----------------------------------------------------------------
RTC fixes for 5.1

 - Various alarm fixes for da9063, cros-ec and sh
 - sd3078 manufacturer name fix as this was introduced this cycle

----------------------------------------------------------------
Alexandre Belloni (2):
      rtc: sd3078: fix manufacturer name
      rtc: da9063: set uie_unsupported when relevant

Geert Uytterhoeven (1):
      rtc: sh: Fix invalid alarm warning for non-enabled alarm

Stephen Boyd (1):
      rtc: cros-ec: Fail suspend/resume if wake IRQ can't be configured

 drivers/rtc/Kconfig       | 4 ++--
 drivers/rtc/rtc-cros-ec.c | 4 ++--
 drivers/rtc/rtc-da9063.c  | 7 +++++++
 drivers/rtc/rtc-sh.c      | 2 +-
 4 files changed, 12 insertions(+), 5 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
