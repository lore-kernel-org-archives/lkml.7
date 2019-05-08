Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838B9C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5102221655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557291307;
	bh=zfbtChS4Tesp9Z5jbNV39otVSsdDeK9W5j6JKWIJbyM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lxhDLaDBnfqnPYqh1UliR/5Pqtj4zmHHzMgQFyBpZPvtA/LI4/X4DVfXuRZGV5Jb7
	 1ip64JOvlPfbidRV5fxu9g3GdgW+ArG/z5OunUCun+WtYNAsmPlMfstoJt0bIkwARY
	 EEdPuZub3x3KYCxjNVvTJEF6ZcwZCxuiv9KvdUCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfEHEzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 00:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEHEzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 00:55:04 -0400
Subject: Re: [git pull] vfs.git misc dcache-related stuff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557291303;
        bh=zfbtChS4Tesp9Z5jbNV39otVSsdDeK9W5j6JKWIJbyM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J45pAjk+5g53Q3zWfnxiIujv/+9v5z3sKsnPXnmTWxEq/hYbDpXvMZNHO8bS6EfBf
         HQPmOTJ7T+suHFkigrNbp1tLRtNbVQscDovChoJ+VB2nN5oRolIxQSk92Y91JXBq24
         Ku3sRn9fbIBdl1B4PxfvWKzepmES3AHhJHxWrRh8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507203355.GK23075@ZenIV.linux.org.uk>
References: <20190507203355.GK23075@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507203355.GK23075@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache
X-PR-Tracked-Commit-Id: 795d673af1afae8146ac3070a2d77cfae5287c43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d27fb65bc2389621040e5107baedb94b4cccf641
Message-Id: <155729130339.10324.8169923313968950932.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 04:55:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 21:33:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d27fb65bc2389621040e5107baedb94b4cccf641

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
