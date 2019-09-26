Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98506C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFAF2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569538830;
	bh=Te0AMbnp7/yHOV7UlPag9LsO5tZOedu52hU/6h1xNb8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SJ/qhunhKBVP9E5xfZiF1lfdKyZy0C/3CTC23wK8qLFiYcJ2kIBXyqhKchpt9OBBo
	 OidFtpdKWHQMWSi0kralHfts6YHi44ISvdpW1eJDiCJDE7kpUzab8FGBVILHjuRPgl
	 Ryjy5j9rz52QsNW9pqdAoJfgTin/yZyyldEUWSqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfIZXA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 19:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbfIZXA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 19:00:26 -0400
Subject: Re: [GIT PULL] timer fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569538826;
        bh=Te0AMbnp7/yHOV7UlPag9LsO5tZOedu52hU/6h1xNb8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XDKabWdzWBfVXwLrp36Euwdui+vC7obgx+PAlJWKJqt8tt5YBi/GID0Q76LlJzmC9
         P7OagyJndnpcRzxMZqC1xITfQlSzPXxf3N6EoiH4RdqvcVw+iXocf1hkrQvGloCa21
         JNa6R8KZ2qdoA1rZM0MP9AMTOncLyVxTV0JavHts=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190926201825.GA45571@gmail.com>
References: <20190926201825.GA45571@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190926201825.GA45571@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: e430d802d6a3aaf61bd3ed03d9404888a29b9bf9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da05b5ea12c1e50b2988a63470d6b69434796f8b
Message-Id: <156953882636.9540.9070232488717065924.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Sep 2019 23:00:26 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 Sep 2019 22:18:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da05b5ea12c1e50b2988a63470d6b69434796f8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
