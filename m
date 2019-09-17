Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E59C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C281621A4C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568763645;
	bh=zMgUodvDhzGoajpg/NeLC4oka14CdB41NmzKPrId6IM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UzfuZoF6YjibkIFvzeHdqWwY2BsP3s7B4q3khCEAhc/RM0dFocE5mcQnSAMkSNEEg
	 cqN/UaPX6JrvXmSxzWoLPk137fQ2FAoUIOsLVQP34dwXnV7D9NN5vNA2PZTkMfil2E
	 dZjWqESfRZ0k0gb2KHjOD1F+0Yd9ct1vM4geLhM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfIQXkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 19:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbfIQXkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:40:23 -0400
Subject: Re: [GIT PULL] s390 patches for the 5.4 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568763623;
        bh=zMgUodvDhzGoajpg/NeLC4oka14CdB41NmzKPrId6IM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o6IUS138UCEqvVKvLg4M71pl8KvoD8Bh+6cBkVx+Y0CwAJIfuffpGsOvluYXwEAV0
         kWCTwmTXCKG5KkT1zm1eDB27lfxgdhffAeiYz2Me6RFLtvZc62LTfLsNXDW44FOiGW
         p/Qg54nB3QU/1Y4N4cVxKnkE7MGm8sCR09CclZSg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01568730434-ext-0126@work.hours>
References: <your-ad-here.call-01568730434-ext-0126@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01568730434-ext-0126@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-1
X-PR-Tracked-Commit-Id: 2735913c1079b7dd7ec1d746c13a84ec1b5ea276
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d590284419b1d7cc2dc646e9bdde4da19061cf0f
Message-Id: <156876362346.26432.3024890958497889434.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 23:40:23 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 16:27:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d590284419b1d7cc2dc646e9bdde4da19061cf0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
