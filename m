Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC2BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F0020661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897116;
	bh=APs6a1GalPHA81qsMC7OtWq0V9/szdw9p5JYwThGCaw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QUCbvlwcKQJQY+MvxxZjeCw4IJSY4ih02td5I4XJL1UQX2/pP3NH/gSulv1HcljxS
	 sgZnf8KcpVpkTi8rSwr7l2mDn0oO2IiklNvR5bm+anY6vi9UcXM5B+sXGmcV45MSPX
	 oIhOimuIBWe0wdXHTHgAVXzWbt7KNNjECElxNWk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfCFSby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:31:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbfCFSaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:30:16 -0500
Subject: Re: [GIT PULL] asm-generic changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551897016;
        bh=APs6a1GalPHA81qsMC7OtWq0V9/szdw9p5JYwThGCaw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f0FYIKbijyLxTnzZU+RL5bkJj1sFOXN0tRd67h4VInrT3UGsEvz2DaixUmTgWwFxb
         qhKlndP0Q1Jb+Yt6cykpkJ4mOkkaKeqavSLE8zqzhq5QLtIyEnaDylin+RI14fI/Ne
         I0F6IAw09Ahrp3Q/R0CNF1+DA8lX/voEK2RKn7yg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a2DX1TRubsmrkEckuZCYTGwmfN4KiuvXazJQL9vrUTBKg@mail.gmail.com>
References: <CAK8P3a2DX1TRubsmrkEckuZCYTGwmfN4KiuvXazJQL9vrUTBKg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a2DX1TRubsmrkEckuZCYTGwmfN4KiuvXazJQL9vrUTBKg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
 tags/asm-generic-5.1
X-PR-Tracked-Commit-Id: d724444ab97d2cdf1c4dbfc1ff65d0b18a9631e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa29f5ba42404b44aceb1a63ff4757efe5cd1789
Message-Id: <155189701621.14612.9040199769056341296.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 18:30:16 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 16:07:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa29f5ba42404b44aceb1a63ff4757efe5cd1789

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
