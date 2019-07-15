Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39878C742D2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BA220820
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563150606;
	bh=K+QhQzq2u6E1eSAttnH4vXdAcH/ATqIhPSBVWgmM4B4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rJj+MOGMhZxdfSQT6QA0tnew2CjKViT+YKOjDLIjWFUocDM2yALnNB9oqoCoiFurx
	 SFUZH6q+xU2DZYKWvFvJInidhI60Xxann36tYMwDN+y+2A1CUCB7maBxwipgOsfCqJ
	 bWKyPzA6w7nDzXCygxekxDgwCPj9MCHvYaov1Udw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfGOAaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbfGOAaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:30:03 -0400
Subject: Re: [PULL] stream_open bits for Linux 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563150602;
        bh=K+QhQzq2u6E1eSAttnH4vXdAcH/ATqIhPSBVWgmM4B4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wREaXcRbnyjsoF9xozCulPSNFGrv4ZCjtIEjn6KbPtYq4q2h7/hcrDnMp8E9Hh0o5
         P7MOLX8jjinm3ej2wuXRkBxtX8X1Dw1nMdfny3daBGm2zqxHBD76G1XsHiMNkF7kxq
         2cMeW3QtZrG64ONyK7dh8BwKa4FwTA/VYwHuWLgc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190714141317.GA20277@deco.navytux.spb.ru>
References: <20190714141317.GA20277@deco.navytux.spb.ru>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190714141317.GA20277@deco.navytux.spb.ru>
X-PR-Tracked-Remote: https://lab.nexedi.com/kirr/linux.git stream_open-5.3
X-PR-Tracked-Commit-Id: 3975b097e577bac77267ed8df0f525e3ad3499ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcd98147ac71f35b69e2f50b5fddc5524dd2dfa8
Message-Id: <156315060268.32091.6748401501797941411.pr-tracker-bot@kernel.org>
Date:   Mon, 15 Jul 2019 00:30:02 +0000
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Jan Blunck <jblunck@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <cocci@systeme.lip6.fr>, <linux-input@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Jul 2019 14:13:45 +0000:

> https://lab.nexedi.com/kirr/linux.git stream_open-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcd98147ac71f35b69e2f50b5fddc5524dd2dfa8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
