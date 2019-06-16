Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23145C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54C821473
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 17:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560706508;
	bh=TAuycCk8vkPeA6bgYN0WxZn2rzfjTZS+siQOmXz0YUA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nxAoYme4oeqb6lJC0+8rZ5+YzueVqsDatOt+T+w8q6+drHHhy5hyArGuTg0Jn9P6y
	 9yzp66IiSCJ4AtsShQuCH9mDXr26MDX+g8M6BR8BHHnKq5TFKhNBTafet3oXg80wIr
	 bUiSM99pVzHlEXPfzdC1Yt7nqpBG09KDrF7awauE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfFPRfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 13:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfFPRfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 13:35:06 -0400
Subject: Re: [GIT pull] timer fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560706505;
        bh=TAuycCk8vkPeA6bgYN0WxZn2rzfjTZS+siQOmXz0YUA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xYn8HoX4TwL4SxRgA/SNsZmbs8X/DCQr9fEPMsXJKwRsyFA4HBmdnVGMzffWyt/zs
         xsUcF122Xj3G2n6iW+ZgcQhdrpr5Vw08zEGkyDJ+bfxNs1n77IOX55QdlRZYvAjxGQ
         oD7N+bJ6P6EuPv87sxX1MQzFiObyKmt/1yftTiGc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156068459205.30217.17659593879245974125.tglx@nanos.tec.linutronix.de>
References: <156068459205.30217.15980952927216488865.tglx@nanos.tec.linutronix.de>
 <156068459205.30217.17659593879245974125.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156068459205.30217.17659593879245974125.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: e3ff9c3678b4d80e22d2557b68726174578eaf52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efba92d58fa37d714d665deddb5cc6458b39bb88
Message-Id: <156070650561.13049.15539313572516926150.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jun 2019 17:35:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jun 2019 11:29:52 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efba92d58fa37d714d665deddb5cc6458b39bb88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
