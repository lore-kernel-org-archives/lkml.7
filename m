Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D04C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE15C2464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575670526;
	bh=AbRdZ7SBCyWyKc3F/kBL7hrnnldR4UdcqLH+ZOAZmnU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=owoKQspJi3wrk7Olj/+tUFQm32zuUmrRiy6NUrOEVUjtMgTBXe+3i77G3GBk/vwL0
	 RxTwdMugXxqThr/agEjhZBQrekjjhcwEyNbsQ9X22wcgNDKa2CHeOOf+sB6j6ah/6r
	 ID7ze3m93pY4hVIZDrs95KAjaO9I4umFw96geBgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLFWPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:15:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfLFWPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:15:24 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-2 tag
 (topic/kasan-bitops)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575670524;
        bh=AbRdZ7SBCyWyKc3F/kBL7hrnnldR4UdcqLH+ZOAZmnU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZhHLnMwvCYtlfUxbeaLmjky6pwZxoR5Wm/luBmyN0RzfFfmi1w5tXO63KwHRSoqSZ
         iz+KjysxoPWXuW85jRzRkNI2/w1yHGaQ1arTWXTQO9cxZ+FtRwosOT1oUdf5Im7J/7
         OGhwmLLgv4Yf8vvGTTLTseOvd5zoxPUd5+hmdlAI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87blslei5o.fsf@mpe.ellerman.id.au>
References: <87blslei5o.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87blslei5o.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.5-2
X-PR-Tracked-Commit-Id: 4f4afc2c9599520300b3f2b3666d2034fca03df3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43a2898631a8beee66c1d64c1e860f43d96b2e91
Message-Id: <157567052394.8833.9919496603126638238.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Dec 2019 22:15:23 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net,
        elver@google.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, kasan-dev@googlegroups.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 06 Dec 2019 23:46:11 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43a2898631a8beee66c1d64c1e860f43d96b2e91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
