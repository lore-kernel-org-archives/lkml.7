Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCE5C4CECB
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 23:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD03E2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 23:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568503508;
	bh=HAlY7PTyZhpxrPn2T2w567DLfJKHi8UFIvnsdRks9kA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RFJKqQJuMH+TksIySoQBt4lCfEQS6ERrC8cPY9kHKKQDG1bdrQt0FuiFgZHvllJRx
	 9qUoJVCXtpnL3boZOZcl+ibrQCc45BpK/XgT5SZIXV4MVi5FdbAaUcz2kOFB9TP7oq
	 uz/v4LpsnZVja7VDZ7io2lcVNH7DOac48ketz5ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbfINXZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 19:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731633AbfINXZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 19:25:07 -0400
Subject: Re: [GIT PULL] Final batch of KVM changes for Linux 5.3.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568503506;
        bh=HAlY7PTyZhpxrPn2T2w567DLfJKHi8UFIvnsdRks9kA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yevk0WfNReVydZzEsqkr66h20LLBm1RD9zSz5LNkZ0pnZ6FsXvmqYVhbwimViu+2H
         E6kNaGZDe427BuPeX94/i9Oith91i1acZ9WYGdyRn3o3+cl5P+bD0yknHNJiqW/Y1v
         3FMF0SIcX3tfVWbirui9KLUUTnfAJpwlVEag+VhI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1568493101-32728-1-git-send-email-pbonzini@redhat.com>
References: <1568493101-32728-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1568493101-32728-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: a9c20bb0206ae9384bd470a6832dd8913730add9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1609d7604b847a9820e63393d1a3b6cac7286d40
Message-Id: <156850350678.2116.8522970197419391887.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Sep 2019 23:25:06 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Sep 2019 22:31:41 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1609d7604b847a9820e63393d1a3b6cac7286d40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
