Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133C4C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD1B206A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562434807;
	bh=pHqG+3wUkwYmZT8u347ETlONmM+7jjaToqfAVu8hqws=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=E8VfIcSIlI1cG8uhQep8vSxjiMlJsxgNo0KhOkCz8pjRc/EzUyV3mXBtC73H/4H4F
	 zMTma0Dty3zIkvMdSS5tQN7cUoWyNh+I5U9K71c1Nr3kM6FvGYYCFTNU1rXE4B6PGQ
	 kyM58zR76LciBqXy+1qulVrwTUVuBKSrpgSzI990=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfGFRkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 13:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfGFRkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 13:40:03 -0400
Subject: Re: [git pull] fix bogus default y in Kconfig (VALIDATE_FS_PARSER)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562434802;
        bh=pHqG+3wUkwYmZT8u347ETlONmM+7jjaToqfAVu8hqws=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0pdZzJbmQmjONWcCTCA4F0D01yBMOreMo8p0EJF9Ea30LkQ66AUClZQLJkJpKCG/c
         IZjPZ1niWPhotu495g1n6SjxPlOWdv4bPq1nqueXKks9rCBE/V6KW+k82xA6sxS7Yo
         lyfJghIBlmU7LKC31naPh37r2OQw4JuW7UkywLoQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190706030339.GN17978@ZenIV.linux.org.uk>
References: <20190706030339.GN17978@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190706030339.GN17978@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 75f2d86b20bf6aec0392d6dd2ae3ffff26d2ae0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ceacbc0e145e3b27d8b12eecb881f9d87702765a
Message-Id: <156243480229.9000.2527846125338607267.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jul 2019 17:40:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Jul 2019 04:03:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ceacbc0e145e3b27d8b12eecb881f9d87702765a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
