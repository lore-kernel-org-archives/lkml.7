Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6CAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 02:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDFA207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 02:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574734531;
	bh=fSLt2nRhbaxKz3GuwompVipPtdWZMwmlGs4LKYQCfKk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WC1pysK2I68p+Rw3peUbu12V3X3t33Q2VvcwWx64Qx7bFjNin4mthtdQ/Ej4LBOlN
	 58tGI0jJfLWqddPd6G4frVNbZSls2jMVtW00o67WppBr4YDymziGBmZLSuaAucpT5k
	 07zKvRdGBo7ZX0TYYyxG3CIH8ZeGm+PTJQFkyo0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfKZCP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 21:15:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbfKZCPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 21:15:11 -0500
Subject: Re: [GIT PULL] x86/microcode updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574734510;
        bh=fSLt2nRhbaxKz3GuwompVipPtdWZMwmlGs4LKYQCfKk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z0FzEqF5PgGCJXRjQEMpxaGq2ZTZiILAWC+WhIjAFoEhrydOHThx37mRdPnjDJeAr
         M4eJew/W3DkdEStSMP3ZSb+Kuwm+JTZMQ8hLr07AHPwEwM5W8eIAOrED6DfDuTgJ4l
         jMQ1n0f13et8wPb7qbFh3+GR6TFRo80+UpLHWH8w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125084428.GC12432@zn.tnic>
References: <20191125084428.GC12432@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125084428.GC12432@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-microcode-for-linus
X-PR-Tracked-Commit-Id: 811ae8ba6dca6b91a3ceccf9d40b98818cc4f400
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63c2291f836e1279637f95c982407cb2d5f0c335
Message-Id: <157473451053.11733.992292006699358058.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 02:15:10 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 09:44:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-microcode-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63c2291f836e1279637f95c982407cb2d5f0c335

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
