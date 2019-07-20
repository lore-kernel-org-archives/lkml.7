Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBE2C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 18:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69A521882
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 18:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563648029;
	bh=38t8tijbNEd+CV3qTnwaK/it4JSgS/EqIApQJNRIUDU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FfEO0+DR4sIZyk/rtLNakd0UzBzNsjwNBd0c2mZH3bayJ7zJ1TlZGag6MMMQUqF6m
	 dVIjYrlru+o/SZLd/g9/aAmr02UCP+eYbmOyojtnvtHg0FHZMuInJ/mE01zRqc8wAB
	 NYOq1uIVN1IFPF/4F3zrrdc7UPcCfptMp8AoGQaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfGTSk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 14:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729039AbfGTSkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 14:40:25 -0400
Subject: Re: [GIT PULL] More Kbuild updates for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563648025;
        bh=38t8tijbNEd+CV3qTnwaK/it4JSgS/EqIApQJNRIUDU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=s1xg5aXLfBjv/80uEQ/aJjgVEcBPWqJWOWmiWtYgifBpK12sZMALu4oQuOsX+5tli
         C3nufqtDekSiL96BI1CeEurdmz1GEhkRJOcROjb2wTMVs0MBF1oFCrjUgS6LituvXC
         KWCOiZsXiYdIFmJ9Oh4LGlDQhOqhhyOywegx0PJk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQD7m+PCS6KtoVmZ_7kggLeWD6LE6NkfZ7TeaSO26sQGA@mail.gmail.com>
References: <CAK7LNAQD7m+PCS6KtoVmZ_7kggLeWD6LE6NkfZ7TeaSO26sQGA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQD7m+PCS6KtoVmZ_7kggLeWD6LE6NkfZ7TeaSO26sQGA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-v5.3-2
X-PR-Tracked-Commit-Id: 29be86d7f9cb18df4123f309ac7857570513e8bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 168c79971b4a7be7011e73bf488b740a8e1135c8
Message-Id: <156364802496.20023.10550559026864840074.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 18:40:24 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        masahiroy@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Jul 2019 11:31:01 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/168c79971b4a7be7011e73bf488b740a8e1135c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
