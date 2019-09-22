Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CF3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E00C2070C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179135;
	bh=+y7h6jSDpQIPm1Db+JDwlbsHYiX0vUY9rpUyAPf3vu4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=eXHXujY+txfRngZmyJQeRQEDbBUUYKtwMrDlD51J1vjeW3B2V7bNmwqv1CCYEOL+s
	 z/5yEB65GkY4mIaLiDlHyXspNW19CwgX+xiYJPkChO9TigB9fB+FP5yoEXCEq6iy7p
	 mrxrRGPmphTnGP2xf3Sp/9r9Ny+PhU9gIUkLvh7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfIVTF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbfIVTFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 15:05:25 -0400
Subject: Re: [GIT PULL] soundwire updates for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569179125;
        bh=+y7h6jSDpQIPm1Db+JDwlbsHYiX0vUY9rpUyAPf3vu4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DNpYD5e1tbxFs+Zv3kJ0KXiEh2I4+mCWc2ZwRkVgab80PIFHkEzUt4GtcYOVh0/IG
         QFXzADxNvLt6JcMYt4Sg2mToRA3SVMbIgdNfLPsrP8ZFyzwynogXbRiXayR6LeRCgB
         ychfpOEkUuJ6oAYBbNO6BGyhQuUuW2VZsZyt8W0c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190920140247.GX4392@vkoul-mobl>
References: <20190920140247.GX4392@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190920140247.GX4392@vkoul-mobl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git
 tags/soundwire-5.4-rc1
X-PR-Tracked-Commit-Id: dfcff3f8a5f18a0cfa233522b5647c2e6035fcb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d7ead5c69dfa928322777c532fa0770af319202
Message-Id: <156917912529.24588.5674912701554665464.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Sep 2019 19:05:25 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Sep 2019 19:32:47 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d7ead5c69dfa928322777c532fa0770af319202

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
