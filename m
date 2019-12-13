Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6C6C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C372073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576278641;
	bh=3VDMKaOSGPTkNpHGoDx3v+RrnjumjThjkba1A8KfkFc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zRAXNmk7KmeGK/5l5n2Ow5urXRpMrWJQ8ckcjNUJ0Ktjh+nOMXCV0LsW41DPzRcbo
	 qY/TWRl3p4TMMwGsdSOQmZoQFcmRLs6rS1xmMtcsJt1GAMxAe2qqJhgvuOBCrqk22E
	 IbjbwjaXYuME3pbGyhx95yewLxHltOB9ql6qpNVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfLMXKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:10:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfLMXKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:10:12 -0500
Subject: Re: [GIT PULL] Power management updates for v5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576278611;
        bh=3VDMKaOSGPTkNpHGoDx3v+RrnjumjThjkba1A8KfkFc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BkHi6nt36Apy1lP/ei9pr9TOOqlTGXJPjrwyZZNQh+18CKzwwrxqVjwubnHqgYN/+
         I8QhRrt+EclosNFSkHNrtevejA8tBdIn5g3Z31/m6nfie6YWDOQ2Gk9tujK3ByQwiY
         hp10230KRdUBAFeAVMauSiNEwUZrQXDz18uKCOc0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g-xo1f2yPWGzFnrGQKFuHV=aDk_nV6s7hpWNnhnqyv5g@mail.gmail.com>
References: <CAJZ5v0g-xo1f2yPWGzFnrGQKFuHV=aDk_nV6s7hpWNnhnqyv5g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g-xo1f2yPWGzFnrGQKFuHV=aDk_nV6s7hpWNnhnqyv5g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc2
X-PR-Tracked-Commit-Id: 4c84515da8099f4bab5d9312a0ffaf40f14aa87b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bd2c87aaffe0b58ce65233fe922b9eb5f7d9a85
Message-Id: <157627861190.1837.9258292989054106751.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Dec 2019 23:10:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Dec 2019 10:53:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bd2c87aaffe0b58ce65233fe922b9eb5f7d9a85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
