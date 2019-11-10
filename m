Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291C9C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4592184C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573419615;
	bh=BuZl/Q8P/ZIByAQZ/C7e9C36sAF/rxlEly5Wf0UZ730=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hy/npocHAwlU+Wo7QNnRT/cUJyFTBhOcnPCnY5uHDzuOqE4nL8RSHRiEiq3NlMvNg
	 68S6NDpv5FxSkrxpF/yQWfBdTb7V6VHphXqi5v0dYZBUAulkJesgiiT6KKUACPGK6w
	 pa34auz6sPXrKVgkM6LKtXF4iF/W04xo3VMkNVdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKJVAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfKJVAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:00:09 -0500
Subject: Re: [GIT pull] perf/urgent for v5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573419609;
        bh=BuZl/Q8P/ZIByAQZ/C7e9C36sAF/rxlEly5Wf0UZ730=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UzlgLeabWyOV4/zgwjWUvM9MiWKzTjVvtXMPgMM5oLHS861nggnEdhI1uPy5NQzMj
         ixs+0pYBELHPGMcSSYILACrBfvCSTfo6h0niLhH21dvQPwviIEjdJsw+XQzvYuiBa0
         JgeEn6f0X3VZw3TkQngdv225y+v96lwkVS1nPlA4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <157338131324.14789.15657972801854961625.tglx@nanos.tec.linutronix.de>
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
 <157338131324.14789.15657972801854961625.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <157338131324.14789.15657972801854961625.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 485c05351312131f1c7486c623087e66bcacfbc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b584a17628b0bf4b04ceba066dd1a69c5f097276
Message-Id: <157341960916.30887.17427346837834828798.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Nov 2019 21:00:09 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Nov 2019 10:21:53 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b584a17628b0bf4b04ceba066dd1a69c5f097276

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
