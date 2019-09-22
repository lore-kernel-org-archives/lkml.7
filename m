Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7E6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1271520882
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179452;
	bh=V1reMLSGjw9s7BYOmYPwjhBvV2o54hjG51I+J+Wcl1U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=110L6nMhFXEzpDJQ/PzZnOLVzDCXQ7UX4Y39c8/ezvX9wpEgjrC7DxtO0+Rthf4Nn
	 U2C3OkoLe+7oOr7ZmORIQpE7Acmpp+39Efet3ZBaiBQf7JkWtZaiF14BJwykcK9c6V
	 z+SutGRSI8diE5sOEnoUTkRL/bQpXgIUVmn6f0t0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389891AbfIVTKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393794AbfIVTKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 15:10:23 -0400
Subject: Re: [GIT PULL] hsi changes for hsi-5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569179422;
        bh=V1reMLSGjw9s7BYOmYPwjhBvV2o54hjG51I+J+Wcl1U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k0fc3vR+F91jss4EHfyHhVc7eO4N+pcBJZPwHPQv32eW36XucomNlbCKGGhIxsDbE
         6jREFMBRvXbW59NtD4skk9ypTcmBk8Ph2+OURKnwjjNDeBP/zSsKcKTG1yeNJxksx7
         utodoHae0sDmOBb7qWKzGP/wjTm4xFKlzfltNs1Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190922160206.qqsrupqvtly4akhn@earth.universe>
References: <20190922160206.qqsrupqvtly4akhn@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190922160206.qqsrupqvtly4akhn@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git
 tags/hsi-for-5.4
X-PR-Tracked-Commit-Id: c1030cd456198a2c58f718c3c4b215698d635553
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57f1c3caf5137d4493fcd1d07c3ae4a5636f4949
Message-Id: <156917942288.29484.18265056100390989150.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Sep 2019 19:10:22 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Sep 2019 18:02:06 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57f1c3caf5137d4493fcd1d07c3ae4a5636f4949

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
