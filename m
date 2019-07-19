Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0845C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7385A21880
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563565506;
	bh=UA/PF8XfLZ90dYK+7pEKKDKUHleWJnsX+McDJuoHgyo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DNLBxiZGTGsjz325kv2XCbe1566L1pz2o6h7BR+CdhY3AyemLLa1C1tLcG2LMaWH4
	 ndwO29EEyeSe7eU1Kwv3EYcfDeLA6aMDnfiOEXEE/vWynhJ5XmSyXXkpWB70UnPiE4
	 piLi/QPcVdPs/6UJjXNrbKQ917nV3TipOH7HdWa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733250AbfGSTpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 15:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733221AbfGSTpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:45:04 -0400
Subject: Re: [git pull] vfs.git work.mount0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563565503;
        bh=UA/PF8XfLZ90dYK+7pEKKDKUHleWJnsX+McDJuoHgyo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NNNBfNcntK/g8M2w0+OasNr2pZjGfTAzblPZ8O+WrMMBIBPTNf93XvXAmxMZH/+dF
         q7/mpkTbgavn6i1P7LOqxD7inBNILlP4z5y9Ir9jzJ5lXWCILiYMTJXNwBolNIlOxv
         SmAfeZ8azBGDOk/aH48V64FxFlPdh+98Vpp6Imqk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190719034419.GX17978@ZenIV.linux.org.uk>
References: <20190719034419.GX17978@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190719034419.GX17978@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount0
X-PR-Tracked-Commit-Id: 037f11b4752f717201143a1dc5d6acf3cb71ddfa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 933a90bf4f3505f8ec83bda21a3c7d70d7c2b426
Message-Id: <156356550353.25668.3361840148671979480.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jul 2019 19:45:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jul 2019 04:44:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/933a90bf4f3505f8ec83bda21a3c7d70d7c2b426

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
