Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54DEC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB6120866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576867518;
	bh=G+XNGXLYcR+MVGKjJqbdVW7gJ5qptEOEOzLBm0WslQA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YzKpmhKfPvJNOuVEfzHSGJtGdNxlEhx3wkw85RGbYsRVfWffd8Rxw8X03STu+49uN
	 RlQOPiD98EmBPzfIslUexaq90zNzKVFVgwyKN91k5AVtNJugQpBOiejm/NFQLX4D4U
	 J6doE4miirLLunz8FKjVUg+kLbQSNwdd+pQHBYAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfLTSpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbfLTSpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:45:12 -0500
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.5-2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576867511;
        bh=G+XNGXLYcR+MVGKjJqbdVW7gJ5qptEOEOzLBm0WslQA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VkRdkai0JYpxFIGY+VAfdm9zdMPraHxwElSCkn8RhwxCVHhHhrR1ExbPYLRt7fRiy
         VnZIvW63k6AzG51mfzw6iwjFFKkO+ei8XMql5O8yJT0+IJy0o3QW+LNwdQgxMnRRaS
         uqACLJ/CAgQfGtiURniPHVPcs7URECWIhwTPxHiA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191220171948.GA3909@smile.fi.intel.com>
References: <20191220171948.GA3909@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191220171948.GA3909@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.5-2
X-PR-Tracked-Commit-Id: 02abbda105f25fb634207e7f23a8a4b51fe67ad4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fce34dec76d93311f90f1f077e1eba3605a3771c
Message-Id: <157686751177.22538.9893885755920683892.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Dec 2019 18:45:11 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Dec 2019 19:19:48 +0200:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fce34dec76d93311f90f1f077e1eba3605a3771c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
