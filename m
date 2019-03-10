Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADBDC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 01:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB022081B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552182018;
	bh=5952Len6JdIc9hD45tdMyV51iMR+Hg5atfwVnkdu8zw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CKsnB47jQsQyYoT+1uHsstCWpMmRUJ0KgC3UeYskzBZs51BbI+uwqeOfXd+th/ip3
	 bxEsUHQLh/eui33uO9jdBegIm+3jN3rPP7pLDfDF11CsQDEQmaiY7JHSBHYeb8CIsa
	 cWGFfCEK46UPacbjnqkNKMq5VSK4p/cQm7Xiohsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfCJBkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 20:40:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfCJBkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 20:40:16 -0500
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.0+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552182015;
        bh=5952Len6JdIc9hD45tdMyV51iMR+Hg5atfwVnkdu8zw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=q/aEB7qc5yqroRyhX1gzqYbmuoU2EBnhnhKJqdugrblXfaI6Et1t88SKzdfI5OlgZ
         W05jCQZndgS8L4lbbU5UQ/pjxPbeBisrtFSMGA92LBsRJewcZZ9G6BVQKIWJ2skbTb
         l9Mz+U6bi0e7vgVw9F8dCxJLuKCMPAcop3RWolsc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1551940186.8289.60.camel@HansenPartnership.com>
References: <1551940186.8289.60.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1551940186.8289.60.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 26af1a368e40618d67956b1f883fbcfec292c5d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92fff53b7191cae566be9ca6752069426c7f8241
Message-Id: <155218201567.32026.11525951372374565619.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Mar 2019 01:40:15 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 06 Mar 2019 22:29:46 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92fff53b7191cae566be9ca6752069426c7f8241

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
