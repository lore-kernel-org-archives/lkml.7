Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1A6C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE9A2147C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555788316;
	bh=PoavWyzF61lZMJU8xR2Iik4pMEEOrIB7nr6roxTUj/c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l1N3uPBrT1ccupL0rEPcsYANmQQqut4nuVwI0j6wc+EBEBgKNB4eGf+JHq9K5OeG6
	 887Y/kzT0NDXlByVwc3UZ3DdSeRhN5pl4a7pYwVecAdV2Mm5dxWjltN/gOCaIQFQzd
	 +twduozfSUYNNpY701Klsg4BkXuYX66jzY7WUuG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfDTTZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 15:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbfDTTZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 15:25:06 -0400
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555788306;
        bh=PoavWyzF61lZMJU8xR2Iik4pMEEOrIB7nr6roxTUj/c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rp0FyvjTwf05l4mDCywiA9yUI+ZSHWsQ/ho7vVTvUM2Ct4jQPwy17NLiFIuXL5E1N
         6MVWRA7Lz5H+V5ktSzbnIq1z04guwKadUHSrui+lO7crG2Oc58ODTe7wRXFuEBdQ0t
         BtBBF2ewHB7+u0SCVd4Gw4z+64btjeUxCm8DX66U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190420074353.GA108422@gmail.com>
References: <20190420074353.GA108422@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190420074353.GA108422@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 7579dfc42d2e3bef901991803efc81dc1ac65f2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b25c69b9d5e41159b54ad7cb33f7d9ead8523d33
Message-Id: <155578830603.28386.6714855502609895516.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Apr 2019 19:25:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Apr 2019 09:43:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b25c69b9d5e41159b54ad7cb33f7d9ead8523d33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
