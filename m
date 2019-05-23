Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A0C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5402175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558624520;
	bh=g18uDpN4wjNgqWZ6HoSbbuJ6T1Hz8FXR2qoD0WcFl0g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dwPaioUW0u5xPsUoAGDkOYRM1m5VSlodQYCdtnVDrG2KikIn057JQYE31PFs7SZ3m
	 y/r0syXlJj9tXWJ3GrugYON0DPDw/4UzYkyedeKBOlfiS6GmgOqIRCXm6SzDcjTr/g
	 s89YTiua2aIa9favax3B5MLJsFF80qzQnaF81/Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfEWPPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730796AbfEWPPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:15:19 -0400
Subject: Re: [GIT PULL] Documentation fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558624518;
        bh=g18uDpN4wjNgqWZ6HoSbbuJ6T1Hz8FXR2qoD0WcFl0g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XbKG0mjszbHIHyRlXMoDmk7qW+q8q5WuHvwXJyiQwwyTGbeOUQaJXaMn5Yu2RtgOo
         zFOJsH/rgjuNVW/4FdglTsIMmqLtQkGMeiqEFc6NwfDHUPjLszzWkjn7zRXHKpLTdn
         zmzPwtJAU4b7KrUwIA/TEF40cWY56ntEBqoUthXk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190523084805.63901c65@lwn.net>
References: <20190523084805.63901c65@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190523084805.63901c65@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.2-fixes
X-PR-Tracked-Commit-Id: a65fd4f0def56f59822b2c49522d36319bc8da8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61686afe1ff378021da4e5509d081fb5196212d5
Message-Id: <155862451883.19073.5953586668759128539.pr-tracker-bot@kernel.org>
Date:   Thu, 23 May 2019 15:15:18 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 May 2019 08:48:05 -0600:

> git://git.lwn.net/linux.git tags/docs-5.2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61686afe1ff378021da4e5509d081fb5196212d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
