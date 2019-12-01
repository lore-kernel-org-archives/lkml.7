Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EA3C432C3
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 01:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B1D2086A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 01:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575164422;
	bh=3jlGckcHgAZaUPAAPuHE7bUbtklXkvqHWWqPOkYygX4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ig0xLIm1xyXQwppOxkfXVmsMDUUQdBj4lfwt1WKAFHatyK5KeQ2GgZWdYtyGLdXTg
	 VW0J21fAE0ryXCVFrCZ3jyPagKmOeUKA//+c9NYylbP50sr8/k3UnYOxdVHBga0GA7
	 Crx1svrC2ldDL17zNjxGOxcbGekPDK27TiizAmzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfLABkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 20:40:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfLABkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 20:40:19 -0500
Subject: Re: [GIT PULL] SELinux patches for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575164419;
        bh=3jlGckcHgAZaUPAAPuHE7bUbtklXkvqHWWqPOkYygX4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WWZCb7KMF4FjNOqemMeWDEhU1rGw/OfE86SSC7EK8jLW7UqzPHWoD9nmuAB8DzIXG
         0V3IHpt/86XmPppYICx/vo3IpaIJx1HDwslH0zfIhZIjzQKNAMm5kDWyjOeacfrQcK
         zKfTEauoj4MSvWy1U267hk6rN2nzqoj+pLHxwpwg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRj-vx8AnP5tKcq9joNqWSHRv1bk+3e7DGU9mxjN+fVFg@mail.gmail.com>
References: <CAHC9VhRj-vx8AnP5tKcq9joNqWSHRv1bk+3e7DGU9mxjN+fVFg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRj-vx8AnP5tKcq9joNqWSHRv1bk+3e7DGU9mxjN+fVFg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20191126
X-PR-Tracked-Commit-Id: 42345b68c2e3e2b6549fc34b937ff44240dfc3b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba75082efc18ced6def42e8f85c494aa2578760e
Message-Id: <157516441909.28955.6196919876049308492.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Dec 2019 01:40:19 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 16:24:34 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20191126

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba75082efc18ced6def42e8f85c494aa2578760e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
