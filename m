Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AA8CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 18:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8443421726
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 18:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572719711;
	bh=6BpNr/Ny4hulh8/+VgASThA3hdTUg8jK293lHYrKiRE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Nhb/O9SrtyiHNMSWvP/0Eqz8Mt8wUNcqcJ5YogRCpY5Y1l3uSUWPCaEi1T4LhKRZD
	 PAE6om89AhtJXNiEiboneFK/RIpn4BO4Xn8I6diOgKT96B2CbxVDV6yFuQyLSpigDy
	 3YjAhKIjz6lNH6HwPjmD64db8fLfmSt7FAIjZ1uQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfKBSfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 14:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbfKBSfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 14:35:07 -0400
Subject: Re: [GIT PULL] hwmon fixes for v5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572719707;
        bh=6BpNr/Ny4hulh8/+VgASThA3hdTUg8jK293lHYrKiRE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Eoxm44fApgUa9dKFeSzs5Z4Hn1lPxZEj+uQV5nkA/9tsuA8EaApcSePAWi5wymsnF
         Ruc8U4P5WTWhehRIAKslPTYsTiXLTGmGSUckQoUM801jhLZsUotBW/T3YT1zA8zRkx
         TnLSG8sM7SmymbykfA2Z/yH7tDEhuxHqKkrCVz2o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191102145843.16952-1-linux@roeck-us.net>
References: <20191102145843.16952-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191102145843.16952-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.4-rc6
X-PR-Tracked-Commit-Id: 2ccb4f16d013a0954459061d38172b1c53553ba6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d2345057538bb97b1e556508ad69983f446462f
Message-Id: <157271970731.32009.14595168486312654641.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Nov 2019 18:35:07 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  2 Nov 2019 07:58:43 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d2345057538bb97b1e556508ad69983f446462f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
