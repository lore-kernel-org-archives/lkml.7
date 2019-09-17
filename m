Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8128C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2DB206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568763637;
	bh=m4VZQRJNxhNh/vWBR0nZ19WBq20PaY34jKQbmAf8Ocw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hLQxK5L5ED/9ozBBQzf7RW4CJBH2D34bprqoGoGinYL/GxwIlvevN2SzJ8Nk3KFr8
	 pS0+pGfmRLBH7dTgrmvmdCAHtVa9he9EGOlcuoq1UhFzQqsW7nJdGBgwBhS4d+twKv
	 Jq+nvbNt2AnaaFZoKxkoXM2R60eoOvoLD13ZJlfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfIQXkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 19:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbfIQXkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:40:25 -0400
Subject: Re: [GIT PULL] percpu changes for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568763624;
        bh=m4VZQRJNxhNh/vWBR0nZ19WBq20PaY34jKQbmAf8Ocw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=i4VgHBmhPkcz7n56J4J8dL6eFOCQXwVCEWqMnF9LfWld9a6ZDs5R7Y0FLWlwtfa1t
         M+1gEaz/1IBkMP3Dusw5rWjCbhqM9Vdaktt8WYynuip3bHoA49/KeDu5D4bxJVjtg7
         /y0GjRB00sGRmYb12o+2LJGg0O6uKewID7NrIhpU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190917164300.GA77280@dennisz-mbp.dhcp.thefacebook.com>
References: <20190917164300.GA77280@dennisz-mbp.dhcp.thefacebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190917164300.GA77280@dennisz-mbp.dhcp.thefacebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.4
X-PR-Tracked-Commit-Id: 14d3761245551bdfc516abd8214a9f76bfd51435
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1902314157b19754e0ff25b44527654847cfd127
Message-Id: <156876362478.26432.1158576179751599537.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 23:40:24 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 17:43:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1902314157b19754e0ff25b44527654847cfd127

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
