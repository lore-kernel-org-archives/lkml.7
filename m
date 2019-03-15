Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9296C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84CC218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552686326;
	bh=+zNs4mlNXc8DUokN0jqv2cMNXWPr0QtluzrbJis5wGQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kSfN3BdQyek+l6g502H+CE+yzfv0JJcO6KSh8DWoSaMo9s3vqgUpXppQNhOQ2iUqn
	 SueD0QCkzOnIPI4AIclNEUxrwi1ALh5YOTh+kZB7AYqwiwgqaupkYj9FZXAaKRwS4l
	 YZY3B6lBefnC9ILKryd7oX/2gZFnEEddbStZcqDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfCOVpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfCOVpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:45:22 -0400
Subject: Re: [GIT PULL] xfs: minor cleanups for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552686321;
        bh=+zNs4mlNXc8DUokN0jqv2cMNXWPr0QtluzrbJis5wGQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kUySrZByJ1rwhwsvWuwwfVZPXaqtKxl3UZ/orsS861y8DP4FtOs6wmWu1M0vRqGmU
         Lqp11DgtWFOhfHE2mx5UP9dvIvrmUPMl/zQ/TcqI82WnrRISgVnJl+QDvoaoq05oFO
         TIsTEgtbwQBpYrQao8hAQ2lPDsGW80v0hoQ6Anl4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190315160706.GI4929@magnolia>
References: <20190315160706.GI4929@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190315160706.GI4929@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.1-merge-5
X-PR-Tracked-Commit-Id: 6ef50fe9afae63d11220f3f66b5f4c75d09c8bf0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de578188ed0161713c9515eeafa394296516ff27
Message-Id: <155268632152.16247.17715679919899654983.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Mar 2019 21:45:21 +0000
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     torvalds@linux-foundation.org, Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Mar 2019 09:07:06 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.1-merge-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de578188ed0161713c9515eeafa394296516ff27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
