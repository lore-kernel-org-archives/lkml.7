Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA788C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7816C27977
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559493015;
	bh=6W77K+1VaWvd0yLr/qilBdyMSapl3CYKLiCE25hMx/g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2MyhRuk3GY9yjdAyOaZINiradPUfWGFdV/x6YDLz9Ucmuj6ukWfQHs0G2hP4y14cx
	 trZn3kOMv8n1qkeVi+P4xo66z6Fk/VyrDzXq3fSWMtapvr8ViTRAK47sTJoxFlICFf
	 5zaYY9krsyG2U+v0D6pJoD75kOg/MuKx7yJXDqGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfFBQaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfFBQaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:30:14 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559493013;
        bh=6W77K+1VaWvd0yLr/qilBdyMSapl3CYKLiCE25hMx/g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v5+dnaqYZ/r5LrYNEdjKWGbTr833n941AdsELZJv/K9YLxRrD5yTz6Y0Ts/g8VeuK
         mxi3QQACXS/tLomrpN8lBAa2Q3wEhFIu9QBF8CfmBfDqlfPeu0l42g5mjkduqDfOkw
         XYHBgJWGDwJ5NqHS6hS7vJxrQEE8Ko0IABEA+KmM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1559389512.2947.33.camel@HansenPartnership.com>
References: <1559389512.2947.33.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1559389512.2947.33.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 3b0541791453fbe7f42867e310e0c9eb6295364d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1975b337ce26b53814f1b5c55b260649a7115393
Message-Id: <155949301355.9110.2753867128424458270.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jun 2019 16:30:13 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 01 Jun 2019 14:45:12 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1975b337ce26b53814f1b5c55b260649a7115393

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
