Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34578C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 15:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011F920657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 15:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="SjKtGKFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfCJPcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 11:32:32 -0400
Received: from www.linux-watchdog.org ([185.87.125.42]:56066 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfCJPcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 11:32:32 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Mar 2019 11:32:30 EDT
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 68B2640424; Sun, 10 Mar 2019 15:54:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 68B2640424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1552229648;
        bh=x8Zah5xbEeG82jGssXoXXy7ux3/6mB3o6o/eCr+nufw=;
        h=Date:From:To:Cc:Subject:From;
        b=SjKtGKFMJTDexzw4No5r7Djz+fDLnHv/ixbaP0B9q7JwA6tNaRnvY3xoVIKeo1Zrq
         kYoPWdN6GhZlyBJaYzG7tiF8MzvJbq3lxI6MAXIFGzqVWuwhZawdQ4w5z6UJ3P7vhP
         AULha2YI5cB2nMabcBuzYUL+eYR9xrLX4vwrsMos=
Date:   Sun, 10 Mar 2019 15:54:08 +0100
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Biju Das <biju.das@bp.renesas.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [GIT PULL REQUEST] watchdog - v5.1 Merge window
Message-ID: <20190310145408.GA2045@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the watchdog changes for the v4.21 release cycle.

This series contains:
* A new watchdog driver for the Mellanox systems
* renesas-wdt: Document r8a77470 support
* numerous Mark expected switch fall-throughs
* qcom: Add suspend/resume support
* some small fixes and documentation updates

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.1-rc1

for you to fetch changes up to 458c8961c194f2d2cb6ffed3dd9b6692d74ad65e:

  watchdog: w83877f_wdt: Mark expected switch fall-through (2019-03-02 15:28:22 +0100)

----------------------------------------------------------------
linux-watchdog 5.1-rc1 tag

----------------------------------------------------------------
Biju Das (1):
      dt-bindings: watchdog: renesas-wdt: Document r8a77470 support

Gustavo A. R. Silva (6):
      watchdog: pc87413: Mark expected switch fall-through
      watchdog: sc1200: Mark expected switch fall-through
      watchdog: smsc37b787_wdt: Mark expected switch fall-through
      watchdog: sbc60xxwdt: Mark expected switch fall-through
      watchdog: sc520_wdt: Mark expected switch fall-through
      watchdog: w83877f_wdt: Mark expected switch fall-through

Jerry Hoemann (2):
      watchdog/hpwdt: Update Kconfig documentation
      watchdog: Update sysfs documentation.

Jisheng Zhang (1):
      watchdog: dw: remove useless pr_fmt

Michael Shych (3):
      platform_data/mlxreg: additions for Mellanox watchdog driver.
      watchdog: mlx-wdt: introduce a watchdog driver for Mellanox systems.
      Documentation/watchdog: Add documentation mlx-wdt driver

Sai Prakash Ranjan (1):
      watchdog: qcom: Add suspend/resume support

YueHaibing (1):
      watchdog: pika_wdt: drop pointless static qualifier in pikawdt_init

 Documentation/ABI/testing/sysfs-class-watchdog     |  23 ++
 .../devicetree/bindings/watchdog/renesas-wdt.txt   |   1 +
 Documentation/watchdog/mlx-wdt.txt                 |  52 ++++
 drivers/watchdog/Kconfig                           |  25 +-
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/dw_wdt.c                          |   2 -
 drivers/watchdog/mlx_wdt.c                         | 290 +++++++++++++++++++++
 drivers/watchdog/pc87413_wdt.c                     |   2 +-
 drivers/watchdog/pika_wdt.c                        |   2 +-
 drivers/watchdog/qcom-wdt.c                        |  23 ++
 drivers/watchdog/sbc60xxwdt.c                      |   2 +-
 drivers/watchdog/sc1200wdt.c                       |   2 +-
 drivers/watchdog/sc520_wdt.c                       |   2 +-
 drivers/watchdog/smsc37b787_wdt.c                  |   2 +-
 drivers/watchdog/w83877f_wdt.c                     |   2 +-
 include/linux/platform_data/mlxreg.h               |  19 ++
 16 files changed, 437 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/watchdog/mlx-wdt.txt
 create mode 100644 drivers/watchdog/mlx_wdt.c
----------------------------------------------------------------

Kind regards,
Wim.

