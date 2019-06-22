Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DC7C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8E02084E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561222507;
	bh=ljItAA5QOBDvN0VKwcLZwvMB/p40VLJi6z/Xloi1vKQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IBRXk96j3IL1KXGUvcLfhZksMfSI+qNsuyt+VwMx0IaZXmLsus9VzWXJahp8ome6C
	 53ZVQ1RGzR05fS4k4lbJMtttjoVmoAWVPVp0/lN8da96z+MSH+TlVmXvD0LH0mKqj0
	 YJXTFQ0YuBWgCbmO5o1GEUVLkRl5uGp+szFd6DY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFVQzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVQzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:55:06 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.2-5 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561222505;
        bh=ljItAA5QOBDvN0VKwcLZwvMB/p40VLJi6z/Xloi1vKQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zATXfF2L6Hn+p4Cc0Dr4KlhWCqauwBPCIPYQ0hw+H7uY7KeGnWkv1bRKHsYZXOstd
         ThWKr6BPJYKnATKOFyQzGD/3IJBf3aU4tuEoxm4NmZp6VtCtiB6wzF0CN3oh/CRoSE
         T03aZPsclTXomfpXA5FvsB5YD1/oZS9tdUESrd0o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <874l4halcp.fsf@concordia.ellerman.id.au>
References: <874l4halcp.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <874l4halcp.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.2-5
X-PR-Tracked-Commit-Id: 50087112592016a3fc10b394a55f1f1a1bde6908
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8282bf087bcfb348ad97c8ed1f457bc11fd9709
Message-Id: <156122250504.32167.3748536201783755166.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jun 2019 16:55:05 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Larry.Finger@lwfinger.net, christophe.leroy@c-s.fr, hch@lst.de,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, sjitindarsingh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Jun 2019 21:52:06 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.2-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8282bf087bcfb348ad97c8ed1f457bc11fd9709

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
