Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4660C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3F1215F1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575255005;
	bh=xbxP+MB1vaSgge7p8ievzKVRbsYcN5ZFMx/5YLHkiE4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lYliLxH00E/x8bo4WqaJiV1XmG3MXjmUON1oBQ5UQGuWebzYsb5HdZIvDaPi4398W
	 AfgGd94MmeeOxOLO7lbarNrUo64qAREB3EV//hoGWVZN4k1lpA2qh9e25eRjdzkHcL
	 rc6xo96h9kKH14WNnA8E6bS1VymHR9dsAhliPwEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfLBCuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 21:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbfLBCuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:50:03 -0500
Subject: Re: [GIT PULL REQUEST] watchdog - v5.5 Merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575255003;
        bh=xbxP+MB1vaSgge7p8ievzKVRbsYcN5ZFMx/5YLHkiE4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Fu3dKgk6GuZBXO69WTjmQwebBSMk4/vDAgQ9Qgg9jLJXK2ZcyAjYOQroitmMUZys3
         dM0sYZJtjl6yilQ+tM+InEXmeC9VIqXVRnR4ZWdfsN8JhiOiaHgmUnv2EpFEOmZsZs
         t+fH5nRm5TF7etBi0LXtgT/lDNPM3/CY5Rno1YYM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191129160045.GA1996@www.linux-watchdog.org>
References: <20191129160045.GA1996@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191129160045.GA1996@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git
 tags/linux-watchdog-5.5-rc1
X-PR-Tracked-Commit-Id: 33c26ab4d6beec44bd5f525ffba1c23bf962d4a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a08fe5792583d81bf237a75ebc803f756204e46
Message-Id: <157525500351.1709.3428496160790013790.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 02:50:03 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Borislav Petkov <bp@suse.de>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Joel Stanley <joel@jms.id.au>, Julia Cartwright <julia@ni.com>,
        Kevin Hao <haokexin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shuiqing Li <shuiqing.li@unisoc.com>,
        Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Nov 2019 17:00:45 +0100:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a08fe5792583d81bf237a75ebc803f756204e46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
