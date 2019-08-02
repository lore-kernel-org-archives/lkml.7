Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85CBC0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD192087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564788014;
	bh=3lPqaAxly1FD9PM4K5DpOANPnWOJvGrh2mV6GDIZ+wc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Jc+dmsZw38TmGB0vz55Qm04ufF2HqsqLc+BBgJ+0qFzpYVTvJP4EWFPjIXZsULn/k
	 lUZplNQ4HG9xs7FjjCZooZY7qw5ZD/20S0p7BtbwfaOFuFSMrEsMt5V6Ni9mQE8lxE
	 hQE3rKyiHwd/SX+VqefElo0e9Om6I8nGjeD/B15M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437470AbfHBXUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 19:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437454AbfHBXUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:20:12 -0400
Subject: Re: [GIT PULL] xen: fixes for 5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564788011;
        bh=3lPqaAxly1FD9PM4K5DpOANPnWOJvGrh2mV6GDIZ+wc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MtMFjuTrBaMA/B28MsUqFszAeQEc8Fm4TCfcb2J6Sw/6+vOpjFLFK/kECSPiJFKF9
         zb9sIJb22aFtSqACU+AdW9y9JIFFOhWqQ/uHnvjN5buMmbZEKcze1P91E77lhPlk4q
         3WP47gLVD1n7XRPdTF+wwM9wV9INWjcZpoG5bxMU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190802144746.18653-1-jgross@suse.com>
References: <20190802144746.18653-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190802144746.18653-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.3a-rc3-tag
X-PR-Tracked-Commit-Id: b877ac9815a8fe7e5f6d7fdde3dc34652408840a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcb8cfbd8fe9e62c7d64e82288d3ffe2502b7371
Message-Id: <156478801106.22769.3689998217625205699.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 23:20:11 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  2 Aug 2019 16:47:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.3a-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcb8cfbd8fe9e62c7d64e82288d3ffe2502b7371

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
