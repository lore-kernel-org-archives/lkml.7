Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0967C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B623624672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578348904;
	bh=TnEaDztOveaVafNetBAdDi2KyjKQIqroNQxDV4UbRoo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SST0t0HBdAflJ+ECOLri+tFwlfjgUlFjkUyPlWMB2RHQ/DnBGrvblOCTDFTRYRzhA
	 /nq1H5Fs/Yt1q5djL5mlnt2tGbFqcwppb+VK7dAFOdTmeVbWofQRBB5JdOls852trq
	 rPpMdJAejWm5bZOc7dcwNkwIAew3zGdBDEg58wIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgAFWPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgAFWPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:15:03 -0500
Subject: Re: [GIT PULL REQUEST] watchdog - v5.5 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578348903;
        bh=TnEaDztOveaVafNetBAdDi2KyjKQIqroNQxDV4UbRoo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jmctnd85I6wo4oIeuHr2illemr9+drW+Aczpn5gFOqoZrys2uFgGBrITACl4699Vg
         ziNXOha5U5hU7r2NvZfsS5Jjdt1KRiMnbMZabPHgBHPC2RO7hRgo6BVKLEvLBrazpz
         1OfRGYpAVZs9bOkWQPXaZg93+aNCJkmQVdPIm7WY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200106191234.GA1443@www.linux-watchdog.org>
References: <20200106191234.GA1443@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200106191234.GA1443@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git
 tags/linux-watchdog-5.5-fixes
X-PR-Tracked-Commit-Id: dcbce5fbcc69bf2553f650004aad44bf390eca73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: baf4dc829574ed9dd8ba33cda0536a50f28937de
Message-Id: <157834890321.24185.18184775319609247372.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Jan 2020 22:15:03 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        David Engraf <david.engraf@sysgo.com>,
        Fabio Estevam <festevam@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Srikanth Krishnakar <skrishnakar@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Jan 2020 20:12:34 +0100:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/baf4dc829574ed9dd8ba33cda0536a50f28937de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
