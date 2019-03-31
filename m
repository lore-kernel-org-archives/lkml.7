Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D5DC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C3F218FC
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554048013;
	bh=r+xpHKTTNPY4LD/dxGMO0c7McJxADWgnRuiypQZ6/x0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dgEE2jlSc+q+P/sU3SueJBmCx6j9WdQVHKUjIUlZ405b5f9Z+pC3fzpXOybYIOFNz
	 zG7G6mGE7s+7tcdYvBkUHlF4j2TCco+1aQCDyAx8nz9bsgOqJjoVYbCzVKCXnktFdD
	 KSYjQ0DIvUOikCgliPLdH9MQrMohTnHFPo9rLscM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbfCaQAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 12:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731177AbfCaQAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 12:00:11 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-4 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554048011;
        bh=r+xpHKTTNPY4LD/dxGMO0c7McJxADWgnRuiypQZ6/x0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qLLvrO1R0Up/8bxmNDWYfRVu0YI6fUTbx9lQMs16UrNPhQ/pwvNk5I/er/2zI1yVZ
         03nnU+c21MoELo2OTleBdSdIpAufoDhEl1oCL20aMt3JlEw6rMJOTVhgSbWh7kaZAN
         kCo3HcDGP7VpP5texHl2rsTProShkhKUhcLftvXs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pnq7l4qn.fsf@concordia.ellerman.id.au>
References: <87pnq7l4qn.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pnq7l4qn.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.1-4
X-PR-Tracked-Commit-Id: 6f845ebec2706841d15831fab3ffffcfd9e676fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6536c5f2c8cf79db0d37e79afcdb227dc854509c
Message-Id: <155404801095.15219.13272374496717031850.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Mar 2019 16:00:10 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ego@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mahesh@linux.vnet.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 Mar 2019 21:26:08 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6536c5f2c8cf79db0d37e79afcdb227dc854509c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
