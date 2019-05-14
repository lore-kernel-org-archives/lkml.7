Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8A1C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F64220862
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557853510;
	bh=3TjbMrQwBf5qXEKBV4LBZ7m9rj36YE4HU635ehUTdOg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=egjinj/NDxrCScJAqqa1DRj2iLR9dbczXzodFb+YnAJ0KvIWPaXKRVtY0g+oDHpJs
	 VKaAj5Vqp7RLHUwDdmmUtmgFYsCljYQCoXrJ4rzTCRRBIT7C4UpZ1MJn9ZxLQ7JGBL
	 cZzdoYti1k4Kw2kxaPT4DnExmz11BCiXiyh9QZZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfENRFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfENRFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:05:04 -0400
Subject: Re: [GIT PULL] overlayfs update for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557853504;
        bh=3TjbMrQwBf5qXEKBV4LBZ7m9rj36YE4HU635ehUTdOg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XQRfZ2YWMJIS1LaelMIwbi0fIwYG/ZfHzr9ugdRkWZxm2tAAeyaX+Yz1ns4RCAnK5
         ezmgE29/BhJ9nEDep2MuPSJUO/svKSAb5nyMuQOtdH3MFQTOt11KDPkmx7Xm8vScMx
         RB+UwrCp2SyJ4tc2dK2v82is+ZLnFOdqbCp8ogjw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190514075555.GB7850@veci.piliscsaba.redhat.com>
References: <20190514075555.GB7850@veci.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190514075555.GB7850@veci.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 tags/ovl-update-5.2
X-PR-Tracked-Commit-Id: acf3062a7e1ccf67c6f7e7c28671a6708fde63b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e9890a3500d95c01511a4c45b7e7192dfa47ae2
Message-Id: <155785350425.31213.11521686199689755194.pr-tracker-bot@kernel.org>
Date:   Tue, 14 May 2019 17:05:04 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 May 2019 09:55:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e9890a3500d95c01511a4c45b7e7192dfa47ae2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
