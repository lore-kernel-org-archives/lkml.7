Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5286AC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250192087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557258905;
	bh=5TXhF4k5b5z7dxjp1s+15lqAdf51WBaUwCKIMI2Lj+A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yHPL3yTiwA86D7W7+rCQbHCrh5IFE7tqVTwDfixezo0uyAUUyvPqiV4N/pXXKTzIp
	 kLnYj5oPyOeWh7z01rUqOLAV6CpZgYJshuT0YDdqFVlURnmEamTPb/f0Vjo/hd2Qqg
	 WdtopuOPmSqP/y1V6OwZwu+Y0KPETmQCJvl8Fsdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfEGTzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfEGTzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:55:03 -0400
Subject: Re: [git pull] vfs.git pile 1: ->free_inode() series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557258903;
        bh=5TXhF4k5b5z7dxjp1s+15lqAdf51WBaUwCKIMI2Lj+A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uPlCyZdj7gF6UHMCvVecQTWBxwaB2XrPmvX7S5DOyIHA/K14d5GVv+LrGpo+ssujX
         TG3UAjADZjfyXTQk3y+iYnPqI0QVZPpA9SJTpUCdCCNmdjfzGKQ/dC6qKTYBJDWF+W
         xXiPAHQnJjAOCIHTZVfDgTNWUgVnbJWhhOsXZAZE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507005037.GF23075@ZenIV.linux.org.uk>
References: <20190507005037.GF23075@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507005037.GF23075@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.icache
X-PR-Tracked-Commit-Id: f276ae0dd6d0b5bfbcb51178a63f06dc035f4cc4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 168e153d5ebbdd6a3fa85db1cc4879ed4b7030e0
Message-Id: <155725890311.4809.6872888900903293489.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 19:55:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 01:50:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.icache

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/168e153d5ebbdd6a3fa85db1cc4879ed4b7030e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
