Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C85C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5F520830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568283313;
	bh=kvyF34K7Eca6sFKKZQBDMRH6uFS9WMFgrxWBLDjsrmU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pKHCvwmBqpYHGpmS73xSbwmjnGNJVMpwBJX+jOBw3plW7riZYPRERs7mn8Q267zsT
	 cTnyM4WZNrxf0A6e+7P/6fUiuXTsgPavkpy8au90w0UP5DixNdPRk7n1J//9yTq+A2
	 r8wplFWVrbGUbHT9JaP11B2D87nMCgLaQ7hD7/p4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfILKPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731067AbfILKPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:15:08 -0400
Subject: Re: [GIT PULL] perf fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568283307;
        bh=kvyF34K7Eca6sFKKZQBDMRH6uFS9WMFgrxWBLDjsrmU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=w79tKd0XfPWry9mWTg9hwrxmqeHIGczqU/1fVAstTXmaH/s7tY7XwHWfZ2SP1ttTy
         mGmkAPi4wFX17AoAH8XcO/Xf9OJogDgkvJjO5F0LZy2bKS9768ufNsP7hc3fZ7urz8
         k5XHnpi3Gt+S88RHf6ZPPTzEcGqewd2rcgQGVhpA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190912083903.GA38044@gmail.com>
References: <20190912083903.GA38044@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190912083903.GA38044@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 310aa0a25b338b3100c94880c9a69bec8ce8c3ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6dcf6a4eb95a8a78c181cd27132f41aca36aeb94
Message-Id: <156828330780.21107.11443017179679603703.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Sep 2019 10:15:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Sep 2019 10:39:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6dcf6a4eb95a8a78c181cd27132f41aca36aeb94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
