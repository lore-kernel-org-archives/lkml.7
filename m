Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F5ACA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA40320867
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572122722;
	bh=JVTgCyPoVOUlh4N4Okl+tzFVT6WSHel3b/WSRpwlhxQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=j4fkPwR51YK5LysONVhDrMAxwiSvXduyrAoBf6AdSDNxvfprN6ZScpW+hLB3OCMOl
	 9qvAu1mFDAafZO9Ga/2GsjBcSeqhM0GIqwEWQzCM7ZlGDRan0Sceq3wmGUVIRLO/fG
	 N+VtRW5VMFQclGpRcuoZvPfXVWPJXg/Rg6cTWRI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfJZUpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 16:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfJZUpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 16:45:07 -0400
Subject: Re: [GIT PULL] Staging driver fix for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572122707;
        bh=JVTgCyPoVOUlh4N4Okl+tzFVT6WSHel3b/WSRpwlhxQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vihVj8Wgw4V3zfkkYgZwHWNv4Yel4y9aAx7C+dqczRiPQ5RbilAKWzIieRdeaKyp+
         2Abi1oguAmY94kX862onhFuINZZGbbdLXhn7AG5hoDzVvvYfwlO30Zo7qm1AKsh4pJ
         x7yE8cbrzsi1dhHLCpEIss311JpBLlV1okQenloc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191026181839.GA649095@kroah.com>
References: <20191026181839.GA649095@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191026181839.GA649095@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.4-rc5
X-PR-Tracked-Commit-Id: 153c5d8191c26165dbbd2646448ca7207f7796d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 228bd6243447f3e5613457e6400112f197dbba7b
Message-Id: <157212270736.6077.14578368699754465120.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Oct 2019 20:45:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Oct 2019 20:18:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/228bd6243447f3e5613457e6400112f197dbba7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
