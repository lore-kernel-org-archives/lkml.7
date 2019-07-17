Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B32C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80037217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563329120;
	bh=r2biLWcV/MUJfDx+umyXdZL9idi3RpzmDneI8QG2YYg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2A+fIdH7LVPKdXTz8t91TXK5eVOx5wwnuSb3EHOVOlsRq0u25oJr7wzsGHjCB5xfS
	 D+eUFUyAgTVEVHWIuGrwCPais9vsAaSlTK0W+EoQ4CBFjwAr/ugNUCGwFVoi7pjbCp
	 W6XXgvZtMI9rFJgVgUyGMaV2GLHQWivuNN5iMOJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfGQCFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 22:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfGQCFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 22:05:19 -0400
Subject: Re: [GIT PULL] Btrfs updates for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563329118;
        bh=r2biLWcV/MUJfDx+umyXdZL9idi3RpzmDneI8QG2YYg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1S4HfSYYdGBDgvf52xiAHbLOY1lwen94g2zA7uvaBMTmtbg0fmwWAEL5LMwRTVLOW
         43NQYSHqnyMvcH0Bpw5XhhiFO5B9H7gCwBRBA7z1ff7ycGSrwz5Yn8viMvHp/pIqAf
         M0wYxoZS+nqJBhTdtLIYKyqiLSa4BypW2F13U8mc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1563178381.git.dsterba@suse.com>
References: <cover.1563178381.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1563178381.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.3-tag
X-PR-Tracked-Commit-Id: e02d48eaaed77f6c36916a7aa65c451e1f9d9aab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a18f8775419d3df282dd83efdb51c5a64d092f31
Message-Id: <156332911856.16657.15152227893053261337.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jul 2019 02:05:18 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Jul 2019 10:57:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a18f8775419d3df282dd83efdb51c5a64d092f31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
