Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9007BC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B1F21881
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568669712;
	bh=Q8GTme3IiHedr7H42Wwk+kuVWATq+D/siW94eNG8dt4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QrSIAsEzGnVblUz3iqwOPEpHD4gEpzYFfjE3zDz2jNeYzhcZ4JtT8etr2WGjf2YEF
	 QCPRqXreNc6gHEGzxzFX0rAzzhK5I1BrmQjyf801QedfueadErZQs115dNfZtokGiQ
	 XmcTVdoKN4qCI8Om7DgGIJT7n8LdIWXsHVmz9vtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbfIPVfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfIPVfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:35:09 -0400
Subject: Re: [GIT PULL] EDAC pile for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568669708;
        bh=Q8GTme3IiHedr7H42Wwk+kuVWATq+D/siW94eNG8dt4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IIjlXLjP2ErJ79nKZsKfl2giW+yUZFHDoD1/DovmBk6/EnrWrJ+TLhJ7NddnrpEw2
         RJhTjxNRMH/n45GMQ+uMps5aC8JOedZJu8k/rGCZg67ANhgP3MCaXiQhcpwCmJ7MfX
         KZm6X72vX0kJNbmflZV++XT+mooroWzstTp71o/Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190913074229.GA20745@zn.tnic>
References: <20190913074229.GA20745@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190913074229.GA20745@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_for_5.4
X-PR-Tracked-Commit-Id: 3e443eb353eda6f4b4796e07f2599683fa752f1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff881842e12563f25d69a4e2e373f1ad392a7027
Message-Id: <156866970872.13102.12851440763335110247.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 21:35:08 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Sep 2019 09:42:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_for_5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff881842e12563f25d69a4e2e373f1ad392a7027

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
