Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8688AC742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE8A217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562973632;
	bh=1NHuZ8H8X/Uf+3zwV/+s1PEG/YpMTP/tmBky8iBBLTc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Is5OadhMeQaHLarOmy0lYUfe1cFXDlon4AGsIFjOm3L2vgBV5TjNS+FFSf69bqqBD
	 fq918ESrCDGhtZ8OTdV0ETEsQf+nltUkz5Ky9o+CK/ufR9FUCUo8JP9zt8u8xC7lsk
	 e1bdiyLXy8Nc2t25OfqqChSDfmAdEG0U/rcwlSs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfGLXUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbfGLXUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:20:21 -0400
Subject: Re: [GIT PULL] asm-generic: remove ptrace.h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562973620;
        bh=1NHuZ8H8X/Uf+3zwV/+s1PEG/YpMTP/tmBky8iBBLTc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JEapjNcAB8HsNrSQbJaRoZyn0P+fwjeVxfPHXw+5otINyGOE6JJQ9rtehQ5yRBNrN
         lBhS1dLpnJH6SIqWwL3UdtSEcIRvJTgeGhlLrWfgl6DJqUGscPV1hfM3CptbbcyKTq
         Ao9ZXnk0kpjdZs9gxtNASqXTyeuVHUKBqWuWD67s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1ic6ty+ktmur-77f-_=1hu4Drpt617jT8Bz3MMWixvoA@mail.gmail.com>
References: <CAK8P3a1ic6ty+ktmur-77f-_=1hu4Drpt617jT8Bz3MMWixvoA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1ic6ty+ktmur-77f-_=1hu4Drpt617jT8Bz3MMWixvoA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
 tags/asm-generic-5.3
X-PR-Tracked-Commit-Id: 7f3a8dff1219fba3076fe207972d1d7893c099bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f26f1143678d0fed8115afdcc0de99ee7cc9675
Message-Id: <156297362084.22922.12460781197088594776.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jul 2019 23:20:20 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jul 2019 23:04:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f26f1143678d0fed8115afdcc0de99ee7cc9675

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
