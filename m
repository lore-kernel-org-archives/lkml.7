Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE3CC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD3C2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568751327;
	bh=0tE34KKBPtKP3kiSobi70lyt9t4S653ALxgWdKscfh0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fSuvnU5nVDhPf/kpETLW0bezlvb7SOCqj+a1spRwwaTOCC4fCr1pU9fp1OUtdtjFW
	 6GYYMzebvZ0mwNjEVS2b3bCk58WhHCxyPEuY1GC7GPa83HqmEKpCjErlIX+JQ0t0nM
	 uen04L7F4buZlFuIpOKeLJC7fdDad8cK0UIgQLz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfIQUP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbfIQUPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:15:22 -0400
Subject: Re: [GIT pull] x86/apic for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568751322;
        bh=0tE34KKBPtKP3kiSobi70lyt9t4S653ALxgWdKscfh0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=daDadkt1AxQI8dAG9pPj5Ms5fSHoSx+DYb5frx0sFEb4hhDiIBa8uFe/mt0go7wFr
         SpvV2D62Pjh4dnWr+Hwbti3AoVfaZLldDgbu2TQNhorUm7XbjcAoJiiflbon8Sat2w
         1JOSEDkABxZN/zl1Nq0TJIVjAuELRT1Bx1eZsHb8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156864062018.3407.17075284512789171310.tglx@nanos.tec.linutronix.de>
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062018.3407.17075284512789171310.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156864062018.3407.17075284512789171310.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus
X-PR-Tracked-Commit-Id: 743dac494d61d991967ebcfab92e4f80dc7583b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5f12fdb8bd873aa3ffdb79512e6bdac92b257b0
Message-Id: <156875132209.8483.10255150833473379498.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 20:15:22 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:30:20 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5f12fdb8bd873aa3ffdb79512e6bdac92b257b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
