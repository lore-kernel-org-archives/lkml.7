Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051B8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D8D2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552012219;
	bh=vrIrbdjlKda1WAmrSX5pOglA3EN8JkRB7h/2MUGI3VY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UrhN7EVSXHS8JjE+hdhnlw8mDXBcj/kzMk64aBCp6UZB6UOWoykc6UYJBeKzRmXl+
	 DPPhaHpzRAoOWdFIoFjQTJ/usJ98HT3sO2+eGnA5H2ruF2lDicabjmF8dA/gE+MzaK
	 ywvlMwS/xSujz34u8HG9jnBK2kZsH8R3pX6mQQ1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfCHCaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfCHCaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:30:16 -0500
Subject: Re: [GIT PULL] x86/build changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552012216;
        bh=vrIrbdjlKda1WAmrSX5pOglA3EN8JkRB7h/2MUGI3VY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u3T+a1l9pn5PrHvW8uKaUqSqlCN2VFTTKkSEBfc5xSsI6pmZmeulkX7j5XsFRuGZT
         UfL59ciFsEovx0AglM7qj1B61hHLlWli3mU473hGmfI8Oh/KlvpSnsU3ODdKBFn/qz
         bVpMuV1o3oJaCbgwyNLnuQRNVtJwBEHv2T1N4XlM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307171159.GA46548@gmail.com>
References: <20190307171159.GA46548@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307171159.GA46548@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus
X-PR-Tracked-Commit-Id: ce02ef06fcf7a399a6276adb83f37373d10cbbe1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f14b5f05cde1e22f4a99d7bc0f9d61f024f21f70
Message-Id: <155201221610.3231.5368564829121048336.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 02:30:16 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Mar 2019 18:11:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f14b5f05cde1e22f4a99d7bc0f9d61f024f21f70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
