Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8217CFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E372178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573249808;
	bh=3MWfVzAWtHSbHtYeIurV1U5+Uy/NteCZuDPgeJ8Ih7w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=M2NbhcbuaGKino2isWoTrd3e0ekTguZ7o15S7gHiuNi3aob8vHBRaECuMR7gC03+2
	 d5Uznkk/hM3dIG0e9X/leTpRJU/826oSIxeRRryWcQPad9lOwp8JJbcedWSHIVX7y4
	 pmhc7DJQjf64BZfbu6zYa4JvyN31Kxz/WRLiGu0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfKHVuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:50:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfKHVuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:50:06 -0500
Subject: Re: [GIT PULL] pwm: Fixes for v5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573249805;
        bh=3MWfVzAWtHSbHtYeIurV1U5+Uy/NteCZuDPgeJ8Ih7w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pOUagQBhgxEFJ4J1u+2oZJq/t51Ry1NsKrbQkK727tlcUC0QS3ubqh8rZFnTq7+r3
         HkXiKml7XFZafVgLAZW22twcNUCoFPkkZy80ygXegsip9M5JTR7m+F17DkGBaIPMaF
         xar/sxe0r8TkPQSVWCsmhHl8/EOoR+tCvnoa58R0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191108174220.3384630-1-thierry.reding@gmail.com>
References: <20191108174220.3384630-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191108174220.3384630-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 tags/pwm/for-5.4-rc7
X-PR-Tracked-Commit-Id: 24906a41eecb73d51974ade0847c21e429beec60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abf6c39796f9cccd0d258d05f2fa39a8c77eabc2
Message-Id: <157324980579.30145.5785182358604306565.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Nov 2019 21:50:05 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  8 Nov 2019 18:42:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abf6c39796f9cccd0d258d05f2fa39a8c77eabc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
