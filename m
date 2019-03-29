Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86649C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528B4218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553897722;
	bh=CdRA+zuFcOtK7M9qt2MrgGfcPTBBbuEZOm1Ez2Ayl40=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=X35x+uSP0jNFGUmbD4YB5KB3HsGxa7XV5xQuqHM6EKlQX3s8on2Fyk8qYKBZJntg/
	 7zCaCYx58N54G9XnXS6nyOBNkX8R/WFaYdCAp7+Cwl7r6BOXr2/Xc4AkNN8BMu9/M7
	 M8dtX3B06a56r2b5XmOj1XYJ/ZgNt2hmMRCKXwr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfC2WPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbfC2WPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:15:13 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553897713;
        bh=CdRA+zuFcOtK7M9qt2MrgGfcPTBBbuEZOm1Ez2Ayl40=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BlVHTOSzxcbdlvitKB/mLcaeSjKdzx/eMiIC8OnEA8cgnX9dor0UfzjLR/NA8P1ou
         jnQSpUG0qjHXawzLuUTb+HJi6qxywpHeW/XJRzg2lHvnH9RStW9kJuaq2EZlgBBeI9
         nt4f2l/kRaB3X9euukpZuC/vsyF2kuF2efojP22Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190329193926.GA11564@kroah.com>
References: <20190329193926.GA11564@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190329193926.GA11564@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.1-rc3
X-PR-Tracked-Commit-Id: 0532a1b0d045115521a93acf28f1270df89ad806
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f51092301a42105c5cfcb96033e8734aa1bf160
Message-Id: <155389771308.19616.3417564581056157019.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Mar 2019 22:15:13 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Mar 2019 20:39:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f51092301a42105c5cfcb96033e8734aa1bf160

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
