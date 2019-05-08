Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C6FC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB6E21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557291311;
	bh=t20W/ZrKJ9ZjuMlDVudi+Fy/P+J0pTP+WyTUuw7OmZg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mYol1aBYNGppDFnQZc4S8aJHzkjZuw3swnVe5uPxa3OVwSxXIC5EAURdbu1nhVppV
	 7fKgNaS44RIWpxj3vslZ01siAFgsSw7V5grnNcp8LSpEsHc3daPX2Tu9pouxBIMOlT
	 1kUPWrYlU840n1v08oo8hkE0HZgzYNW9qDfTZkvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfEHEzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 00:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfEHEzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 00:55:06 -0400
Subject: Re: [git pull] vfs.git several struct file-related pieces
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557291305;
        bh=t20W/ZrKJ9ZjuMlDVudi+Fy/P+J0pTP+WyTUuw7OmZg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z5qSibKI3A+c4lT2AAVOsT1IPwW2WFdCPy3XqwGTwopP0f67qt7vkt/kKhBMwdmwx
         L8cppsh0O1jDv2O9IH+FpLf6nzZNhOAw1EZkjPXeGSL0fcJ9jQQRRKUTY8JD8w7fU9
         FAxDXK7zrq/uXU7WavmnduX2pZRsxZidmeFvvyMs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507205209.GM23075@ZenIV.linux.org.uk>
References: <20190507205209.GM23075@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507205209.GM23075@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.file
X-PR-Tracked-Commit-Id: 3b85d3028e2a0f95a8425fbfa54a04056b7cbc91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d897166d8598e362a31d79dfd9a1e2eedb9ac85c
Message-Id: <155729130574.10324.14228101879148424298.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 04:55:05 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 21:52:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.file

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d897166d8598e362a31d79dfd9a1e2eedb9ac85c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
