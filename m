Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4B3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A241206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552257042;
	bh=4VcDd5YcpOAsRA/ewAGG7zW/+zuxXVEvtU+mVee2J8U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RVjYkr8h0i7WGUCflzgHf3lua1xZvXNzUeRW22Ggg/Nvq7IOt04iwdIMq6TDJyxte
	 hyj+drxi4gcqLWdUZ9LVS1li8sTQTxnIvq4lRk+SmapX3S7Fc36fNjCrPIlBhqF493
	 kKbGHpJIeGphgwAknTmvG9Q6FOyrJH48IpcK9pHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfCJWal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 18:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfCJWaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 18:30:22 -0400
Subject: Re: [GIT pull] x86/boot fix for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552257021;
        bh=4VcDd5YcpOAsRA/ewAGG7zW/+zuxXVEvtU+mVee2J8U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CzBo9riKOYjFYjUD+IkfIMZwQQaL7l+Pz6kKEpyMo51C1hAVBQVrJUu60k+8RcRCj
         5Am9jQs5yGMU7RhRf+CyuMOlv0w01Ei0pcUpSLHKCHhapeVZAF2Z8KWTgCSCCiD9cS
         XRa5nF0CxxDa9q/OkPlmBF8i8ofsTdt98XOeBRYA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155221755097.13878.8902608678756592835.tglx@nanos.tec.linutronix.de>
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
 <155221755097.13878.8902608678756592835.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155221755097.13878.8902608678756592835.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus
X-PR-Tracked-Commit-Id: e4a0bd0308f05c1354d28feec8439e869eae6372
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6e3cb4e8679dd971eed33f6a08d62c66a4230c9
Message-Id: <155225702190.14748.6835841419950531921.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Mar 2019 22:30:21 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Mar 2019 12:33:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6e3cb4e8679dd971eed33f6a08d62c66a4230c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
