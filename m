Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4007C468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D33208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559941219;
	bh=DEB6rxrxE4Pk007HFmygcb4gQ6NM6zTB9Vt7DEB2APg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nEvJluZH95mGzoOtU4hu5egbK31DHHCVC3Mb5KAEA7LNLx9ey8MF2x+nTD2a686ey
	 aZJCe92KcKaufB592qV8ZRBYcQ7kRjeShm/KSZUOzyyrUz/sUb125Yh0kQCpVuzKcF
	 mo6kWDsvCUDXf4ZcNtGQFH0X4jjUdsR5XfYrryvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfFGVAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730798AbfFGVAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:00:13 -0400
Subject: Re: [GIT PULL] hwmon fixes for hwmon-for-v5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559941213;
        bh=DEB6rxrxE4Pk007HFmygcb4gQ6NM6zTB9Vt7DEB2APg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dmZItiCXVUkLsXLEvA2IKkJ+M/0Hjg4PAsxOXAywX/9HPwh4b7c5Zx8c2kET3pKFP
         JYFKp4x4acC0rlQ7Sm7nb3pTd2bbMDmhjkwdyqqTvH0jXQeBdKiDPgSZY622L04Zlw
         nMnr2b6ir+ZUKEqxobVdtxtOYCs0bThSIKcDEu5Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1559938508-12610-1-git-send-email-linux@roeck-us.net>
References: <1559938508-12610-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1559938508-12610-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.2-rc4
X-PR-Tracked-Commit-Id: 4a60570dce658e3f8885bbcf852430b99f65aca5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4425649c63018e96e5402807c9e7bc5272f7b3b
Message-Id: <155994121319.4194.15465585918583975195.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jun 2019 21:00:13 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  7 Jun 2019 13:15:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4425649c63018e96e5402807c9e7bc5272f7b3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
