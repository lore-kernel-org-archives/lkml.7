Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180C4CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF28A20650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571826315;
	bh=b8F2m3SFJhpHjXyJAIps/x1YKc8omHwLdZOcjhr733U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=G4vWATOVlxliIp/V/oeNY39ZPRy5KC9Qu9iNxg900tQewFOeDjUn4U0cjyWoGfuT1
	 lu67AAcovwzdmR+W4ZcsvBxhpcuVAnaqbqqZ70aurR8GN07Z+k1f/64ywpFFrzIAFT
	 1ruc1tCooPMYiVc/L6kQ2YObYMHXzdRc9rpjjnME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404403AbfJWKZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391024AbfJWKZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:25:07 -0400
Subject: Re: [GIT PULL] EDAC fix for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571826306;
        bh=b8F2m3SFJhpHjXyJAIps/x1YKc8omHwLdZOcjhr733U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xx5KqGRbPXcoqODN1UtA4yBkarSY/nO5QJE9Hy94+tZ1mc7OEbLDGe2PZKU6Ih2jE
         cAwvpZRIdv/N/O9FchDcS1XNUDDOXzJhZ94UI2Zv/EblwphjyLC+kXWGSsa/ShrSbS
         hPUOOJe5nkpoOn6DeARpT0SRiq12OPGTzk0pm10w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191023073047.GD12272@zn.tnic>
References: <20191023073047.GD12272@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191023073047.GD12272@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
 tags/edac_urgent_for_5.4
X-PR-Tracked-Commit-Id: 1e72e673b9d102ff2e8333e74b3308d012ddf75b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e969c860d56345b2c2efd2bf2b6d8c716bdc1468
Message-Id: <157182630681.4124.17219799857806635866.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Oct 2019 10:25:06 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Oct 2019 09:30:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e969c860d56345b2c2efd2bf2b6d8c716bdc1468

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
