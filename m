Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EB6C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B585217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558118126;
	bh=6WSrm7CU9Tm6HWnt0vnmtN/h1Ph2xqGVGJsHmrsBsfU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qqKBZdZlRiqME+XJwFWMWIvX1OvHgTdfw/msA/vuYWaIs4t9pasdrba4+amxPuBIr
	 tZoJhwXcZrXQxrgXrDEWltO2/ETFlt0yfke8+rKnJS9ts0gM5bWz0DyL/mrSNEox+k
	 hJ8eIBqSk5H/VtHolpLx+SJxUQqiCcrUAZsG7v3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfEQSfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbfEQSfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:35:24 -0400
Subject: Re: [GIT PULL] nds32 patches for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558118123;
        bh=6WSrm7CU9Tm6HWnt0vnmtN/h1Ph2xqGVGJsHmrsBsfU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=duBwsYO+2gnbonA5jDCkJoh4kxBdMdbPTAjjLWFaAQMiXGX9aUR98Ud+D8q6YhOdC
         oHqsLH8om31A/pD0fIRHSyNTcc6y2FJS8WvMARgvzlnE0ByviH4vb33bnLZWHPki+9
         GXbeRXtuV+ZT8KmLmqsEDnYEOS24AiBKzB2PNCZE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAEbi=3fvgapD4JRq80JbtAgR+KpHDZv60etwVs8sjqoNM5H6og@mail.gmail.com>
References: <CAEbi=3fvgapD4JRq80JbtAgR+KpHDZv60etwVs8sjqoNM5H6og@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAEbi=3fvgapD4JRq80JbtAgR+KpHDZv60etwVs8sjqoNM5H6og@mail.gmail.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git
 tags/nds32-for-linus-5.2-rc1
X-PR-Tracked-Commit-Id: af9abd65983cf3602c03ef3d16fe549ba1f3eeed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4489da7183099f569a7d3dd819c975073c04bc72
Message-Id: <155811812394.11644.11570129763005372892.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 18:35:23 +0000
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime <greentime@andestech.com>,
        Arnd Bergmann <arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 May 2019 16:32:10 +0800:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git tags/nds32-for-linus-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4489da7183099f569a7d3dd819c975073c04bc72

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
