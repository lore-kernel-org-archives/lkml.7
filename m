Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F5FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C379214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564605306;
	bh=ckTmi0QWfObMDroHcYyKuNJqJCI0ICW43anDqxZzDkA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VsdyaubVEnX3UR4dqJTkk7AgZQA4NxDy9yinTkkyQfu9NQNkbEesyYPuTx3Z2B8ds
	 8dFvVTBfFlEj33kPHpLJP05/xkwgEAQsueC+Q4gTgViNyyd52dlEjDZ7AiiVHWJatn
	 9HX4TQAaTjWq2q3o+H/W3k+ZfTmMkNLPIaxWaZhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfGaUfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfGaUfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:35:05 -0400
Subject: Re: [git pull] vfs.git mount_capable() fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564605304;
        bh=ckTmi0QWfObMDroHcYyKuNJqJCI0ICW43anDqxZzDkA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=as23Yu0KJxgDTKcYx4aQJyb3Bp9e8oqMOyLI9niUxLG7ge7yVa8rCfzSwUuszy22t
         ETVL2zn9tcZJEHyaKZjsCBltQoOI5j9ouk+Cm03/sgSbzest6+CN1umlo0zD4J7nH0
         fanbxYhsYgockTTWNv9gH4nEqJua1w5ko4Ga23DM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190731185327.GV1131@ZenIV.linux.org.uk>
References: <20190731185327.GV1131@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190731185327.GV1131@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: c2c44ec20a8496f7a3b3401c092afe96908eced1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c6207539aea8b22490f9569db5aa72ddfd0d486
Message-Id: <156460530413.15680.12944463764728962093.pr-tracker-bot@kernel.org>
Date:   Wed, 31 Jul 2019 20:35:04 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 31 Jul 2019 19:53:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c6207539aea8b22490f9569db5aa72ddfd0d486

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
