Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99103C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6380F2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551981005;
	bh=LyvHknvjjGnJ8EWzulUOkC10zvDsOPpuRo7H8zX6YBk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PgtdVW7iexfnMKoQo1CzQ7Cnkxr9c6Mj72g719Z1t35Zfiv1KeWAWrNXOcv6ro5y2
	 W3XQj3mU4KYRPYoOvIw2IRdCo4CNmTtqlAxQcTbbJNaMRnI0VxCwck7BkRkX0S7DA8
	 IZhnEOenIG/H+6mltnfY42HZA+nxLwk4GoeGqlVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfCGRuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfCGRuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:50:02 -0500
Subject: Re: [GIT PULL] dtype handling cleanup for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551981002;
        bh=LyvHknvjjGnJ8EWzulUOkC10zvDsOPpuRo7H8zX6YBk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PRp+OwRLH2KkfKAukkVkP75bToYU7E9+u5Y9k2JsDqjY2wTEUMeBzivNksxSMJOwf
         cgN4Vr8nfIBpYNBymqTP/Gq4Wpn2gRaXQWrHtylsQ0kFl1txeMYc7JgTAWQcKWahR2
         njpeYwHcVSbFHDls495k76sFgRYgVzL/9OyhddCU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190301150122.GA15145@quack2.suse.cz>
References: <20190301150122.GA15145@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190301150122.GA15145@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 dtype_for_v5.1-rc1
X-PR-Tracked-Commit-Id: e108921894289d7479dae379cc00642802f33326
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b39a07a5e073ba783cd86b60c77044587ddbf8a1
Message-Id: <155198100213.21542.13948868401502257861.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 17:50:02 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Mar 2019 16:01:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git dtype_for_v5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b39a07a5e073ba783cd86b60c77044587ddbf8a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
