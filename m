Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEC6C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6146220842
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573419630;
	bh=gl41Y0a2mg8fkhIE3apq1UjVqmhWKEoKFIUW79uZZfM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=idTh1DBa3rrEQcrTQpoxD2+zrMlc3BJWye0F2JVi3nRTlTTkpHpJn8vPzBzeGlK3Y
	 Y/hjWTck0SO8opn92js6oYmyBrYNwMLT7T6jWgWmck9+AwQ16tZRga4X9VQRu3C6Np
	 nCy8HFVKyUwBNwXzwfju8kTS0Mz+djggjIqusFuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfKJVA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfKJVAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:00:07 -0500
Subject: Re: [GIT pull] core/urgent for v5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573419607;
        bh=gl41Y0a2mg8fkhIE3apq1UjVqmhWKEoKFIUW79uZZfM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2pS6+B85Jy74Zl23yv89LokEHONo31cDx0P+xPoDIhgxgrp/3TCHHYcvk0ipvmgn7
         6zLzqrPWco32s4Z/+0uhdBDDrG68aYZbEVB1tqShrOyIQZBdJmQsHS8u87wiPkx+I5
         WUma+K/hEGGFoKLnQ1VUnR/u2M+b+SC457WHkJf8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: b0c51f158455e31d5024100cf3580fcd88214b0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20c7e29684bfe88bfc5f0c7bf60833116bf5e89f
Message-Id: <157341960745.30887.2781298983758671779.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Nov 2019 21:00:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Nov 2019 10:21:53 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20c7e29684bfe88bfc5f0c7bf60833116bf5e89f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
