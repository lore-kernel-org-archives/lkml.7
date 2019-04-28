Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A07C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745BB2063F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556474709;
	bh=r1Phgevg7jacwXXzZoC0B3yhPhoQIHPFdRjm/A+Duwg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mggmufo1AW7DFWLNSTlUGAUuZhJfBRCG2xeJUdjcOXRWuafq/5avcSzScK4Pwve1Z
	 sV6TaZzF9G094DjFGpkgys0bho0FM4SPo1R1zAxGD2u2IMD3B7KIEJtL03L/tOstL5
	 b4u3mfRvAQ9nLPd6az0zX8ziILSAkOtU53dR2XMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfD1SFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfD1SFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 14:05:05 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-6 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556474705;
        bh=r1Phgevg7jacwXXzZoC0B3yhPhoQIHPFdRjm/A+Duwg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vkWKjOetJdt//MWm7hNnWEuJ6wEvOzafGMS2YK1SvrhZg+i1zntO1wxVn+j3uzgGt
         P6ynpV3uIU2hN8RTBjnKdG4IWagjlGwnFhYqYGW9pjYX/0QXqQMw0/hMvs8JjmIYqO
         5YzuXfPE1WhsX3h31NmEOXrfNMrqqTJgjfaKq124=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ftq2aa9u.fsf@concordia.ellerman.id.au>
References: <87ftq2aa9u.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ftq2aa9u.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.1-6
X-PR-Tracked-Commit-Id: 7a3a4d763837d3aa654cd1059030950410c04d77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d82044e1b7e5497c2177abd39b31e9ba27be8b7
Message-Id: <155647470495.13942.543025849806410180.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Apr 2019 18:05:04 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, aik@ozlabs.ru,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Apr 2019 16:55:57 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d82044e1b7e5497c2177abd39b31e9ba27be8b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
