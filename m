Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F41C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F297A2063F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556474714;
	bh=JB91jG3UqIifR384er9SRbEfy39RHEw+2yDzyZpNjvw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=q0ufevsJpSmHTUWlSa3CrfRi15GpEKc408qj56irnVCG0sefv8DzjBjdu7Ug7X7um
	 VFg7uSjK5BinhVCKhHfPAcCKTfTrlLPpedtq0/isOck+vCDuGexnsrUPpocOnl6Mue
	 R4mxX2AZSJKzTasga78Kr4Isk0zNzgL0g4VhVKKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfD1SFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfD1SFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 14:05:05 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556474705;
        bh=JB91jG3UqIifR384er9SRbEfy39RHEw+2yDzyZpNjvw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QZ+0Swbozqr/91/ZZQnM8J8adDB84u6Itc6DjqDad/HMLgjUSlAWuZbaZ8V1JWOFI
         fiuUFnCxMNKi4ujMU/rgaQZbcJpZtO7GTqUKI/qgEGpbXWAt43LamWlBr0W3MXI+ax
         Q7hZ/zuXbVNTz82aGC8yvZA636qude2+aDFPLaHI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190428115207.GA11924@ziepe.ca>
References: <20190428115207.GA11924@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190428115207.GA11924@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 2557fabd6e29f349bfa0ac13f38ac98aa5eafc74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14f974d7f0f1f93d8c35f496ae774ba0f1b3389a
Message-Id: <155647470519.13942.5473791493765744124.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Apr 2019 18:05:05 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Apr 2019 11:52:12 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14f974d7f0f1f93d8c35f496ae774ba0f1b3389a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
