Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DA0C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECCE21721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555177206;
	bh=HvUgy4RfPn+Z6SHzEhZ2GvP+f7rd6+R0TwNwQ3GZJT4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=V9kO0SbYtkYyN7M+FHTU1yjt4kDP3JgRNXr5C9nPzgio7nwvfRbQTddyl2tQk1sst
	 3RZ1PHv3S1poc6cU0Ipzdlr3u+sbjWUHsmwGKZU5ZcxN1SykcYQ9DDCBBQoPvkaKU3
	 BKAZdfPfx71Du3mtRVxFzQBUlOKNstwLEIiIemwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfDMRkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfDMRkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:40:05 -0400
Subject: Re: [GIT PULL] arm64 fixes for -rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555177204;
        bh=HvUgy4RfPn+Z6SHzEhZ2GvP+f7rd6+R0TwNwQ3GZJT4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YYnZDca0b0c9cyePeDtNAfAhufiG/wIcxMACHPQxr5p9iwk3TPvWtACR4TSL7IXD/
         +FqI31kLRm4PfvZRJTEQkVTtlfkT0NYRg16bwV9lQ/WwIbDg3273Ns+4nKYfsniGS1
         fZydzUsL+5ZCqi2xqXSfdQMyfBZfDDGoaQ4RVv0Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190412160515.GH31037@fuggles.cambridge.arm.com>
References: <20190412160515.GH31037@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412160515.GH31037@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 045afc24124d80c6998d9c770844c67912083506
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ded88718aef7e92a9806f6ff4b89c7f2a4f1570
Message-Id: <155517720454.14034.3108092874174840690.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Apr 2019 17:40:04 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 17:05:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ded88718aef7e92a9806f6ff4b89c7f2a4f1570

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
