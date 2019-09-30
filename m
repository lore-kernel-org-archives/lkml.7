Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6118C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CFA206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569877569;
	bh=ISGTh9dgGBpBhIYJpYyDAoFazDXZXj3BesU55A6KALY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vFR2Jq9OOYUp9ZdrlRo9jy0mbyjF3cnlb/qH32n5Jd+9HodbcVdJ0bugT0sUAhxXq
	 RqjF6KjOmYZ6Ug+sUEtHv0Y3Nt81HUjSiS1FyGP2CA3WpqkH/OThw4Pwv/3QN4Kzft
	 IRz+lfwwuLFj91fg3SOLIhwWMKZxtauCvpSCArlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbfI3VF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730115AbfI3VFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:05:54 -0400
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569864621;
        bh=ISGTh9dgGBpBhIYJpYyDAoFazDXZXj3BesU55A6KALY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Aw4Gp+WW8dgdC6Hjwq4tT3IERHv52UcjJxKvvCRBhhxQqHTT/oAzat7RD5DghvgKs
         SVd9CC8T1/lCIWco75nf1lXjQsnsd1vCb5mz56UybIkBW9ul0LdCvtt6/KhyAHBax0
         XUSRAn0VHvc1MabF+t/CGqnxc05ZqOghi5k20DHk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190929183453.4sehzgovw3ouatdj@localhost>
References: <20190929183453.4sehzgovw3ouatdj@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190929183453.4sehzgovw3ouatdj@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 9bfd7319e8d353b8b81c4cfd4d7eced71adbfbb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cef0aa0ce8592f68fb093b2be0d341a568ff9890
Message-Id: <156986462107.9141.2777289664605265772.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Sep 2019 17:30:21 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, arm@kernel.org,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Sep 2019 11:34:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cef0aa0ce8592f68fb093b2be0d341a568ff9890

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
