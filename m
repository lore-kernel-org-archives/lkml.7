Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233AEC4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 18:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90162196E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 18:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569089729;
	bh=/SsYhComEN4S1FrwRkyBrwL7UDfxZ1mFJAKMOXx7ocM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2LVtmEo2+DWMfidlu5BKdjc6hWzg40EWrLBQS9ohx0/d3ry3DV3jPRseAAa2wMIoU
	 yGhAx6SdwylqKvu9UPr+XFDyBU/pNi/mJN9Nx/77jd/kneJ9AWUj8wlpCbXljazBLP
	 0jG5IM3GpyRP5jRJ+K7DQ29CH7APb4L0NeBxNU4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbfIUSP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 14:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731233AbfIUSPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 14:15:25 -0400
Subject: Re: [GIT PULL] UBI/UBIFS/JFFS2 updates for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569089725;
        bh=/SsYhComEN4S1FrwRkyBrwL7UDfxZ1mFJAKMOXx7ocM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j5jgx1ciiClxji32isQYJC5F6rqS0Xeeu0D4nOySPirwF+McIXF/+3AOxbx+VYrvZ
         xQQMdOPyT8+UvUErCLuenzzr1VgLX4+iEt6gxVIof/ESqAv3cDhX220BHYqJI8WKVt
         oQdKKnQMjiiB4hIs6PawC7xkkTjsXnrGhn+8cCeg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1224182178.3529.1569051402039.JavaMail.zimbra@nod.at>
References: <1224182178.3529.1569051402039.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1224182178.3529.1569051402039.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git
 tags/upstream-5.4-rc1
X-PR-Tracked-Commit-Id: 6a379f67454a3c740671ed6c7793b76ffecef50b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 104c0d6bc43e10ba84931c45b67e2c76c9c67f68
Message-Id: <156908972540.32474.6167862187176290736.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 18:15:25 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Sep 2019 09:36:42 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/upstream-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/104c0d6bc43e10ba84931c45b67e2c76c9c67f68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
