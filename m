Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0C2C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD51217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555702506;
	bh=Ah+U9QI6VPsp3O3WOcna320ZjpwDoxmNWQpVfEXQd3E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oKfBoNJkuH2zMHvJBxQRRNX4kOaiwKt+KlUIGmFOuPboi+2+6gt4uJOKmgVVHjGHD
	 YoRu1X7cBUs9UCDjy+yolfkEyexV1n+qCFV+60Jymiont6+Gobtacac7k68CFpV0pH
	 n+0Nj0Bdp9C3q5SGZOPz9lqsPBwx+LXfUUXQldQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfDSTfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfDSTfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:35:04 -0400
Subject: Re: [GIT PULL] TTY/Serial fixes for 5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555702504;
        bh=Ah+U9QI6VPsp3O3WOcna320ZjpwDoxmNWQpVfEXQd3E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=boPMf+W90j5DLmdbpVAfYmE5+UY3S7BYXqIWtU8KU0z7sOuk5LH2o73ltZOTVLi+d
         3McKlg9FBl5RV3nRKzVui2W7sLJsxpezaxsQwYt9p7ml+n+IOtt2J7W61JSVMPOgTH
         K2Ra8HZf02TcKxT9iKuhjSxBoU/ljbmfyO9B092I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190419191703.GA4077@kroah.com>
References: <20190419191703.GA4077@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190419191703.GA4077@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.1-rc6
X-PR-Tracked-Commit-Id: c53051128bb0e8754e13345d782ca69e5e1ce36d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55e3a6ba5cced5b07f9a27fb29c9845937999470
Message-Id: <155570250419.26679.127280030697593490.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Apr 2019 19:35:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Apr 2019 21:17:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55e3a6ba5cced5b07f9a27fb29c9845937999470

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
