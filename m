Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BE4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D497220989
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553971813;
	bh=Rwdcf2uIzIIvp+IFigvPYZ8V/+YK4awSWbWHOBagNwI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TTR+mwmMQJOk0RCNIVHE+XW1fBWuikH+uSlTOjoWFACsyUX+rX8bLiOHty4ZAkSRE
	 dRI1cqt7BPrQmWoX/9GOnMaf+H8uKVD6hbCCBxybDHaVpBAk9jZn6BU0YMqaHfF9v5
	 xSwKjnAq8kWKo8DoXDdY1Lg5kCl5qhJrJcDvQ0Tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbfC3SuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730662AbfC3SuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:50:11 -0400
Subject: Re: [GIT PULL] TTY/Serial fixes for 5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553971810;
        bh=Rwdcf2uIzIIvp+IFigvPYZ8V/+YK4awSWbWHOBagNwI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fOYwL5f3Xb7cNPa1ZKg8RiQkJhx9bxqO6cQ4A7qKrl7BasbhSifoG+LygLGeyaZdz
         l/wowzr9jPKatbnnBuyZNv+iY0rxeOV68B4MBltx9o/YyGczH/GV6kMTwWCH3edDCZ
         EaHKUti+UPicBoHkeO/vKSQ2OHRx2iC50fDlxsOw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190330090400.GA5598@kroah.com>
References: <20190330090400.GA5598@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190330090400.GA5598@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.1-rc3
X-PR-Tracked-Commit-Id: f4e68d58cf2b20a581759bbc7228052534652673
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52afe190ff034f25546fb0a2cb7380dcb896d371
Message-Id: <155397181059.25047.6640723687032364938.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Mar 2019 18:50:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Mar 2019 10:04:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52afe190ff034f25546fb0a2cb7380dcb896d371

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
