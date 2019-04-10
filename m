Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA339C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BCF21741
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554863404;
	bh=2tBf2zXmYVgdNIeAPrkYKYzfaFXJySuWtl9kiv0r5sg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=T9YaIQeIv2L8LqQZP7VsoU2wVT+ohVjpsourwlDOY5tTFIU/54i8xslkv8y5fbJxq
	 jyaT4lUqXlmsyPv7RC55lKU3YGlrPaIrrGKovu2FTGLyXY9Zrp3NW6rclLmgUMKoQ8
	 kaf0T2EgweLEtShK7eY31uDzVFdwIf1VVpCilHTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDJCaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfDJCaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:30:02 -0400
Subject: Re: [git pull] several fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554863401;
        bh=2tBf2zXmYVgdNIeAPrkYKYzfaFXJySuWtl9kiv0r5sg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hUc+TE64myI7quSjNj8aeb32uwJFvXG3ny2PeXPkA4KBF8Kg70CEmQBysGv39KSV5
         R91F+V/7rOeJSU2ipJCXKce+PJg4a4KYmBAQTtuyqD14a9lguYpuZ/HQSEZiUs3WW6
         yVfHasT2nu0NL1KbhgvXwhbHZEkbe/R1uRMjk1kQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190409231203.GP2217@ZenIV.linux.org.uk>
References: <20190409231203.GP2217@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190409231203.GP2217@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 6af1c849dfb1f1d326fbdd157c9bc882b921f450
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 972acfb49446b30a3533ceb5682bf8350c786bc8
Message-Id: <155486340182.26187.5642465156824366525.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Apr 2019 02:30:01 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Apr 2019 00:12:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/972acfb49446b30a3533ceb5682bf8350c786bc8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
