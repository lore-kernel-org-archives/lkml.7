Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9F5C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 16:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611AB21851
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 16:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566147310;
	bh=gKjRt1rP2E/xxBfy1XovanO0bnQVsZY0AbItSOmYxHo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=t4MUdt3egzWTMEg9ke8HjSQ5jUURNcNTlTRC9CFAzuM/mTOHSvVRqBdXH5VQANDZt
	 qb7mIypUdpsN0dGxoyfwo1aMIEX2bG27O/OPu1DIS7qzQPKpW7onJvC0PYb0OqhY0g
	 M+j1CyG6stw6yNLkOLh7sF7gxTZDQQUGAAQa3t3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfHRQzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 12:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfHRQzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:55:09 -0400
Subject: Re: [GIT pull] efi/urgent for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566147308;
        bh=gKjRt1rP2E/xxBfy1XovanO0bnQVsZY0AbItSOmYxHo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Trg9eiObULVKiHDahQpbuJoVtcCaS6qd4M/LLQd4WfyhOI3q9zZEnJT3LeJkxFlze
         78X6z8tRl59B3C+7VAxKsyhiscpZ7obiWXkDuGofWNricTEnoE0ABE4RoUOsIYJ15x
         fG9BnC8c3obvgtT3qSKCMgiMOadoS8nWA8M+968w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156612809428.21323.17038181425044292813.tglx@nanos.tec.linutronix.de>
References: <156612809428.21323.17038181425044292813.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156612809428.21323.17038181425044292813.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-for-linus
X-PR-Tracked-Commit-Id: cbd32a1c56e36fedaa93a727699188bd3e6e6f67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 645c03aaca2bc02f5d5cc70804ca00b248b729dc
Message-Id: <156614730841.21549.2029653008479159501.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Aug 2019 16:55:08 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Aug 2019 11:34:54 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/645c03aaca2bc02f5d5cc70804ca00b248b729dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
