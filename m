Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C053C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C12206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552330809;
	bh=FxEzo3L/cr9SFGVdHC3MfpToWMy9Qg9qlhT7dvH/64M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=atGP8fJW33F3+3j9rCxMsDpdouGeFrLsWHBIfftqnFWXNtSHnui6+M8UUeZRscE8H
	 CtowW6ADHiPFgVwDEnh3VWtc5A7hiLpHkliwCCYF6Nh1roKvRGUREt+gkEEOLqDRTE
	 U7O3uaEdu8IQJIH3SX7q3vIOS0sMOARLBuOq0azU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfCKTAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbfCKTAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:00:03 -0400
Subject: Re: [GIT PULL REQUEST] watchdog - v5.1 Merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552330803;
        bh=FxEzo3L/cr9SFGVdHC3MfpToWMy9Qg9qlhT7dvH/64M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XyAR/HnDDbyN+3aGcAcYojRULc0UyCp2kFaN3ZHRrMP3TeiAIeNqMQT9yHMts4c2p
         vXOUeZLzhaj6Tx9EMMd9cNpYb5Pv8yk03M9ZD3i7aAxA/DCu/ZvWDaRgktanNxHTrd
         dGlsC2jq2Bblh3wPJrMVYWSLR45/hccgLHq5F25U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190310145408.GA2045@www.linux-watchdog.org>
References: <20190310145408.GA2045@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190310145408.GA2045@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git
 tags/linux-watchdog-5.1-rc1
X-PR-Tracked-Commit-Id: 458c8961c194f2d2cb6ffed3dd9b6692d74ad65e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a089e4fed5c5e8717f233d71bb750fbf9e1f38e0
Message-Id: <155233080326.15239.2288884379574979832.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Mar 2019 19:00:03 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Mar 2019 15:54:08 +0100:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a089e4fed5c5e8717f233d71bb750fbf9e1f38e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
