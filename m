Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0D5C76195
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 18:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469CC2085A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 18:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563648052;
	bh=ll1v6hmUc7AiRx7yqSRHB/zv2M50rKm8tJl4An3pg0Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=q4PN7S6R6EOKb8lSbsAJwcBrCgzFxPpoYTIHTi5FKYOWWdqYsVh6q90HGCwDas6jT
	 54B831LHq10Uy1z3pbhh9DwlwXGKBYdQ3Uud+bTL+t2H/YdImG5KcYgatDwl41MRf9
	 S0hwi1sX6HGQJx2UN9jXzOl1pyHnoy8X2vLt0B/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfGTSku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 14:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbfGTSkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 14:40:31 -0400
Subject: Re: [GIT pull] perf/urgent for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563648030;
        bh=ll1v6hmUc7AiRx7yqSRHB/zv2M50rKm8tJl4An3pg0Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ltZ9VtdCvoBXGU4iJ5vEOhAiHr7g9Zy3DV8cHa5IsS4JCuRUXDexlDzqIDUx87W3j
         hz4XtVImYObTkqNZoSfTx8kCYpt86Vk+NrRsELznVquGvPp4v6QU1P+xnIBzXNRQXu
         UcgT7R85ndY6/5iCcPnbLLGus+vpAvccipTMVu4s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156362700019.18624.13205640129006069326.tglx@nanos.tec.linutronix.de>
References: <156362700018.18624.18097992605540415098.tglx@nanos.tec.linutronix.de>
 <156362700019.18624.13205640129006069326.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156362700019.18624.13205640129006069326.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: e0c5c5e308ee9b3548844f0d88da937782b895ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46f5c0cc3af0ecb76224a91d2997d74e35ff7821
Message-Id: <156364803081.20023.14197029287253196676.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 18:40:30 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Jul 2019 12:50:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46f5c0cc3af0ecb76224a91d2997d74e35ff7821

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
