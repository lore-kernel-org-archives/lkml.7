Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435E9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6D220836
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574818227;
	bh=GY3dPMoMYTaiPoDu+CD+EnJs0USWKt7AgDFnvZl9hWM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WVraHylBD2Iaqn0QIfk+SCtNWtjzyKqVrIoEeWSI4nR9omFSVHva1WvtnjxGZG3Ge
	 k6oa/V+kfLFvd1mNelxrJj5vCgEKuD3h37nTTqsOlZfdU09q8Spzyy0xgAxvb+m4Gh
	 EYEbnrJOXbuxOQOMiouu6Eanb99aoStw4HFo93BE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfK0BaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:30:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfK0BaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:30:16 -0500
Subject: Re: [GIT PULL] x86/urgent fix for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574818216;
        bh=GY3dPMoMYTaiPoDu+CD+EnJs0USWKt7AgDFnvZl9hWM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oqnHE3briHJMvDdoXdausVIjVHwxNWaoF4/dET/gtzCSmBnOxCy9vExsLGF1JC179
         jZfqY0nbn+P8WLJH5y4fVNeUaz+Ns2ENie+UunLIey7EcF5hNJBOuzQN8GgYUTFyvz
         u3ai5M1ngjECj+gCvhnWR6iIJ0gp7LiCX62vtp8U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191126210443.GA114386@gmail.com>
References: <20191125161626.GA956@gmail.com> <20191125192456.GA46001@gmail.com>
 <20191126094554.GA3017@gmail.com> <20191126210443.GA114386@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191126210443.GA114386@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 0bcd7762727dd8ba9b9b6f828e5a4cbd5da4f725
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2da5bdc66a377f0b82ee959f19f5a6774706b83
Message-Id: <157481821618.26353.8956595620302372938.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 01:30:16 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 22:04:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2da5bdc66a377f0b82ee959f19f5a6774706b83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
