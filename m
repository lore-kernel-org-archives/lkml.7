Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66820C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 16:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7D42082F
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570983308;
	bh=ReCxrvQyss4Gu9D5Mk/fDAQW+YiAAggUYRtgud9uPG8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vwvj8KZiuPrl6mxjPX6G4gGOl6xzxE17iVGbPsnVij8a6xy0Z/wAlEUpkdY5m2EVf
	 csPm8nSIvdqTizIaPh3ovusbuWPZj1cBEbZOw99I0YESXMFogh67RupFm/Cmq+BiJv
	 Qn3c0sD43sUONrHNr6FSVs4ndrsqj99iKhlH3TFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfJMQPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 12:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbfJMQPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 12:15:06 -0400
Subject: Re: [GIT PULL] hwmon fixes for v5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570983306;
        bh=ReCxrvQyss4Gu9D5Mk/fDAQW+YiAAggUYRtgud9uPG8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wJDDAPEmsF9vIoC0Z+SAyqG9krGU9uo8wkMkFdT0bRkZcj4GxkpR8/AyCiGB+V4kA
         jXaoZBJjfVPxB0JDzGKV7fxJMFR23rG97Jeid3EULAF6iQbGUjqrPsNlWLwRw3ZEEw
         QrAF9kmsItsZeJaF3iKugFoQiDYN9+IzhgcV2WzU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191012220007.1384-1-linux@roeck-us.net>
References: <20191012220007.1384-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191012220007.1384-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.4-rc3
X-PR-Tracked-Commit-Id: 11c943a1a635d2c7141b5b6667ebb521ab4ecd58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2581efa9a47d3c9c349c6d6a2756a16bf69d3f4f
Message-Id: <157098330598.26372.5257048621246308530.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Oct 2019 16:15:05 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 15:00:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2581efa9a47d3c9c349c6d6a2756a16bf69d3f4f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
