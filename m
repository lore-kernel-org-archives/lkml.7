Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D84CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025C42173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566754816;
	bh=8UNv4QpS2JY0grXyTtNR37SyL3WT24MnrfphSeheTD4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EciDBlynfKMWE0HF7FcSWeLzhvhG9x3LPw3S8UlIgnEFK6u2gwzCMZ69ofdGfOU0A
	 qcC7WbAc2TgWlFfwhzxTgHtpmzjuprfkWfPA8okPXZ3ux2Yh2abEXaFd3yUEzzHY/b
	 D2TpSK2wTjtAl8/RyTGa1bjDLmwQuEJhp8RHwoow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfHYRkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 13:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbfHYRkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 13:40:07 -0400
Subject: Re: [GIT pull] sched/urgent for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566754806;
        bh=8UNv4QpS2JY0grXyTtNR37SyL3WT24MnrfphSeheTD4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1UgWQE/eJ/7V+zBWIrKEze2Mb9Vj0kENUXjicFZsN4dMFDDSIi6c30iEYBLzjks70
         rTVIOsGDnVO0zr1onRHAEliOAlPhSPPB8ygGpMHAEfwmJyDvb6wM5YelGtRirHU73h
         qoHynVPId1aEK/8ah9q3glhQWQsCcLb4qsVkvx2g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156672618029.19810.6692216639070045415.tglx@nanos.tec.linutronix.de>
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
 <156672618029.19810.6692216639070045415.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156672618029.19810.6692216639070045415.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: b0fdc01354f45d43f082025636ef808968a27b36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a04c2ee62a4020cf1b7818c300626819d62ff5e
Message-Id: <156675480656.29384.14317573650573493026.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Aug 2019 17:40:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Aug 2019 09:43:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a04c2ee62a4020cf1b7818c300626819d62ff5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
