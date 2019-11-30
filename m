Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF391C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 19:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18712086A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 19:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575142830;
	bh=YgkJswfgiig8ZdaD6RHBZPUYYGoSPSFIx9vRKPxCGF8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Xf20FfpSFZMzQBKCZrRwLDvmdwGt2A59/dnRGw/HLjeRapFsQL+CiH2oF50qx7drV
	 YFB+d70cYxU6TbptMWkATXCYx5dbe4nADXfJ0BpfJylKQPldZdDYvZOpFSnuL2stf2
	 vHSmxpXI25GzJtuY/te4l6VxAAbif3ZR5hIh8T1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfK3Tk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 14:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbfK3Tk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:40:26 -0500
Subject: Re: [GIT PULL] erofs updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575142825;
        bh=YgkJswfgiig8ZdaD6RHBZPUYYGoSPSFIx9vRKPxCGF8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tF2bZD0ZgrSQBYEuqtqYcXkFec/DVhqqMNMayQCNZuBMUTuf3TU+D8216H+2pXR0J
         ntTFrhc9W8jvtmLAwMkTrF9GaRPFbQD3shzoI65A9kPk+GDaNaYnRPFf/w40YZlnJN
         nrDifMrdNRvvG4Hbuo+NQW0WMYnp2QXw5YlBlK7Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191128152711.GA4993@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191128152711.GA4993.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191128152711.GA4993@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191128152711.GA4993@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.5-rc1
X-PR-Tracked-Commit-Id: 3dcb5fa23e16ef50b09e7a56b47d8e4c04ca09c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2d73c302b6b0a8379a679120590073b813d5e7f
Message-Id: <157514282582.12928.6503250259230440672.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 19:40:25 +0000
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Nov 2019 23:27:16 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2d73c302b6b0a8379a679120590073b813d5e7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
