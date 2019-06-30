Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4C3C5B57D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 03:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2ED2086D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 03:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561865420;
	bh=3b74WRVQXzGp4BVfAyzWmsR3Ltcrfo3jqtH6iCngZPw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NkgBsJYo6mcPsd3Yr8Ba0/brhDr2PXT2j7IUvCE92CrnKOl+G9we14h3NZr6fMdoc
	 GheIITnsBSdHoSpfNsHjuBKcSHr/Pj13JCMu+tnnhU1Bi2Tm33bWwcxCsvAwbvmbUo
	 qdIurwdVXD/cnaH3IbqNvd8lhdqDLe37ArD+7tiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfF3DaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 23:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbfF3DaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 23:30:05 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.2-7 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561865404;
        bh=3b74WRVQXzGp4BVfAyzWmsR3Ltcrfo3jqtH6iCngZPw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c1r4R03cgt7Ju5W+12EOz6slVHoSqRIv9tyalaGLpimh3ZtQ+YxT5RGFcxAtCSpHR
         0z6ZIEKduU9Ba7G4KGYL4afNTB03mRKZWSTMqWvGT4t62BDHqJ/b/bl7TTGzzNdVik
         GWH8XXZU4U36hhSphvMrE+nCGe+j0bRR4jxeATTk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871rzck26l.fsf@concordia.ellerman.id.au>
References: <871rzck26l.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <871rzck26l.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.2-7
X-PR-Tracked-Commit-Id: e13e7cd4c0c1cc9984d9b6a8663e10d76b53f2aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39132f746eceed6beecb16c7b79600fb54eb8b2b
Message-Id: <156186540453.13728.17300214218625596433.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jun 2019 03:30:04 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Jun 2019 22:26:26 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.2-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39132f746eceed6beecb16c7b79600fb54eb8b2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
