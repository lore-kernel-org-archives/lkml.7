Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361DDC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0960F21852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568763627;
	bh=l3BZJBzOjZ3s2WuZzMnDDAXWEhnQBH7p4cVjus3ZgQw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FnUeqBsj2U9WV1WB4oJrAGH9cB8nF9tExFKpzQhwJ8x4PEO8DdtTsQu9jHaU1/8OS
	 Bo6VD7rQVdQJzZMwrJgW1roX3PxuV63MPv/e0Gn+R62KiKHntwpK9XdkoiOB1ydyJi
	 HQlcdLbH49SuWyNglu4e+i1pYNP/+ehw9TOhnTBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfIQXk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 19:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfIQXkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:40:21 -0400
Subject: Re: [GIT PULL] asm-generic changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568763621;
        bh=l3BZJBzOjZ3s2WuZzMnDDAXWEhnQBH7p4cVjus3ZgQw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FdZ4zoqseeGdChypkw2Gy7fHFJs4sYuVjplSZ880lSamiWKweapizWXTivE0kQaHA
         zl+wZ4e2HPr68iIO/4HiRh3Kuzlw6Fj2zi8OARqozZVu2eTfwjCHDuslPAiiA3N/ox
         TEeIYNwfhByepMDg7HPs82Lpmd7DlIQgY/V84/Fw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a0N9+-fmmg=oPVsKmoNb0vAYsASOneXUYBVAp8nyJEwdQ@mail.gmail.com>
References: <CAK8P3a0N9+-fmmg=oPVsKmoNb0vAYsASOneXUYBVAp8nyJEwdQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a0N9+-fmmg=oPVsKmoNb0vAYsASOneXUYBVAp8nyJEwdQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
 tags/asm-generic-5.4
X-PR-Tracked-Commit-Id: 9b87647c665dbf93173ca2f43986902b59dfbbba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8456f945955e663853eecbbf1bd27e4390ce6d6
Message-Id: <156876362100.26432.17037456256704307775.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 23:40:21 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Denis Efremov <efremov@linux.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 21:15:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8456f945955e663853eecbbf1bd27e4390ce6d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
