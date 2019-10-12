Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD841C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B98206CD
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570920912;
	bh=u+doTc6OM9epBZQrCdytDLxl3Jg9h1sfIdZh8kaQBH0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=G0OkgVGO4lqCKG+sokPm7qsFaWGfL2X3cb3MwEKlsexgt9hVDemaJbsYT8JpyHIQ6
	 lc5eFxX5Xq314IzC4qBKsaUaz2ZTYjPxXy1CY2COpE0B5inq4XL8s+k63114qn6mKz
	 iXZ9EWJm25KaOpP2ta4OTEXr3IFwW7nu01W3SUFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfJLWzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbfJLWzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:55:07 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570920907;
        bh=u+doTc6OM9epBZQrCdytDLxl3Jg9h1sfIdZh8kaQBH0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VI6Nc6OxtesV1h/tjZsJUbFyLVum2O/7zAq6AbF8jo2L3rvrEyq4fi2tV/KhWNopu
         V0m69MD6p1E4l4SBuPFBIaHDIOZP2DTGNuEjdfIMVOfME6uAF1cp3yLC/++jATxWwY
         K50cYxLBG/HkcFU/0eJF1cc1HJOFVxT79LiIjqJ8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191012161659.GA2191759@kroah.com>
References: <20191012161659.GA2191759@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191012161659.GA2191759@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.4-rc3
X-PR-Tracked-Commit-Id: 442f1e746e8187b9deb1590176f6b0ff19686b11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da94001239cceb93c132a31928d6ddc4214862d5
Message-Id: <157092090706.32460.15767091072232282005.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 22:55:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 18:16:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da94001239cceb93c132a31928d6ddc4214862d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
