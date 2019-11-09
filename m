Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23E0C17440
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 10:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93451207FF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 10:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="ksE1U0tZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfKIKrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 05:47:08 -0500
Received: from www.linux-watchdog.org ([185.87.125.42]:42220 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfKIKrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 05:47:08 -0500
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Nov 2019 05:47:07 EST
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id B130140204; Sat,  9 Nov 2019 10:54:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org B130140204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1573293283;
        bh=JzQx7YpNmpxma75B7LPm6zaJOGPNcTDGsH5LTJkoSnA=;
        h=Date:From:To:Cc:Subject:From;
        b=ksE1U0tZBYAX8bJb5Rq3vBibSUYcDahJ22nhZPcAoJnJaQwPZdyug7mibTFrLpU1h
         1uFA7kGR4+satPBRQFCJivIiTjXPei+zI1GeDHlxmV2pvbYmGgnwfNiZ7eiGC2tKmn
         dRJ8DpY/RA9EqXTyntUeR0rG3xEl6duzKXIdoxMg=
Date:   Sat, 9 Nov 2019 10:54:43 +0100
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [GIT PULL REQUEST] watchdog - v5.4-rc7 Fixes
Message-ID: <20191109095443.GA21465@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the watchdog fixes for v5.4-rc7.

This series contains:
* cpwd: fix build regression
* pm8916_wdt: fix pretimeout registration flow
* meson: Fix the wrong value of left time
* imx_sc_wdt: Pretimeout should follow SCU firmware format
* bd70528: Add MODULE_ALIAS to allow module auto loading

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit a99d8080aaf358d5d23581244e5da23b35e340b9:

  Linux 5.4-rc6 (2019-11-03 14:07:26 -0800)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.4-rc7

for you to fetch changes up to 81363f248aecd2b5f10547af268a4dfaf8963489:

  watchdog: bd70528: Add MODULE_ALIAS to allow module auto loading (2019-11-05 16:58:12 +0100)

----------------------------------------------------------------
linux-watchdog 5.4-rc7 tag

----------------------------------------------------------------
Anson Huang (1):
      watchdog: imx_sc_wdt: Pretimeout should follow SCU firmware format

Arnd Bergmann (1):
      watchdog: cpwd: fix build regression

Jorge Ramirez-Ortiz (1):
      watchdog: pm8916_wdt: fix pretimeout registration flow

Matti Vaittinen (1):
      watchdog: bd70528: Add MODULE_ALIAS to allow module auto loading

Xingyu Chen (1):
      watchdog: meson: Fix the wrong value of left time

 drivers/watchdog/bd70528_wdt.c    |  1 +
 drivers/watchdog/cpwd.c           |  8 +++++++-
 drivers/watchdog/imx_sc_wdt.c     |  8 +++++++-
 drivers/watchdog/meson_gxbb_wdt.c |  4 ++--
 drivers/watchdog/pm8916_wdt.c     | 15 +++++++++++----
 5 files changed, 28 insertions(+), 8 deletions(-)
----------------------------------------------------------------

Kind regards,
Wim.

