Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE882C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 02:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6C120862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 02:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557972323;
	bh=ZC47oQbJxACEg8kE2f1zW/9NCJCZxVWJQmwaR8LT9lk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yELdnccqHNOCp358rHFDwy8GUKqLlXXTcV1yxPMHY/y3nGyng5x1tOdGxiZ6pmS5u
	 S0FkNy/zDKjQhMZSHaH8Fq23HDWuHPk0nsGyh5b8Hp6R5jj8i0wUVeb3FsuTxvF2tk
	 C3tCkDxAMd3bJndmQJyWYwEwj7eB1jxTWKHRaITI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfEPCFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 22:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfEPCFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 22:05:18 -0400
Subject: Re: [GIT PULL] power-supply changes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557972317;
        bh=ZC47oQbJxACEg8kE2f1zW/9NCJCZxVWJQmwaR8LT9lk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1cH7HTjXOOEcs8/+22o7EF6H7eYXmGOtSqzBNZOE1/cDh2+Dr/tBNsWYRF5l9WSTV
         yE6AvoP018Xdge5yPTR1PUk1xtGTwvT4hHnqaq5qGN9TWlW5nRJiObVR2kWuRdFVmn
         XSOqJAqfW4WQyjksEMrQPvNTMbfD+2HXqIQXtmW8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190515193500.6wpstcuacfuwt6ty@earth.universe>
References: <20190515193500.6wpstcuacfuwt6ty@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190515193500.6wpstcuacfuwt6ty@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 tags/for-v5.2
X-PR-Tracked-Commit-Id: baf5964ecfe19a0109fe2e497e72840ce0f488e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8649efb2f8750dcabff018a27784bab4ecb9f88f
Message-Id: <155797231756.20425.16903778798719708973.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 02:05:17 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 May 2019 21:35:00 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8649efb2f8750dcabff018a27784bab4ecb9f88f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
