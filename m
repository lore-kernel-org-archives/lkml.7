Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91817C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FCE2081C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558287930;
	bh=MoNXTYz6i+euRRmk0nVceC9FrohJKxerQySlZ0GDsXI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=j+SWvlpVC/JAOG8hCv3BAXSNDzSFIIg9k1SxutStHtVDm4QKSiH3o6zqn3TtOuza5
	 ZxmLHl1TijdUxN0LU/cdGCPkjX+4ur3WrWNAuaxRNaO0NvIQOjM1VnDFnmNxEDlZJt
	 MLyjFd5zeAGBuTlzpQNV3dugRr2HP9Jvi6TXOf+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfESRp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728418AbfESRpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:45:24 -0400
Subject: Re: [GIT PULL] ARM: SoC late updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558287924;
        bh=MoNXTYz6i+euRRmk0nVceC9FrohJKxerQySlZ0GDsXI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=w07eRgzDCL/nHX2FmuO3WuTs020SZZ6s/v9K3HJ8HThPv1aYj5JPXwdbKi2fvRRVZ
         fkv0lZSaSZMdvJjF4+uLPFa7bw4pfBL8UO8+sGpmV+3Ny79EasrzSGqv/BNewxS7x2
         fq2G3NyZU0Z7mB1itvZSqb5Ed0kwzmX0i8kZOpK4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190518225131.2lyysevggfbyqfl6@localhost>
References: <20190518225131.2lyysevggfbyqfl6@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190518225131.2lyysevggfbyqfl6@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-late
X-PR-Tracked-Commit-Id: 15d574fbd3f8ec7705896ed14b74eae482cadd4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c4a5c99af7f479a14759196f8df9467128f3baf
Message-Id: <155828792401.9186.2206996596396816768.pr-tracker-bot@kernel.org>
Date:   Sun, 19 May 2019 17:45:24 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 May 2019 15:51:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-late

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c4a5c99af7f479a14759196f8df9467128f3baf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
