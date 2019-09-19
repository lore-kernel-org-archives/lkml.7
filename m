Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA300C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAA4218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568852416;
	bh=Kgnmdq9f4tydvkTaAzsFlsaT7RZYMwPGjy6eZyrv2lg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=H/xf5k29PkESjxWX02fjEyWdSe10vv90MfA3fscaDkz/UDPoLs1bfeaUufJyDsfec
	 y/7tiGHvsAXemJINjxCiKAk02jRIkTPFvcXf+xskqgR5YFAOXAFko5MCuigfZXtxKT
	 PiyehZDRH0NGSnHyziC7XHV3LMdwbQec/LqZZHNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbfISAUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 20:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387406AbfISAUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:20:15 -0400
Subject: Re: [GIT PULL] fs-verity for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568852415;
        bh=Kgnmdq9f4tydvkTaAzsFlsaT7RZYMwPGjy6eZyrv2lg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d4TYbWotbCsYwIReC6TqfGLqYzZ83KC56t979ih9FDQTPr7IfbE0f5p7dLiPIIOqg
         NCKzukI+2Hka2uUCA4sOvoKLK31ijYnyt5jdN+CsHO4N1CyMWrm8exGDvlc/q6deD6
         cUVAtOMjNAHxacwwUFywbfjnrJ7WSFDHxHPCpjVA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916052053.GB8269@sol.localdomain>
References: <20190916052053.GB8269@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916052053.GB8269@sol.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 95ae251fe82838b85c6d37e5a1775006e2a42ae0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f60c55a94e1d127186566f06294f2dadd966e9b4
Message-Id: <156885241510.15091.4135567870760674350.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 00:20:15 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Sep 2019 22:20:53 -0700:

> git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f60c55a94e1d127186566f06294f2dadd966e9b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
