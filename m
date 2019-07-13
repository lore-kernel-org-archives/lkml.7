Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABC7C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09581217D6
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562977805;
	bh=iJbSToUKeVYGNujDmnFLtUwMKQq+JLbjdgAreetA7s0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EcV2CPPGTjsXryoKiDsG8DvyenL1hBS9kVx/IHZ07dqQm8vtlx7fzlGYOcsaDJXT1
	 4fjNXx/hxj4k4cH1zMXtn7zp6kDbi7Ftw0c/7lsPEZZpe6mKAolmQkvjL6mMMVHx+W
	 jY1TqdenBO3RmNxKkCOK7CRcREpmQQcvszHlBvlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfGMAaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 20:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfGMAaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 20:30:03 -0400
Subject: Re: [GIT PULL] vfs: standardize parameter checking for
 SETFLAGS/FSSETXATTR ioctls
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562977802;
        bh=iJbSToUKeVYGNujDmnFLtUwMKQq+JLbjdgAreetA7s0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lOZr7A+dZnT0PMtb2rXLyPCdO+SwOB5lZ92s0flb/WbGU18CxJZjJUqXjOoniJH11
         ajIEAS1i1x8CjvYZW+ZZetSPpYNb6UDdeJneEseTK/zcqcBX4bhvKUEkMUaiuOjdC1
         agBPmUihym+eQoWJIBnR0nRnebu/v4pjRsg7Sd9o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190711141825.GV1404256@magnolia>
References: <20190711141825.GV1404256@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190711141825.GV1404256@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/vfs-fix-ioctl-checking-3
X-PR-Tracked-Commit-Id: dbc77f31e58b2902a5e7643761c04bf69f57a32a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5010fe9f095414b959fd6fda63986dc90fd0c419
Message-Id: <156297780234.21817.9681885311019311111.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 00:30:02 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 07:18:25 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-fix-ioctl-checking-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5010fe9f095414b959fd6fda63986dc90fd0c419

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
