Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08F8C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB53F21835
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569085823;
	bh=EStalLVlkrFkvERQtdrDZSLsXj8Di/QwCb/l6m8W8Bs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wZT/CQmoUI+yeUN8LZ9R2cDh3SLKg8bqZDw7g5nitpV/HWKSiDIXvQUUDOUKe+HCd
	 a/t4W76hvYIw7S8cp3teZjj9rFmFcMpVHRDxxp2TDm1XiJMI7H87skf6RytD512iRl
	 6ns0BS8SzwBs9NulaLRIU9M7Zd/kiHsp6I7ly91g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfIURKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 13:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfIURKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:10:22 -0400
Subject: Re: [GIT PULL] printk for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569085822;
        bh=EStalLVlkrFkvERQtdrDZSLsXj8Di/QwCb/l6m8W8Bs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u0U/a7u90qr20rRY92QE3M6ngVS2vGMfg21m2ZwJjU77+ttu33RvdSnE1+z/m4+/k
         IM07mZG3F1GwQJBoDZSpRxxuYrSLlJ2fw4mbzmPB4dfsBZC3wFWzMgCqYjmUJI+eF2
         3yeQditcHbCNQxejnPhQsu5WYu0PL2Ffc9hjHaMA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916112431.jsts2owcco5pg4jg@pathway.suse.cz>
References: <20190916112431.jsts2owcco5pg4jg@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916112431.jsts2owcco5pg4jg@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk
 tags/printk-for-5.4
X-PR-Tracked-Commit-Id: ae88de56a1893bdccc7b5af8c12556de649d675e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56c1e8343494f0a315c99964ea1a952478394a8d
Message-Id: <156908582197.8665.6078284819252997115.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 17:10:21 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:24:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56c1e8343494f0a315c99964ea1a952478394a8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
