Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176C9C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 17:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F162184E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 17:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560621307;
	bh=f8FtjePG/h27fTmwsBArl69zyMjwbxuO5ehkxcSQ2RU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=13txi9hKa+6XxgbVYROXDUwMrFz0+RDOhnHLZPhrICZUhJyErE4ROLRF/cIqg1+/W
	 K9Osp+Cu1/lQuk7/JmNn88WEFe5gtxRLMiYFfnuHB4WmUDeQQcXNh9pwlrdwj4CbpC
	 KjYkGFTAy/XSq4zUhyESgV8pEtpg4/eKdHNLZnJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfFORzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 13:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfFORzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 13:55:06 -0400
Subject: Re: [GIT PULL] tracing: A few fixes for 5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560621305;
        bh=f8FtjePG/h27fTmwsBArl69zyMjwbxuO5ehkxcSQ2RU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jPd1ZBvC1MhqZnkiSfQbyLj0ZYUd+HY78gsywD5mCLdBIoCiBnKVMYX+UYuODDGKY
         7lLFt7pAXZU9z+CDUt7f6WuTWkwFbee8bmgWSSxVFsezJQtmMJp0XLoGU2PnkgkHv/
         6IfFJJBRQbJ6CK4bN534sY9gRdeV9Zq/Rut2l8N8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190615084903.763883c5@gandalf.local.home>
References: <20190615084903.763883c5@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190615084903.763883c5@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.2-rc4
X-PR-Tracked-Commit-Id: 04e03d9a616c19a47178eaca835358610e63a1dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a71398c6aead255efe445ea96d52b33f0d5f0b2
Message-Id: <156062130559.5191.3426124715879613891.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jun 2019 17:55:05 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Jun 2019 08:49:03 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a71398c6aead255efe445ea96d52b33f0d5f0b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
