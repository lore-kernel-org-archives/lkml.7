Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CCFC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DF2217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557509718;
	bh=xV3l+3krm5CR2cCCmLOfhgrEM8WsZNWM41hDv6SJxH8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aV+jDg7JJSEERgx2lPTOhEi/OAlIseDmnhSjB78/Fzca2HhzPk/FrX5l3cjUl66Qw
	 UCS5f830TwO5TVSFwjfFifqcg7//9WMO6txZGzwUvwGmTGiF+ydGo03ze6x/WZm09L
	 huIWLOpWgdjzBvdif4MlkYku1BM9TxMowX3pzkSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfEJRfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbfEJRfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:35:16 -0400
Subject: Re: [GIT PULL] printk fixup for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557509716;
        bh=xV3l+3krm5CR2cCCmLOfhgrEM8WsZNWM41hDv6SJxH8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2vdxCBe3UJ5g92vEdcpWc1MwVaOM9LLLW50U+RJw6Vj3J1w9Vhh2dCZi1F9gHrTjf
         EmuSigKVSlWtCw4bTK548RmqclIZYgNxbz0iP/gzBmGW806N1siB1imcT4KVc8AVKH
         wd3aKInGzm9dGV4juQymWNpvaJncOmBxi0VeUs2M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190510144718.riyy72g4cy5nkggx@pathway.suse.cz>
References: <20190510144718.riyy72g4cy5nkggx@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190510144718.riyy72g4cy5nkggx@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk
 tags/printk-for-5.2-fixes
X-PR-Tracked-Commit-Id: 2ac5a3bf7042a1c4abbcce1b6f0ec61e5d3786c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e290e6af1d22c3f5225c9d46faabdde80e27aef2
Message-Id: <155750971628.27249.7863468655881055424.pr-tracker-bot@kernel.org>
Date:   Fri, 10 May 2019 17:35:16 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 May 2019 16:47:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-5.2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e290e6af1d22c3f5225c9d46faabdde80e27aef2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
