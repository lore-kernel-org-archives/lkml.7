Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB89C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9461D214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569433211;
	bh=PL/bII7lYtbReeMEMq9nxssvYSIf1exQZuVNMXwajMc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=U3rqZbnETi1DACuGPAD4Tt2F03WAy9KGWe3DFFZKcsF2InK19KOoDTGjnxp/jUgMn
	 OGRkjZ88yoPn5Ol6FTovSVSgy+vVQWh7qib5rEFwR+XXnX9LOsVHo06psw80+/cThO
	 2yBTY9c6CAz/jIvFs7w9apuouL9zaothi1Xu8JqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634216AbfIYRkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443032AbfIYRkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:40:06 -0400
Subject: Re: [GIT PULL] fuse update for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569433205;
        bh=PL/bII7lYtbReeMEMq9nxssvYSIf1exQZuVNMXwajMc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HJ6ZxKycnbHUMRIypOsTXHCU3V+I8qrioQWQuGDnKT6tA/QXVHAc/ZRMLlvlP2sgx
         98oX7imligUK6gFE4E53Y/P4TDnf2YkeEN95GXuEGhDuh+KV165Ad6rrZtrBhdIT3j
         MMSLMx4ofJZK16NEm3mzzARtAmgrcHlvczM4hjTY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190925092639.GA1904@miu.piliscsaba.redhat.com>
References: <20190925092639.GA1904@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190925092639.GA1904@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-update-5.4
X-PR-Tracked-Commit-Id: 5addcd5dbd8c2d2bcf719a2eb41a9b43bf9a7935
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b1373dd6e86f3a222590ae404a400e699b32884
Message-Id: <156943320549.26797.3226293348825732296.pr-tracker-bot@kernel.org>
Date:   Wed, 25 Sep 2019 17:40:05 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 25 Sep 2019 11:26:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b1373dd6e86f3a222590ae404a400e699b32884

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
