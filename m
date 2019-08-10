Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C887C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738DB208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565465423;
	bh=8q6vSu1qocR5sW/MhR0cbFqGPLqrYkuUIzUkV5iQJ2E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Sy1Os1gnGXaUFLnqLWoHLeq7UBFL8YFYxM/8MJiwhLBuc6ndJdKxG1BnfXXex9mo1
	 geOKghXxz7CA3G9bhiv9u9/UCw/bWVUjidASoiTPMPui17mw2s3brqAKPfY4/J9Lrk
	 UvjOsOnGh+kIXZBT/Kunh0Dql00XPmbKbKoXBErg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfHJTaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 15:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfHJTaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:30:13 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565465412;
        bh=8q6vSu1qocR5sW/MhR0cbFqGPLqrYkuUIzUkV5iQJ2E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=E0aCm/C8sAs3iJSL1e3/SzAOriM58Vkw+pPT+3+eolCKlLkcC6rOcaINbkkcXX624
         poOiDZ5uqPiJw1gRoyFznDTsjI3ScTYFDNNSV6x+5/VRvSYbdoVDbttYB5RVnfvtZc
         vmTJwRVpY2FmnmEXvPDdySGAWprVYH8+ACgmZCxE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190810115318.GA6103@kroah.com>
References: <20190810115318.GA6103@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190810115318.GA6103@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.3-rc4
X-PR-Tracked-Commit-Id: 5511c0c309db4c526a6e9f8b2b8a1483771574bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5aa910073744e5ed6d79410d81fa44149b2deeb7
Message-Id: <156546541232.17840.11713031661826031130.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 19:30:12 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Aug 2019 13:53:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5aa910073744e5ed6d79410d81fa44149b2deeb7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
