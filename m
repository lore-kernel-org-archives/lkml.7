Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A99C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC3E208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556390709;
	bh=8wW4mE2kTD1WJTAztCeYwyS0s18najTjf5qjUezsN2A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0fa3uNay5If5/pT7Ybl19LvRjwHIoIvLxukMH464M49ekYZ43BFswB7kjnMZYwoIm
	 4KtdD5cK6+g3ok1rAGdbOJJxA9eTXjP18rGMToF64eUNx8rOrWV9rCcUs7G3/JCc1P
	 SAKwyZDp9TfUxqvDWuij2TWKlUmdpoZb1+ooGnb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfD0SpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfD0SpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 14:45:04 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556390704;
        bh=8wW4mE2kTD1WJTAztCeYwyS0s18najTjf5qjUezsN2A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IjoYyxhsIorw0hWtiSkIMMpZ4m4AlT45Se4a7//2lS76ciB8Kto0SOhZIJPiNF57h
         2rpIuNnxuioGpwXZ5LhMw3iVMCX3kHyODvQDa0nuYL7WthnOlNayo7nSkTdjWsAVLu
         p1iLpSxNvtjW+4KdLiN+IsSCukZ+VZFDeOU/8meQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190427144256.GA75188@gmail.com>
References: <20190427144256.GA75188@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190427144256.GA75188@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 0d02113b31b2017dd349ec9df2314e798a90fa6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 037904a22bf8b2c999a6e2a8ba971b549c1e9600
Message-Id: <155639070439.28176.17730194823036182717.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Apr 2019 18:45:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Apr 2019 16:42:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/037904a22bf8b2c999a6e2a8ba971b549c1e9600

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
