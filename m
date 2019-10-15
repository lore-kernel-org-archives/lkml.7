Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EBCECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D6B2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571178312;
	bh=kvmC4E7L+oeDDz2E8MyZ7vy8vlZuBNRvi0r5zkZQzEw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0Z14Pkzl4ROcSSPKaWZM5PcAdB1PWhrQNvxk1zqBEyxpgcjIJcNcV+H9BtrrBUM/M
	 SydG2KSnDfOhKPwDnKdFlymigpnUEybHc9E29a55hbCMm+pztrl9GfWTLiI98IVYs4
	 3swAPptR9EL6PukaTbFCeiH+k/S8fa0/eB5aFLls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389882AbfJOWZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732265AbfJOWZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:25:08 -0400
Subject: Re: [PULL] vhost: cleanups and fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571178307;
        bh=kvmC4E7L+oeDDz2E8MyZ7vy8vlZuBNRvi0r5zkZQzEw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bnEMMCiIkY+cceDhVmWI3SwGLOVkTzLzCA/iEbt/KJrqDlApuq1MhEKMRMmJl0rAl
         osldAywju56GIGmKTtqF+C+aeNULWZ94iC2j7vYgpDe4VJhvo7DujiguCdSUN2Kl1R
         7OYLubeq6rVlb+Xn702ULY86zKyVld5Q9SzjvvvU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191015171908-mutt-send-email-mst@kernel.org>
References: <20191015171908-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191015171908-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 245cdd9fbd396483d501db83047116e2530f245f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b1f00aceb7a67bf079a5a64aa5c6baf78a8f442
Message-Id: <157117830785.470.239830549616573165.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Oct 2019 22:25:07 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jan.kiszka@web.de, mst@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Oct 2019 17:19:08 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b1f00aceb7a67bf079a5a64aa5c6baf78a8f442

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
