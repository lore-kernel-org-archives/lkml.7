Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC1DC73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5425421655
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563150621;
	bh=ShejkeLF6lCFtEkBsQAxiOpZfWyxT6RFvGykJxV/Eyc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=m+TgYtjKZ1EfdZdbxX0YOOK19Y4Z3c+HlnA21yTTooFIKTRryDKahqDf2iM0/LV/t
	 xBBm4ZA+RLNuII1ibSUlJeSm4ELJwvWssiORl1RiVdeC07IAJiqL8n5MyYeMco79no
	 fAQdqTw/GWn8AkOAl/PjxKMWYUyiUTvVP31hdheY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfGOAaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729104AbfGOAaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:30:18 -0400
Subject: Re: [GIT PULL] UBIFS changes for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563150618;
        bh=ShejkeLF6lCFtEkBsQAxiOpZfWyxT6RFvGykJxV/Eyc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TpgdE9e73UKQuaSVJP13cmM/01SzDP/+CMbbpGYyERDVApU7a+/1mOpbH1hlFZCEb
         A6rTnqBN3fQFNP9ktgsc0Mul3w41aTgdPMddERqXsWD2FfmPFbdjV/MeaCXpnuCghq
         ooTZ6oQMZ/wVgyGHWGPR53cjEuJ2OBkhcdMJjZe8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1267151613.38686.1563130929727.JavaMail.zimbra@nod.at>
References: <1267151613.38686.1563130929727.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1267151613.38686.1563130929727.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git
 tags/upstream-5.3-rc1
X-PR-Tracked-Commit-Id: 8009ce956c3d28022af6b122e50213ad830fc902
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a318423b61e8c67aa5c0a428540c58439a20baac
Message-Id: <156315061806.32091.17822041540808146049.pr-tracker-bot@kernel.org>
Date:   Mon, 15 Jul 2019 00:30:18 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Jul 2019 21:02:09 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/upstream-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a318423b61e8c67aa5c0a428540c58439a20baac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
