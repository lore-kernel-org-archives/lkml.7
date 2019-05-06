Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6FDC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CF52087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186072;
	bh=3paZcCPV2fg5kRx/Oe1eFj/WIZSP2DJbl8y/9DpGQfo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Q32/FMgmgN/PPHe/M43PpgMr9K5slkteyj/80ycXHy4WbbRhB7XQHS9DY+pfw0wfb
	 aNvR6eb5F76vZuE/CFlqi1X9A4ySK/Nde6TYveVvbuZMpjvKDf8hCUFFvwwBVrPDij
	 rk846BBJymYAOMlvGU/JUU6uY4Nn9w9HMwuSYsUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfEFXlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfEFXkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:09 -0400
Subject: Re: [GIT PULL] x86/apic change for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186009;
        bh=3paZcCPV2fg5kRx/Oe1eFj/WIZSP2DJbl8y/9DpGQfo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=a+sOmKQl+nvy/XkY15FvpN5z37B35kRUrbh19Xdd8OxXJ2IXx+9E6qlsfDJv3KnmJ
         BmtPySD1rfxLHTnFbIuT+96sj2gLzFp4GYH8k35ydVNtSZLnN7Dedzb++0QWo3kM7N
         s+jUNom506mNgNcuGUAcVTs3IwxAAI6uYC6N0fS4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506093115.GA48027@gmail.com>
References: <20190506093115.GA48027@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506093115.GA48027@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus
X-PR-Tracked-Commit-Id: 6eb4f08293e971cb1b7b867c7fe994c244b91460
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80e77644efcc1ec1064edd4c66a989cdf2e7ec7e
Message-Id: <155718600929.9113.5636484945252096286.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:09 +0000
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

The pull request you sent on Mon, 6 May 2019 11:31:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80e77644efcc1ec1064edd4c66a989cdf2e7ec7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
