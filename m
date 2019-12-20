Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E563AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF12F20866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576865715;
	bh=5M55VJO36zLFmp/vOreFqjcFxvHIBFB1SnrqnT3pSZI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dGQIBWkW3MZMSBgOzTccLizn+Aa1L+beTikR58vPxwwdA8LN0++BjmNk7uaD/Fq4k
	 IVX5X+7H4OJETxjvbDalSt0L9eSR60Kl6Szk1EzNYRg54dCNO6XS8hY5cx6f8XlcbK
	 qRP2qVQl+g4xhVx+KVZcbOg/Vg4MOUcxqYisTxaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfLTSPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbfLTSPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:15:12 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576865711;
        bh=5M55VJO36zLFmp/vOreFqjcFxvHIBFB1SnrqnT3pSZI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Fey99Ybfg4AjKF+pP+/S7YnXfuzcZcOZgQXR7vk0qlhk7N3RDFgUg60gqpoPYSUiI
         WADgquVynBD0AJTnWbkC5BZ0scLWCI+8FfLhztYOHSs+9WyorSy63OXE2hrQpcA4Jl
         gnwGN+bJHB3ZhgSCkcLq/ZmAfvNK6JpKVie8kB+U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191220070843.GA2190439@kroah.com>
References: <20191220070843.GA2190439@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191220070843.GA2190439@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.5-rc3
X-PR-Tracked-Commit-Id: 4aa37c463764052c68c5c430af2a67b5d784c1e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6398b9fc818eea79dcd6e70f981ce782da22cdee
Message-Id: <157686571193.29164.5855982950871925840.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Dec 2019 18:15:11 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Dec 2019 08:08:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6398b9fc818eea79dcd6e70f981ce782da22cdee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
