Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEEDC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194E120989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557440122;
	bh=BQobdt6CAD9lHDDvfoBIYnw9dhCRJcfjmwNu8OSy7H0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iTZcTiV6qfb81X/x0JkhofKrE9P1Z0ofqTKTgfXvGZ99sD7fLJwzAwsHiYDf84F+8
	 rySZzO87vmUA3NtJxkK5VBq73bId4eg+OR78PONW/dpGfuwlW7dkwRgCxKunQ4EIlk
	 GDHkWohsEm0cVFMBIp7VuZCYIlQGp0p1WttOvlJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfEIWPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 18:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727294AbfEIWPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 18:15:19 -0400
Subject: Re: [GIT] Sparc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557440118;
        bh=BQobdt6CAD9lHDDvfoBIYnw9dhCRJcfjmwNu8OSy7H0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EXm7cFQscv9XNdTN1QC/UXcNAZ0arl270HZbyz2WX8Zo2BgR2NQ97BC65HGAzeSOw
         rjVgYi0OuJjy6MjPjO4sZvD/ESf5AYQWqdSO4I7UHhrpKORVoBOtOfznYgiPfNGn6B
         KKJvLoftmattMJ60YMEv/3VRlDNGcqjnqHO6TuC8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190509.143531.499657137828123463.davem@davemloft.net>
References: <20190509.143531.499657137828123463.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190509.143531.499657137828123463.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git
 refs/heads/master
X-PR-Tracked-Commit-Id: f4d9a23d3dad0252f375901bf4ff6523a2c97241
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b6c9e96f941c5ab13dad7278a3622f58e5672fc
Message-Id: <155744011853.23477.16345216067726345740.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 22:15:18 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 09 May 2019 14:35:31 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b6c9e96f941c5ab13dad7278a3622f58e5672fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
