Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A370C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282442087B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555788318;
	bh=fe+DshOEL7bok0OG58X7QSj/We9GwiTZy0aLiKQRnjk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bJfe9DFenkCk/8deI8LiIWpa1GKW9M1+CrpKBYyQxjLKsv3Jh5ueR/XPlg/LZUvnx
	 hjSyxfn/CIaGkrfTjJPC5Krv+eqmRuUH9IwQrIusy44nOK8ugsCZfs1T2q0iI+ivT9
	 q6vqjqYvHGmEV/Iy9tDmlaMSOsvp73EB90kMJhRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfDTTZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 15:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbfDTTZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 15:25:07 -0400
Subject: Re: [GIT PULL] i3c: Fixes for 5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555788307;
        bh=fe+DshOEL7bok0OG58X7QSj/We9GwiTZy0aLiKQRnjk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cq/fYQDmLlAnJV1vD1gnR0zr1L7H6sB/UbL37cA8EDs/YUkf96L8jl2D8cpZlaJgL
         SxbCIrOwiyghf5EVo7H7jpmodGUvNL/v/2ss3hQx4JwIC9ozjF3LWu+eJYa3ZlbOf8
         N6OiNPfuGu+9K7a5GvAsOITab+2lPmofuY9MkCVo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190420112340.24be3932@collabora.com>
References: <20190420112340.24be3932@collabora.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190420112340.24be3932@collabora.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git
 tags/i3c/fixes-for-5.1-rc6
X-PR-Tracked-Commit-Id: 709a53e1948494cc4f6c4636c6f84a4d36a8117e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34396bdfd2b7b41b9dcd2126eb1a57e43fe13368
Message-Id: <155578830696.28386.5913538916509943220.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Apr 2019 19:25:06 +0000
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Apr 2019 11:23:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/fixes-for-5.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34396bdfd2b7b41b9dcd2126eb1a57e43fe13368

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
