Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E153C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE8F21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554273315;
	bh=mO3754w3wDUWhZ5jXRnbFWuo4Fstd8Su13klgkfy4to=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=maGpjJbWk4yPD9ae9qly64Bzw3tUHfUJn74wQ7UjGfx4/OCyY54NBr23gy2OgHKoX
	 fUda2N++cEAbFsx6eP0+eqQl7SO9hOvif0YsRvZIRdry6D/4iXNT3WKPzqsUG9Hbre
	 THFzboDAARdUKH9kEQzNY2vnqQqLe8KIvPygsxKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfDCGfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbfDCGfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:35:09 -0400
Subject: Re: [GIT PULL] hwmon fixes for hwmon-for-v5.1-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554273308;
        bh=mO3754w3wDUWhZ5jXRnbFWuo4Fstd8Su13klgkfy4to=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JQrbc1sPaSFHV9cWjnknVHraT76uTm6C8mQ+xc5Pz5xUcBncHZGZJPrQ45/oS7QGp
         fH3V5RC8QfJHLOpqVVLgh2Si9N8UZVUaj8TM52h6P9Qv+/5MLp8Km/aQIlOgQnHrab
         Gy5KYdGSVAmCp7XTmm6trBKAg2i35hRd3ubzhwR8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1554216236-7074-1-git-send-email-linux@roeck-us.net>
References: <1554216236-7074-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1554216236-7074-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.1-rc4
X-PR-Tracked-Commit-Id: d3b018f757560ab5c2bce0e7f46e0c1510d7afd4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a3164e3d7be0e38a706f4345f418f2e31928332
Message-Id: <155427330877.25996.2134314400473579488.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Apr 2019 06:35:08 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  2 Apr 2019 07:43:56 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a3164e3d7be0e38a706f4345f418f2e31928332

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
