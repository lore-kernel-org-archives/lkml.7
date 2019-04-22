Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CB3C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E85206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555959609;
	bh=F/jM/sbVXVAIPz9YxoPWYIlG8o6hnhhFsgoannOTewA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JblMu7YRoqxEivQ93PVQAyintP61N3QpMmm25Fw2jBjwzMDjj2ZEP8pGFqXeC9A7x
	 IVFp1EFMfWq9rkdtMU8eaFhAcnXBg+Ebs0flM3EJHSq9OhrMP4mN+1Mjwbu7ijw+GR
	 587ei0nI4rMVCPigL2JLrK3jeDYWmN5WLmhDyYOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfDVTAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbfDVTAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:00:05 -0400
Subject: Re: [GIT PULL] MIPS fixes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555959604;
        bh=F/jM/sbVXVAIPz9YxoPWYIlG8o6hnhhFsgoannOTewA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fl3XoOM13J7mVuiRPUcJnrFzu5JNgkby4eqcLBzCxSLjxn+qe4t++epC1p4uP3Oib
         OmRvre4AJ1Y2o/JHkcNDMOy1hFEp8lkXESrT3eW8uRC1cK/bj9W+Fgcr9WG//RI/Uz
         nomqgv3KkL51STMhwvf+rm8bLknt+E30VIUq4DWA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190422182744.2764mje5ohnaubz4@pburton-laptop>
References: <20190422182744.2764mje5ohnaubz4@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190422182744.2764mje5ohnaubz4@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 tags/mips_fixes_5.1_3
X-PR-Tracked-Commit-Id: a1e8783db8e0d58891681bc1e6d9ada66eae8e20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7142eaa58b49d9de492ccc16d48df7c488a5fbb6
Message-Id: <155595960442.28094.18149253271588843434.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Apr 2019 19:00:04 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Apr 2019 18:27:49 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.1_3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7142eaa58b49d9de492ccc16d48df7c488a5fbb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
