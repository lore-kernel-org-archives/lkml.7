Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77334C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E0B22459
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569529223;
	bh=zIkD/kSfg5XhFw8L2SbxqBNbUVnLHxQoBhC4+Xnm4rU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mDXVHyghteomSzjN3jyJxn+CCtfIwt9gdrmmf89MBW9ZJ+MT2Zv+YdwG8KMKfx2uI
	 +0T1NVEnoLJr0hdicyHA+SQ4IFi8fn7c27E+IjfUM24ZsLpOtz0AcRou85gYOPrx3H
	 /NvE6SrTEiRUHBZFD6EEuDXme03qs/qf/czthbUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfIZUUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 16:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbfIZUUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:20:22 -0400
Subject: Re: [GIT PULL] tracing/probe: Fix same probe event argument matching
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569529221;
        bh=zIkD/kSfg5XhFw8L2SbxqBNbUVnLHxQoBhC4+Xnm4rU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zjJvudbvKI8eofvF3HwPDd1sMfEkc3vPPfArB8U2LZ9Ji6JD/0KMmCcuhR2HsY/hA
         ozjhqlfMxRmIco8dugfC3OIKZl75y5o+PVSgizPT2wpZz8o1Oe4Tn9dQBns3h9MR3Q
         Gp6RihIdriNSh2NyYVpanyPxgkl8AOsl9o10Nr9Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190926050926.03f37f77@oasis.local.home>
References: <20190926050926.03f37f77@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190926050926.03f37f77@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.4-2
X-PR-Tracked-Commit-Id: f8d7ab2bded897607bff6324d5c6ea6b4aecca0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7897c04ad09f815aea1f2dbb05825887d4494a74
Message-Id: <156952922151.31361.4056457356988560697.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Sep 2019 20:20:21 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 Sep 2019 05:09:26 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7897c04ad09f815aea1f2dbb05825887d4494a74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
