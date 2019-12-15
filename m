Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C704C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 00:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F87D214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 00:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576368913;
	bh=2AVr/3T/8zCyT1jUqHdrzREhHmMssaywUFhCSP591m0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Eo9Fxm7ctZjGxJc+2Oc+Z+O7Y9oOfB2pAJu9TsLstSXBMt71W/1qLhVy0yXfyGVlf
	 1YI6yHYdemC8xTopNL402gnSZLMHEVHCX5G6yaSO+c7PYVzb1CzIE7H2ldTMgb/5Jy
	 5DwjjEt0w5mfMyqy3XzVtltXfX0TDT/a1Mz5Bglo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfLOAPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 19:15:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfLOAPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 19:15:12 -0500
Subject: Re: [GIT PULL] Wimplicit-fallthrough patches for 5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576368911;
        bh=2AVr/3T/8zCyT1jUqHdrzREhHmMssaywUFhCSP591m0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ecHOMWuoVVESX8lpwCkNbfj+9eQ9FODmAgHHYG1hY+Adacc8gJPqtKmalbo3yYLBt
         yzSGgKyxodgvF/gvH3vWTGYqYmpxWwNnns2PfN/AHbNn8fwNJyw3zigOGgyn7rc68P
         UOgICh6Bxoc9WpuA/1vBU8NJc0lJ8icoO5uRoNBw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191214200709.GA20124@embeddedor>
References: <20191214200709.GA20124@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191214200709.GA20124@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
 tags/Wimplicit-fallthrough-5.5-rc2
X-PR-Tracked-Commit-Id: 3d519d6d388ba4f9a75d0e0b6f60d890987bc096
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 510c9788991c58827373bca719d8cffa4d65f846
Message-Id: <157636891171.21229.8559220059254711187.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Dec 2019 00:15:11 +0000
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Dec 2019 14:07:09 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/510c9788991c58827373bca719d8cffa4d65f846

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
