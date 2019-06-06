Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C043C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A9C206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559850305;
	bh=bMvXxNGMZgwcQt8Bga0L4BxCS+GbQCKH4lNZoO5lBXE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MYVYQM6eqe+ZngvZmGGbGfxHXU44Ux+Xe/cGblpBGF4NbN09et+K5sKg8HCNARQOa
	 LGACBkFgqY2E/Dc1F8/oSqyZ8mqDbqMsG9XXSTM9XSrmLsM/rAMggb2ShLfUyRyW/S
	 XlHtWA/QDsgUBCbF95Ps3yWRZXIgmGEzs0zegai4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfFFTpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfFFTpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:45:02 -0400
Subject: Re: [GIT PULL] overlayfs fixes for 5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559850302;
        bh=bMvXxNGMZgwcQt8Bga0L4BxCS+GbQCKH4lNZoO5lBXE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KysQuyfAAn68ErXCSv+006kKGhdf2t+h98o89BUNH8wwSq0CRZJB/V875lGpkD8za
         sN6ar7OcQEcC9edsTsYP+u/Cv5aFuiorZ1wrWkg22mEJeypbwkze7JyNt5dYBCENqS
         HcrK37NBqhRaP9x0tBPJjwGZJRrRqz69HSt0Ww5Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190606134418.GB26408@miu.piliscsaba.redhat.com>
References: <20190606134418.GB26408@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190606134418.GB26408@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 tags/ovl-fixes-5.2-rc4
X-PR-Tracked-Commit-Id: 5d3211b651a012bc77410ebf097b7271a7ce5c95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d6b501fe5421c5df662e2935f55f5e3d2b5e012
Message-Id: <155985030229.29170.4073257838224103158.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Jun 2019 19:45:02 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Jun 2019 15:44:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d6b501fe5421c5df662e2935f55f5e3d2b5e012

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
