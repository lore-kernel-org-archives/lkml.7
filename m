Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B757CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E1E206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552257038;
	bh=INZvUbo6LyGvsFJ2805zvwiWNTBDzHg82z+J8LhI9so=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RicOYOFCZYRgjG967HlVLfvBmKfCeeHfPrpExXmjgUPeeJpN5X6JRz+Am5c2RjZtk
	 GEebV2ZKexsK9+DApZ3fSyBz2vXNPAEKZYSy3dyiSa35XRwVrnQXqPP7orzYrx0R5O
	 HDE1QRsz2D6Dkygpkf59GnP7W8qkmH8O0Q7YnmT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfCJWaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 18:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbfCJWaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 18:30:18 -0400
Subject: Re: [PULL] virtio,vhost: cleanups and fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552257018;
        bh=INZvUbo6LyGvsFJ2805zvwiWNTBDzHg82z+J8LhI9so=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bzl6IsSXyF6RghAJNAWOZjUlzHsVuiiI3W2QEU+VQrH7ZhucSzI8RRQnXg7IQyd8w
         tCDSr9AYrjgYHzLR4cX6BO3u8SeO0IX+pjsUHO5fYu+UVKIdGCHYUhDjy31nDuIbC4
         37zPJoyMcqQvvB3MCa0ZB30aTcxPHEXMbUS3a7I8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190309224435-mutt-send-email-mst@kernel.org>
References: <20190309224435-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190309224435-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: cfdbb4ed31aa777d59b288810f66eb06249ee5b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45ba8d5d061b13494c2a7a7652d51b9da3d9e77a
Message-Id: <155225701795.14748.14428790498373289651.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Mar 2019 22:30:17 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, cohuck@redhat.com, jroedel@suse.de, mst@redhat.com,
        pasic@linux.ibm.com, wei.w.wang@intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Mar 2019 22:44:35 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45ba8d5d061b13494c2a7a7652d51b9da3d9e77a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
