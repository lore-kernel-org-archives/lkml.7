Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC1AC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 17:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DB52147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 17:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563730505;
	bh=1GPGEaGke0dKsTYOYDblUqTGsRUnMhuo3+z0FAXbgwI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NIc32sQ138Wv52AJskjDLC0kcyvD7JD0g3MqX8pr/hD3u/0VBo8pyiUmKIlooAuFv
	 zJO3OG7elRpbjQtU29qweAHOBg9tGIanTuqAyNVdBUfoeHAlTDR5juLchEZO6CNu12
	 SBApX/zYr70NfNnSPw080/tickyDqi4anXiE+fTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfGURfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 13:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGURfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 13:35:04 -0400
Subject: Re: [git pull] typo fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563730503;
        bh=1GPGEaGke0dKsTYOYDblUqTGsRUnMhuo3+z0FAXbgwI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EP2JaWNS3OZMgSSqA2lPCectKWtWemnBiUv1bDNx+T8PoTtfAa1IBKo86F9+N6Tmb
         eZrPyOBx5vwBLasfHTYupsBAULq27x7ipzrqaJjx8uzWZsumIQZInXafSA1sxPDfjZ
         oVfI8pt+3KlaqYPYi23wyamZhyrhjjhH2wLxVkYg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190721031957.GE17978@ZenIV.linux.org.uk>
References: <20190721031957.GE17978@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190721031957.GE17978@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: 1b03bc5c116383b8bc099e8d60978c379196a687
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6788eb7d0dcac9ce4084f7b87884812ebf5d941
Message-Id: <156373050354.21043.15252279942285177960.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Jul 2019 17:35:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Jul 2019 04:20:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6788eb7d0dcac9ce4084f7b87884812ebf5d941

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
