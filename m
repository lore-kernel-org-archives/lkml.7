Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8666DC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E66A208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562702131;
	bh=X21EgHxZMVX721gzxHS8gFrq68RvC1djA1EQZ0iTsXA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wV0X+j8eoQDVv/2YX9LnZw0ZAi/JN0IlNt5gREU9AXOUh7I5NEeLRay0AofzIqHZU
	 qS6nwU9LQz2ltHBovbFtXmsQyHTZepO0tfiUVxoWCrwnv7C9rK85WwzxI8bbovMYIB
	 05aFW8YOa/PKFC0n1MFL8MenUzwQelhtBzhV4pw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfGITza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbfGITzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:55:10 -0400
Subject: Re: [GIT pull] x86/boot for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562702110;
        bh=X21EgHxZMVX721gzxHS8gFrq68RvC1djA1EQZ0iTsXA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TEYPZ/yAmhBv/5kaISmlFfE9Kghy51DMFaElnOcU6Q2zS8VmEXFQEeUjRkKq7TwlQ
         80MRRFYplRbjRUC36ZFGmGMKQmzyoGIqUgdAxHg4FxF426jF5PlPN2KmN4mQUkdpdw
         ZktzrNKIWEWmU/2qu7wQQ9U6J1g3mBpzK+6I8qh0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156267559466.6547.5675975755906539836.tglx@nanos.tec.linutronix.de>
References: <156267559466.6547.5675975755906539836.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156267559466.6547.5675975755906539836.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus
X-PR-Tracked-Commit-Id: 8ff80fbe7e9870078b1cc3c2cdd8f3f223b333a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7d5c9239855f99762e8a547bea03a436e8a12e8
Message-Id: <156270211030.21525.8116972067868395720.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 19:55:10 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 09 Jul 2019 12:33:14 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7d5c9239855f99762e8a547bea03a436e8a12e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
