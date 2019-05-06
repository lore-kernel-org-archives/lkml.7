Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE649C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B378214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186030;
	bh=MGrBDG7xGxtNonL6ACJinoe2njlzKnCIVifBMsoxCCk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kI5HxiNCZWsXqPhYkbrkSqOpsY/Y80zxGooLeAEjrF7L4DR36I1Hc5u56XzefyBBz
	 JReOvQVKFSsaON8RA2be0xaefygHbXj+puH96QiZ30uXZsuVdS6TC9TazspMiN4Opp
	 B9zG1+MSLuia/Gny6EQ0E7TCRwK5u4g6VafwMjdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfEFXkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbfEFXkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:14 -0400
Subject: Re: [GIT PULL] x86/topology changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186014;
        bh=MGrBDG7xGxtNonL6ACJinoe2njlzKnCIVifBMsoxCCk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wEfOUqLKyRx0e2icA+vqsSSilJPKjWI1WCVEdM6OYfDfIiE2ZEGvt66P3Nxhrkuc8
         oYZ2SnH7ByxTLtYCk3wMsdk0RHQiZ5pc7WJYznhYZmiSVBBnNPjgGmK+XQVoAZoShs
         9wZ8iYwOhAfREjIcEGqsysVFMGatXP6FKlp2J7ag=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506105554.GA71356@gmail.com>
References: <20190506105554.GA71356@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506105554.GA71356@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-topology-for-linus
X-PR-Tracked-Commit-Id: 8fea0f59e97df3b9b8d2a76af54f633f4586751b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 948a64995aca6820abefd17f1a4258f5835c5ad9
Message-Id: <155718601406.9113.3249748304487031580.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:14 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 12:55:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-topology-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/948a64995aca6820abefd17f1a4258f5835c5ad9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
