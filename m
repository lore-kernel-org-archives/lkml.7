Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE2DC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E0F21880
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563565508;
	bh=Ypz6jX1jEzGgR897Ju6gxmv2Qja2BQFov1h6buNFcPY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MsztjoISk/1yRVEXMu/u/e6Wf0eVn/H7+p+yEpDPQ5vWQoN1sXBuBetHmGgrHgbnS
	 +auEbU/W+gKOz94vWxbf6j/TGBfp1wOyzPFvz5ZnRdLwaIqHqHKnPDBpF8ruM7rEiy
	 Ksews8l2G63BzhYUNr72KfFaRycbtz1dfm/rpF4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbfGSTpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 15:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733223AbfGSTpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:45:05 -0400
Subject: Re: [git pull] vfs.git adfs patches
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563565504;
        bh=Ypz6jX1jEzGgR897Ju6gxmv2Qja2BQFov1h6buNFcPY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Hy6JMGHoF/ViYGzu4kvYvt88mMSTnAB/4yr2CygBQgAgKnInOjpHfe5qNdXaG/VE/
         gcXu3KpHsj2KXjiHtAri51sKi1xTxUmK3N5oKexpxhfPNHnUj2ATw9zhW5sqsFXXO1
         91ezXLaskKP0M6xKNekT3BtAdeKnP8BZXLX8M2sI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190719034515.GY17978@ZenIV.linux.org.uk>
References: <20190719034515.GY17978@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190719034515.GY17978@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.adfs
X-PR-Tracked-Commit-Id: b4ed8f75c82876342b3399942427392ba5f3bbb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2fbf4b6d585e40f2369675148777abce3abd0e7
Message-Id: <156356550474.25668.5373874192594090281.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jul 2019 19:45:04 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jul 2019 04:45:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.adfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2fbf4b6d585e40f2369675148777abce3abd0e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
