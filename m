Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AD4C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1CC217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562636714;
	bh=7LRlYJI6n7HW+W6MlSfyCl5L6Th4QCaGt1RixVzhSEU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Cm80sjqm8yaj4frMHkndvycCMuVcsWwGSGdmxL1/D26urzcmEKMAZWrAtKWUKVJ8q
	 /UzQvGFwMC1YtLoPBYNoubo7lJ5V0hvgHkP3uHaI9UcDUdlq5szDLWIF/Dg7lqcwWF
	 wuqb6aOWIQoSJ6Sh4MpZcq0HrPayx+KyQ5TdBqQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfGIBpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbfGIBpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:45:12 -0400
Subject: Re: [GIT PULL] x86/topology changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562636711;
        bh=7LRlYJI6n7HW+W6MlSfyCl5L6Th4QCaGt1RixVzhSEU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=h8ZOAQSr9dLHdSPS92K/Ek0M3evaCIsyj8KFht7CztFQVZrzDVUeeppMSglliSM+a
         GYRxgeUex38HOYX/sZHIHc01YxaIwvmVdDZKZnjbTaWRYRZHn0Ho3vQMciqfnWJTbZ
         n7YaAKnClD+ER6LHbtPz8fN721Qfd8c1vN+vEyrM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708162756.GA69120@gmail.com>
References: <20190708162756.GA69120@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708162756.GA69120@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-topology-for-linus
X-PR-Tracked-Commit-Id: eb876fbc248e6eb4773a5bc80d205ff7262b1bb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 222a21d29521d144f3dd7a0bc4d4020e448f0126
Message-Id: <156263671183.17382.14073111748256139193.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 01:45:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 18:27:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-topology-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/222a21d29521d144f3dd7a0bc4d4020e448f0126

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
