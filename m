Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A030C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC0A21743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565368504;
	bh=fcr/iQNAZKpTtkt/hTq+CZ7aYyrm6waFfTWt9mt4fJI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ncq6+BRiZ8D56DPTKZAU5cX/GT4c9YFdY6jJm7CxupbCVIVPDmc69fecEsb7/NK8W
	 bRKf3ySFmO0T1L+OxzkQzanaUJksWgvQ6WgbXA7qksMZRe5ih+M+4/nG0n+Y0wIODx
	 Uj8JlSq7vV9Doqf5CFexjPETmTIqd203CMQoXHgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437302AbfHIQfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbfHIQfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:35:02 -0400
Subject: Re: [GIT PULL for v5.3-rc4] media fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565368501;
        bh=fcr/iQNAZKpTtkt/hTq+CZ7aYyrm6waFfTWt9mt4fJI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nZmzLNVXlkEA3HYQUiOjX1OjheCZyPjxu7roe2OLPD6KqrbYg20lMeOewYIvBT58E
         CN+avF9V7YJ/emDfWJIdGuqOW6rI13MXWmWwn0pKI5Jh8jItATlcCOj2D2HGCQjNac
         MssjpIzfSM0yVdmvyEWpjyEdaUzwNfPfxZ1wZNsw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190808123943.1551193d@coco.lan>
References: <20190808123943.1551193d@coco.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190808123943.1551193d@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
 media/v5.3-2
X-PR-Tracked-Commit-Id: 92f5b0313e37e2b37aaf8f0bb75b6c50eafb5808
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c02b6300fec062405ed0215e8ed1ed2b690da55
Message-Id: <156536850166.6429.12711568322533011086.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 16:35:01 +0000
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 8 Aug 2019 12:39:43 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media media/v5.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c02b6300fec062405ed0215e8ed1ed2b690da55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
