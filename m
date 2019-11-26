Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044FCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB4B20835
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574796659;
	bh=auNg4ILzOb4UsSHSlwQRjazQcpYRyqcFQaYCBGAGdeY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HHP16GvpVl8CeMta/9wm2hVoj/GG/DNng7Jz6flcBsJwndn+51gYhg5PqUixzggfg
	 OsYIsY5/HLUtPuZTlowS09g4aBLjtxIS7tl7o7Zu+qRLgfNGuEA1F1qYPbRFMbVE6l
	 xE8LsVWCbdvtYcosspUhsVoRHQDqaEMaLobhDGno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfKZTa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:30:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfKZTaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:10 -0500
Subject: Re: [GIT PULL] x86/cleanups for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796610;
        bh=auNg4ILzOb4UsSHSlwQRjazQcpYRyqcFQaYCBGAGdeY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u9peOMQDakQVhnQ+j9mvygO8Am62O/fL0qcBanrfZeUGL+pLd+wFSRm+8KIvPYfp/
         AymmhG10y2YbfgPGziBzsuxNkbHy76mlydxBCqXnsHUqOeaPD4H9G//a252zdfbNSL
         4gxrFINg1lZxIgLuKP+Gwb30kQmQTssPaJfAL8j4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125132834.GA42801@gmail.com>
References: <20191125132834.GA42801@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125132834.GA42801@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-cleanups-for-linus
X-PR-Tracked-Commit-Id: b41d62201b9772c7c750360ab668d2caa502e642
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd2615908dfd0586ea40692a99c44e34b7e869bc
Message-Id: <157479660994.2359.14107671678457436664.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:09 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 14:28:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd2615908dfd0586ea40692a99c44e34b7e869bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
