Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36748C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 17:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AF420882
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 17:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569174926;
	bh=xeocLIKAnE7G1EeT5VKuX7zoKU9+S+YrVhVFe2P8x6g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wrDy5DD70+xrqRGFgF1FDSXTrH7tb9Yj9R0/Al1Yui1T3CgYcRyqy0mH2AcaSXnRY
	 I5X6ENJIhZthbzaTLeTB/KV0mJLK9wW+p11Z+sV5N4wbDti12Y+u2zEPb6IkRUW1J5
	 CfcKm05Bhah+MciIn0doQN1drrYQsaNRiSOFbqew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbfIVRzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 13:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfIVRzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 13:55:25 -0400
Subject: Re: [GIT PULL] Modules updates for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569174924;
        bh=xeocLIKAnE7G1EeT5VKuX7zoKU9+S+YrVhVFe2P8x6g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oDFyKxwL1ZR/XcG7uwDwSQ68cRK8NoSW7RvNgCHnVkXDwVy+0f/fM7EavZ+eCDDCR
         1YGPOYT8o1aK5kNOjopV18W7CZrOk5L2thHbWfNnLCySjA5oVlZIRUgK4ezxnZCyxN
         NAvc2vFZXAl3E1J3igJ1Y2KUxA6CXRyBUxEvBUjM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190922152809.GA27554@linux-8ccs>
References: <20190922152809.GA27554@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190922152809.GA27554@linux-8ccs>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.4
X-PR-Tracked-Commit-Id: 2e6fcfeb9df6048a63fe0d5f7dfa39274bacbb71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0703556644a531e50b5dc61b9f6ea83af5f6604
Message-Id: <156917492433.22511.7725238151168356068.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Sep 2019 17:55:24 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthias Maennich <maennich@google.com>,
        Martijn Coenen <maco@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Sep 2019 17:28:09 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0703556644a531e50b5dc61b9f6ea83af5f6604

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
