Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95650C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6408D2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551757212;
	bh=Zu5d60VVUNS9cy95LPUFOYFcj8hr82ExmcTuH84RggU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xfqdSuMHz0lPTbKxsjz4U0DWPTmzAM8xbcxTvtUm0AeUuWgXMgGptVmZY/bS8CAHN
	 +GK3L7d5Ul7DSPI91hhnDKdv29hLzOReKYSqZph2Qc8Bm/8+73u5eEj1SuCFrzkJnR
	 i6S0tx+qlo2ULPDqDTqtsjQ2Ggh4U6NAgaUXIYTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfCEDkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbfCEDkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:40:07 -0500
Subject: Re: [GIT PULL] LED updates for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551757206;
        bh=Zu5d60VVUNS9cy95LPUFOYFcj8hr82ExmcTuH84RggU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XvEC3Ck2zsf0edaxUog2+WofAB0f4zL7DAljkHfbVzNU9v/Ff+pcjkrxcEl69uJNA
         E/ArfwS6SQFbKKcgO2jY4zGJ+06UeDIkNv0QBVvAcATJUk6SAKdFQLBsBjqJHfAJS0
         q9xydzK7/bFXgj/HCxHB1d60ElhR57m3fLy+xniM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190304201110.3969-1-jacek.anaszewski@gmail.com>
References: <20190304201110.3969-1-jacek.anaszewski@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190304201110.3969-1-jacek.anaszewski@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git
 tags/leds-for-5.1-rc1
X-PR-Tracked-Commit-Id: 5ddb0869bfc1bca6cfc592c74c64a026f936638c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd2a3bf02625ffad02a6b9f7df758ee36cf12769
Message-Id: <155175720681.14960.7491361896849133808.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 03:40:06 +0000
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        krzk@kernel.org, michal@plume.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  4 Mar 2019 21:11:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/leds-for-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd2a3bf02625ffad02a6b9f7df758ee36cf12769

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
