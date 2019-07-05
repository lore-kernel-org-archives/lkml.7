Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CCCC46498
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E782184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562295304;
	bh=GojBOsycOWpwWi8x7jw/e7f5BslK2F42lo4GldRNtVA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PnZKehAKwvLuYm0CX2vvt6s/qE0q4jqlvDJxTcO0dmE02yEdZAvriAkjTi2wMKx72
	 MBC/K+a+PlwbIPCf6XKrxqpNNFggG0xqM/eTVL5JuP3RhNJQmvpzRhVDxciyHVBiiv
	 9Sppi7ttnk+m805+t4h3xz1HDDv8DANulhPXq3j8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfGECzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 22:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfGECzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 22:55:03 -0400
Subject: Re: [git pull] do_move_mount() fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562295302;
        bh=GojBOsycOWpwWi8x7jw/e7f5BslK2F42lo4GldRNtVA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Bztu1ceuas0Beto9hMQFM0FDAHS3ESddGTwwMDJx61u3nNW6N2qV30IsLnRyIEWj9
         c9Qd92ffLSSkqSrpv09PC3mozCDf4MX1tC/YZocNBKxmR9YIU/21M/0UCbBoDVCj2N
         vh6Yj6rEjfLBkFz0nPa14XvaqgjuFqi8dbNCkmBA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190704205740.GJ17978@ZenIV.linux.org.uk>
References: <20190704205740.GJ17978@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190704205740.GJ17978@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 570d7a98e7d6d5d8706d94ffd2d40adeaa318332
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cd7cdc7e420a343743db781484e801fd784a1f1
Message-Id: <156229530218.12956.1982394929470545811.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jul 2019 02:55:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Jul 2019 21:57:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cd7cdc7e420a343743db781484e801fd784a1f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
