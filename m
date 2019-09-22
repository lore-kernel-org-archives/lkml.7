Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB02FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B4C20882
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179436;
	bh=tZPM+pubtwBOZcTsufd7UjWLp652jsKzoNEJy/D30AA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=133LlU96baGM9s55in1E4Pv21NGYk4Yo0sU4LtncllpuD0KxPgABVUHCHTCXdKoWZ
	 V1eKBWlHJbG1BppO/VE937YWAEKsUpGoe/Z4AqPa98DlaGvvhvzsrvwl7qvUmwgNgJ
	 iqMcbOe1ROhvMLDAdiUxK+8ZCBgzeBDzeE+IvEfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395451AbfIVTKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395032AbfIVTKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 15:10:24 -0400
Subject: Re: [GIT PULL] power-supply changes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569179424;
        bh=tZPM+pubtwBOZcTsufd7UjWLp652jsKzoNEJy/D30AA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QHzsgyLb9NQ0lS2ain07halm4PBIQutLRCz/lgdmRZ/Hnn/jFoL6Yr/P8LvRrxhgV
         JS+JTlyfO5CiWgRhhs090oEhCKr4W/DFQBL6STvUDxKwF55t4qY3LkvAPcHxXOj4Cr
         r2POaNuGZpHhbR0HgxUw0jzGdTax51ElRAvD9Ngk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190922160355.7f5snmbvwlykekxb@earth.universe>
References: <20190922160355.7f5snmbvwlykekxb@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190922160355.7f5snmbvwlykekxb@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 tags/for-v5.4
X-PR-Tracked-Commit-Id: 7f7378618b4103c083db7de5017df958f8ada070
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 619e17cf75dd58905aa67ccd494a6ba5f19d6cc6
Message-Id: <156917942442.29484.11774927040556504593.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Sep 2019 19:10:24 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Sep 2019 18:03:55 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/619e17cf75dd58905aa67ccd494a6ba5f19d6cc6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
