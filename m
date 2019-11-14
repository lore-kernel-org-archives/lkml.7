Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07B5C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5106206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573750512;
	bh=FWK96innZUFwJLbbxQ7jYD09cgTH4QK3AYDMHe/aJE8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=je2HNlY0gIjqT2AB/Ye/rC4ahettmFxM8SU2yTt9WMu82dD3bibd+ANzuVpjLKwmy
	 Qdqb8nh3f8aizO37N80VfTABDAY4eSPN2mVE0HA04dz5ley4T7kNRKQe5L2SmMRd3l
	 08R9gUSPJX1vOawUvYlrJxL9VCZQVtkGpDzuFknM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKNQzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:55:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfKNQzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:55:05 -0500
Subject: Re: [GIT PULL] Kbuild fixes for v5.4(-rc8)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573750505;
        bh=FWK96innZUFwJLbbxQ7jYD09cgTH4QK3AYDMHe/aJE8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NGNJL0RFRJTy6Fk842uVXLN/wRoIL10u0WvAEEmeVfewSrClauD7OOiEKCcyHSZ6r
         pnnWkVh4pDu/1SVBxgk2ngcuWU38QoFuzMo6tUjyUaz7Shz/Rvb9wbreeFsBj7MEji
         OLsDCJ3l+h0n/Nl2GXpExf/cVrkdwFDNGQ0zOlYg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATqoF-NVhkP9J7SyDmK-x8vQ5pDJ7U_aEngdJb_vvDixg@mail.gmail.com>
References: <CAK7LNATqoF-NVhkP9J7SyDmK-x8vQ5pDJ7U_aEngdJb_vvDixg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATqoF-NVhkP9J7SyDmK-x8vQ5pDJ7U_aEngdJb_vvDixg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 kbuild-fixes-v5.4-3
X-PR-Tracked-Commit-Id: 80591e61a0f7e88deaada69844e4a31280c4a38f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96b95eff4a591dbac582c2590d067e356a18aacb
Message-Id: <157375050535.665.2266424346154790313.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Nov 2019 16:55:05 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Nov 2019 00:19:27 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kbuild-fixes-v5.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96b95eff4a591dbac582c2590d067e356a18aacb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
