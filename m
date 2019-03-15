Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C607FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBF320657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552686332;
	bh=6JcMij6CTVmnxH8AUo2pieE4xDA9YrMzxj5uFbzeYdU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bkukSJ6Z9COS8Kz4GI54oruimoJcpts+xxhLnPmuAg5jIuJsdLFuWcu10P6NpBSif
	 Nbyz5qdROXR8BoYR20dY2dK9fySfvPfHzValjYxorvJLtm9SqA+/Q3qz1/YUP5Xmjr
	 0gt+N36i4T5jNlWuP1BV1Q/uoU9gUIoFYvmOYzwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfCOVpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfCOVpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:45:22 -0400
Subject: Re: [GIT PULL] NTB bug fixes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552686322;
        bh=6JcMij6CTVmnxH8AUo2pieE4xDA9YrMzxj5uFbzeYdU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cg/2atoM8jTb/aTScGp7N8YhqrhuD9dlaxJaG3UNJIbJVLpCuQgilbYuYOxE5UTmv
         KxaIBoma2R3fWIQm0yB92ab+x7+iUfqh48j/1AAqxBMo6QHBWkZlOKYduS8kaZvYV5
         BXt79gVB6PCOZzN86xPqRaAhXVeYvDr1vlhn3F8k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190315202609.GA30826@graymalkin.kudzu.us>
References: <20190315202609.GA30826@graymalkin.kudzu.us>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190315202609.GA30826@graymalkin.kudzu.us>
X-PR-Tracked-Remote: git://github.com/jonmason/ntb tags/ntb-5.1
X-PR-Tracked-Commit-Id: ebb09b33c60c46fd4f7ffa0af9e693eebe765d1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8a71a38668919c53e6ca9dd1bfa977e5690523f
Message-Id: <155268632245.16247.17574634127221898364.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Mar 2019 21:45:22 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Mar 2019 16:26:09 -0400:

> git://github.com/jonmason/ntb tags/ntb-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8a71a38668919c53e6ca9dd1bfa977e5690523f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
