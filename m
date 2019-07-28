Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F4FC7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 05:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87754216F4
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 05:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564290020;
	bh=W+VgFx52J/3xOt6L+KkqS8F/Pxfs5xbCmD7zpZrXp88=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TDdcioTi+goJD8LIbVQOYKSLfxoQL8pKA6nQuON0WgCgrqASNJhfJdiFWph8OFIqi
	 YWD0aswnonEIMQdGCf+pYD6jnfoJrxtfJ4+/0Sg4m5G436nQzG1oVVgk2Y9hdk6imU
	 LUGxln8gf8gZRXCJ1rvgatCNUlTI8ifEdG7hMv88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfG1FAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 01:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfG1FAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 01:00:18 -0400
Subject: Re: [GIT pull] core/urgent for 5.3-rc2 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564290017;
        bh=W+VgFx52J/3xOt6L+KkqS8F/Pxfs5xbCmD7zpZrXp88=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UDgBj6FbQzezNJCZQKMnjeYGMs+4Qn9vgG2zF/aRjHOs+gVsztPdM6hUUsL//El1V
         L7tjPEI+ON9q8A6d2l6FVesUugmhxZIw4t6bSLsG6fiWK+nzC7G57Yl42K0joEt2xA
         bQ/JWrfJTONsGg7aJtQXg054pcI0fGWsR7qbbN9s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156426997427.6953.14728916479410000420.tglx@nanos.tec.linutronix.de>
References: <156426997427.6953.14728916479410000420.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156426997427.6953.14728916479410000420.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: 882a0db9d143e5e8dac54b96e83135bccd1f68d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13fbe991b5b1bbb52ede39be11d5c196721349bf
Message-Id: <156429001772.32180.13434146020692468546.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jul 2019 05:00:17 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jul 2019 23:26:14 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13fbe991b5b1bbb52ede39be11d5c196721349bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
