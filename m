Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4F1C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C5921734
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565465410;
	bh=NlH8zRqvOHFDhA01nuO2JV4+RDVqxAoHCLt841HagGc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kLGHqbASw5FTzQLL7ivMg926czbPJDEr+RQG2LmhV4lBcGTnrTt3FXifXJ0iXyWVK
	 EBp22FfweUJXzSIL8pfsPFTuDwMgPcAtq0bBmsGU3nzSC6jIvz2IdQ3SQIXJErq5g6
	 aCjl+JTDpclVe8LoKiG58SFz55EexktH74CcgyFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfHJTaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 15:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfHJTaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:30:08 -0400
Subject: Re: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565465407;
        bh=NlH8zRqvOHFDhA01nuO2JV4+RDVqxAoHCLt841HagGc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AyiYsLJMbbOltPlefX6d0WnfiFoLF46gVBbjzBrUPUKdEt7b8QU1wRLOE+LfyeFbJ
         iYf8LMhcRYqOdPAjUTDq8rpQ/TNTsznimhf1PQ4fAt9sa/qXSG1/V6Y37XdWS+mWPh
         eYshgl4aZOL7+DRUfKkM6jwhcNEPkUV5T6BmXqxs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190810041610.GA27921@embeddedor>
References: <20190810041610.GA27921@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190810041610.GA27921@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
 tags/Wimplicit-fallthrough-5.3-rc4
X-PR-Tracked-Commit-Id: 1f7585f30a3af595ac07f610b807c738c9e3baab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf1881cf484dd96a97606a804553019f8f08f0d4
Message-Id: <156546540774.17840.1309326139320334743.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 19:30:07 +0000
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Aug 2019 23:16:10 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf1881cf484dd96a97606a804553019f8f08f0d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
