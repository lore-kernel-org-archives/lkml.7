Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B18C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9382721927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568852415;
	bh=yjrMrZgFDuzZIDBYejuK7WbX6ZxavGonE0Fw0AE6YFE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=N42E4x/fzaE5quFvoyz0L4JWhunLlR6tJ61zMLDILDpTUVZgA44rznsP58qU44aaI
	 vTF9h3YfrTyQVqbXDMhkEVyoowxrfQ3gbZR4ALfDtYq458PLbAlHz0NUlzP0l7afOx
	 njVnkwFRpKS7f35VRO812VOhTFN6vpj92sVH2PDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbfISAUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 20:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387406AbfISAUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:20:14 -0400
Subject: Re: [GIT PULL] fscrypt updates for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568852414;
        bh=yjrMrZgFDuzZIDBYejuK7WbX6ZxavGonE0Fw0AE6YFE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u/9kfsaaTOjpp0bZA1iRqq6nN4zJLUN/1/SNh+v+qe9YXzc2Ca+u3dso6QVFN/gmM
         x/WVD/PvZNHoOnVexKj3THcrCpjM50hLYUpUQIuhEFuSETtQg6NeIcD+fGJujmcthZ
         XpigmechV44m7Y6bDzM43DzQjvPyrsiNFM1ulPBs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916044258.GA8269@sol.localdomain>
References: <20190916044258.GA8269@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916044258.GA8269@sol.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 0642ea2409f3bfa105570e12854b8e2628db6835
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 734d1ed83e1f9b7bafb650033fb87c657858cf5b
Message-Id: <156885240309.15091.17264386602149266891.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 00:20:03 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Sep 2019 21:42:58 -0700:

> git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/734d1ed83e1f9b7bafb650033fb87c657858cf5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
