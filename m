Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D9BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A13F20854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551981035;
	bh=Y4vOI+FKSqyyOh2nPZCqvMJ0PnED+nN2WGVFne2HkoM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pSQipQTPIxpi9/7RJk3H9nQz9qyyWZgimf44p1BAmd6I0fY9CP5az98iUwyUe5GmW
	 UQdUYqLi1NLh4tXUy6s+8CY9ktGuYUelohW69Z5x02Mr2c7Me91JJTVpq1cGj5HMHe
	 PeYdwd/ImQMTudUZCLMKqga3jb6YbFRQiTCHoYvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCGRuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:50:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfCGRuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:50:18 -0500
Subject: Re: [GIT PULL] xfs: new features for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551981018;
        bh=Y4vOI+FKSqyyOh2nPZCqvMJ0PnED+nN2WGVFne2HkoM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=B/+eHirnLznLAoy1f2P7vLas8PDAqzJIDHLOVbSv9wKQWpO6aqAbYTU10zgRiHybe
         JwF00QsNR14rdxGIB4C5uqMQHwujpWRLtmVcpj23nmmdVGEuGoPt63vIRNss6HGd+A
         mjp137K8X+VAiIhdupqd2bEEnTA9mEYYrzY5j434=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307165441.GA20533@magnolia>
References: <20190307165441.GA20533@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307165441.GA20533@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.1-merge-4
X-PR-Tracked-Commit-Id: 1b9598c8fb9965fff901c4caa21fed9644c34df3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e1fd794cb6bf813a40849a1fc236703bdcbc1a7
Message-Id: <155198101824.21542.270770516129363172.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 17:50:18 +0000
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     torvalds@linux-foundation.org, Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Mar 2019 08:54:41 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.1-merge-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e1fd794cb6bf813a40849a1fc236703bdcbc1a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
