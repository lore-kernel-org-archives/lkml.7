Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63E3C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAB1214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568297107;
	bh=s0ibCp9hn0V3VfkIKm8f+7paICavmBWtx/BL67NOmxI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=o0vMYjFUfGVTWfe74th3dKmJxCxf4kcoCz+QGrmXZJQRbfZ2r4X9bZXnr1wCDcNgi
	 EGuADL38hPzVkmnUjDvM0Bq4VdeOZlFTo5TKjr5ZNFuDQRwQ/6xATKFsxb0OlO/ZVV
	 pjinqCuIfV9GQFMrdQXsNmc+UojdAns8utRxGiy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbfILOFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732343AbfILOFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:05:06 -0400
Subject: Re: [GIT PULL] clone3 exit signal fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568297106;
        bh=s0ibCp9hn0V3VfkIKm8f+7paICavmBWtx/BL67NOmxI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HZ/47BfmYZubQG/Mt8Oe5Qw5l+NbQTgA45fE1zX1BuSdRlU3E8H6mRYCLzVToidJV
         lmApccf0SXHK3ZrOZ6Fdg9j9JXZGEes5xvVPafe66wSP4wI9j9fKSgrxyTDiY5XrUA
         ROHjMTJRbnDBXdV3wvHaqEayxeUFgbe7qs5Yxz+k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190912134019.2393-1-christian.brauner@ubuntu.com>
References: <20190912134019.2393-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190912134019.2393-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-20190912
X-PR-Tracked-Commit-Id: a0eb9abd8af92d1aa34bc1e24dfbd1ba0bd6a56c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98dcb386e5c3d53da2ed0b14b5930a01c90ad36a
Message-Id: <156829710605.915.1325722993522689009.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Sep 2019 14:05:06 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Sep 2019 15:40:19 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190912

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98dcb386e5c3d53da2ed0b14b5930a01c90ad36a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
