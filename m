Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21800C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19E1208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554682209;
	bh=M+b3J9Icd5w762ic86IEU3IwGfjoJK3MbKGAunNB7w8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=S0IyYvqk6tDB/aVAdrbsAfOTJvdtDaQC2sTokNdrSYTX3oMc5V7/2g04lGks71Wbt
	 +wrX9n94LPCIFecHv8u7BX6HNkpxvEiNXjhURWSL3VNvvJ9rr9Dp4jaZWMvbkW/+MR
	 wknLy4R3ZhijXACBId97REfdQrQBy+rAeBn1TfUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfDHAKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 20:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfDHAKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 20:10:07 -0400
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554682206;
        bh=M+b3J9Icd5w762ic86IEU3IwGfjoJK3MbKGAunNB7w8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R1uTt872taNGMpvSX409gkEov1PIZS/to9I9Imz4PT9MmzWvj/t7/pJwuKrMfoNtd
         0/x7Tx7t/q+SWVqWd7Hq0EU6iofv/njxgmhcaLHmIe59xayMMXuNFLBT0gFGisNnL6
         yF9s4jP+S5bso/rS9Jes8hOXgkj5jz0lPxjws+Xc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190407225020.64gf2b57mv47vfuv@localhost>
References: <20190407225020.64gf2b57mv47vfuv@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190407225020.64gf2b57mv47vfuv@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 9a8f32038a74cb800e9649afbf4b3dba2b7d6539
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8491223bc243b960ee1c4a8aa5219eca0d69acf
Message-Id: <155468220691.5452.15149365823843880877.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Apr 2019 00:10:06 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, arm@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Apr 2019 15:50:20 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8491223bc243b960ee1c4a8aa5219eca0d69acf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
