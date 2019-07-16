Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B59C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCF12173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563251719;
	bh=a3NxcsZMgzh+Fs9H9nvfM6IJImtQ6nfxS/+zKPeTTIo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mTM1Pg218wMpGW4OUY65/UHCXU7/suSW2AjB03ScTr8yG1MUR0/HxWdI7DCKLBJ1g
	 nOhVH4OUsCup859zNfwhIpZOU09wpplFV519TSvNzoBbOO2fo4P8E2Ql/GVHQw+CNF
	 MBpc603OfvT/bvckeJRv5ifN00cV2b7MMQMO3xG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbfGPEfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 00:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733149AbfGPEfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 00:35:18 -0400
Subject: Re: [GIT PULL] MFD for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563251717;
        bh=a3NxcsZMgzh+Fs9H9nvfM6IJImtQ6nfxS/+zKPeTTIo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mDobt/nojYrVQJ1h9rMCA7xsN9BmWnqpaEEygZk5K6EoXzRp/k7isws7rZBshJT/8
         S2IaM3bZTfO2Wr2CwYyZemWEcXusfJvcBXN2kiz8SfiVXaqhbyITxFlEF+dVUQf7Cz
         9dEAUy6s96rNNfbR0dLAV/oWRklFfdgpbKfEJFLE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190715074835.GC4401@dell>
References: <20190715074835.GC4401@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190715074835.GC4401@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.3
X-PR-Tracked-Commit-Id: 7efd105c27fd2323789b41b64763a0e33ed79c08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8de262531f5fbb7458463224a7587429800c24bf
Message-Id: <156325171739.15429.13286602087178975217.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Jul 2019 04:35:17 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Jul 2019 08:48:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8de262531f5fbb7458463224a7587429800c24bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
