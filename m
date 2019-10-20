Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48260CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 10:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEFD21721
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 10:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571568318;
	bh=Qv3IOH8B2WtvR3sqxWr/c4A+feKw87Sgu6zy2Q3zqkI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tDq2+wQxSgecl7Bdv9+unxRRLnG6v8ghWKIytZsbcprGmmXEDXqu+LDyv4N3GFlZA
	 PAWSJ+i8RhSpeDvYPcvoGAH9+edo1b2aDFW/5PkvNui9QNvsEsnOVyUwfuphdLv//M
	 Gqa64EMweWnsqLhpYHQSNAKjspNBzv7qBKRzqvkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfJTKpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 06:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfJTKpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 06:45:07 -0400
Subject: Re: [GIT pull] timers/urgent for 5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571568306;
        bh=Qv3IOH8B2WtvR3sqxWr/c4A+feKw87Sgu6zy2Q3zqkI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JP2O00wIB7w+7cjdJPhthHawwtEEbfq9slXZm/SPpxlXegPhgzJXb4FZm7DMNGS3C
         3LKlZclogP8Wwa6OAHIEgu6Pw34dXadqx6FIms5w2r7IlAndJypUH38TRBPmHLXMki
         CXCnVdVq2MV9ppt/UXtVusyRT+owgAFLKJEvWfEw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <157156643658.8795.9500007947486352048.tglx@nanos.tec.linutronix.de>
References: <157156643658.8795.8700195163364281095.tglx@nanos.tec.linutronix.de>
 <157156643658.8795.9500007947486352048.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <157156643658.8795.9500007947486352048.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: ff229eee3d897f52bd001c841f2d3cce8853ecdc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 188768f3c0727d4cb95eaad6c67799449aebcc03
Message-Id: <157156830666.17957.5112944954626804158.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Oct 2019 10:45:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Oct 2019 10:13:56 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/188768f3c0727d4cb95eaad6c67799449aebcc03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
