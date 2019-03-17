Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A993EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B7420896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552855817;
	bh=1gNKBlne/z8SNo0K+Wjk0MYD++Rg9kDAV6T89jiRu2E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZdIlHlLl0VlhAs5CRAj/mY7jcFdWee097eyXV0+uJQ4hp8EaaIxZGha2yTqTLkUJ8
	 oJSF7XMeas29zzoXz5/1Gr/Rz50ONSLXTUuH3Et0WkabH4JhX+WABJ6kUbviKO1lNr
	 ARzgNq1WLV9JtRGInikAOXLnwpVqeacW2MEotL24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfCQUuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfCQUuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 16:50:16 -0400
Subject: Re: [GIT PULL] more Kbuild updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552855815;
        bh=1gNKBlne/z8SNo0K+Wjk0MYD++Rg9kDAV6T89jiRu2E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gARKV8zRyrsJ8RHtnvSiQnRRSkDEcpCQ9psXR/i1rKeQTGLt4Zu+7UiX57T0sPPGJ
         yY8yvkosU58H2uRwDWrrRyIxyv5SaRDIBkvpED+qMaIwwgUvybxiF6LIx8oYxOEVI9
         30NRPPzL+uSpVisbQpi7gOvFMlkQeNcW3zYSAjxE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATgAf-xiFFtMHYvOR91iNwQbiWaZxZCN-EKPKRpK57XuA@mail.gmail.com>
References: <CAK7LNATgAf-xiFFtMHYvOR91iNwQbiWaZxZCN-EKPKRpK57XuA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATgAf-xiFFtMHYvOR91iNwQbiWaZxZCN-EKPKRpK57XuA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-v5.1-2
X-PR-Tracked-Commit-Id: c71bb9f8666602a22aee9df36a2df35e47edd8cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28d747f266fb73cd28a1b9a174cc3738fc177b00
Message-Id: <155285581557.27250.8615626753344662639.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Mar 2019 20:50:15 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 18 Mar 2019 00:59:54 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28d747f266fb73cd28a1b9a174cc3738fc177b00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
