Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F64C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F68821670
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561137925;
	bh=s+pFhknUCfoRccMKXYWMYBVOti38vfdBqntEia1U7gE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bP2Y+et0H/phx7nVtOiDIxzyG2X4vF7dDm8ua6vt0JKahRSobjFqGoq1jmRG2Pohi
	 g6cvkLH5l5fl3Zk8uPK52+m1cnktdQvIuxG9/VwYQX0hrw7HqBBoU5AKYqIOzl06T8
	 qrUmbIE5F7zjdslmOw+48fsmPf+crPRITQBWcwoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfFURZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfFURZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:25:08 -0400
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561137907;
        bh=s+pFhknUCfoRccMKXYWMYBVOti38vfdBqntEia1U7gE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KAdXqD1lNQwPI50WWj0X1tnBTXb+ET7eJsoxyuoX6zJYF0yTTA+YvxFaulJurevbw
         L1Ry1N6FzI/AeBMKWWG98YMaegghv81Q8k/sJbxdXghEfPbeFTZK7zBb/xmOHuQ2H6
         +1KiE4l5ve/9NT0pRZw3B/4w7rppDOA02AH7fvF0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190621081102.GA28012@kroah.com>
References: <20190621081102.GA28012@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190621081102.GA28012@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.2-rc6
X-PR-Tracked-Commit-Id: 9b9410766f5422d1e736783dc0c3a053eefedac4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db54615e21419c3cb4d699a0b0aa16cc44d0e9da
Message-Id: <156113790757.2072.6597337081141849182.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jun 2019 17:25:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jun 2019 10:11:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db54615e21419c3cb4d699a0b0aa16cc44d0e9da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
