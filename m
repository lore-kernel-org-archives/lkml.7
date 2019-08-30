Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50432C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6CE2087F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567183215;
	bh=DwJ5QL1IgRhDoDed8hrJO9utYSBqhOTG7di5yDCqf/E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zLhtTDgcYuNSyPDC4LGkuZRwai4udySq7TsGRiBGLXlIMcpl1HLGHtieVhUrou0sj
	 vxHS2IC5EKJJ7334YiH7X5WyA9C73d+0g9+bYFh7mQoGt8ZCF7y1IH/bg5wEuqdgSj
	 BE8J2Ml3sKkrxpFexOTGRxkmm+ZPu7oBOejvBhmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfH3QkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbfH3QkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:40:10 -0400
Subject: Re: [PULL REQUEST] Please pull rdma.git
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567183209;
        bh=DwJ5QL1IgRhDoDed8hrJO9utYSBqhOTG7di5yDCqf/E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nOvjo2Z2qJhdbf2ztkxPlOx4/WJH13FAEyH7+3rRhS9VqyU7fCN0gMDGlLD1Sumjp
         MqFC0xRWkTjnx7O39BLbofTh8ZYwlAqb50qAonvm+9mdbj1p4txhZgyz5NYOq36+rR
         WIPFnLSIYTiC+/ETlypvIUNwu8zo01/UW4IuQ2OI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cef8e627336f4a85b2860fd9bde25c71aef7e194.camel@redhat.com>
References: <cef8e627336f4a85b2860fd9bde25c71aef7e194.camel@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cef8e627336f4a85b2860fd9bde25c71aef7e194.camel@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 531a64e4c35bb9844b0cf813a6c9a87e00be05ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fb8e9e46261e0117cb3cffb6dd8bb7e08f8649b
Message-Id: <156718320971.32023.18221065529586097085.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Aug 2019 16:40:09 +0000
To:     Doug Ledford <dledford@redhat.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Aug 2019 11:42:36 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fb8e9e46261e0117cb3cffb6dd8bb7e08f8649b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
