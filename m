Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF31C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A8D206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574543405;
	bh=tPLd1xVP7HkeCNRMMZFLexLDaHyo3UVyGY7DeCnDV/U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HSc2bqExYaVz0MHShqQNOyy7LhAnf0k+J76A5lN6M0AJWpc60T7eVYgzMOY75gnR7
	 bHAxuFyEYJ3BtHlheSdmKZ/tveA3KRB3a3tbXnNbozdzSTapj+gxIGcbA2CNU8EXSc
	 EIYVfrymdsYguDhccWZpGzeQzUeCeoSqwRPyql5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKWVKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 16:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfKWVKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 16:10:04 -0500
Subject: Re: [PULL] virtio: last minute bugfixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574543404;
        bh=tPLd1xVP7HkeCNRMMZFLexLDaHyo3UVyGY7DeCnDV/U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=W5UIl7bsRlUUmcch1NKirmYya0Vld2PXT2Lv4WMByRSawXZ61a1uTroR+fknfZWPR
         HQxQW6vWxZi5iX2LXyp+rxaAG+JHXuJMhM4NraNACEwGiHliHCjc1PlxhO2OF8FTSq
         /g6ki+pJy19kgKir9X2RfVXulxvN6dErpdjags80=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191123115552-mutt-send-email-mst@kernel.org>
References: <20191123115552-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191123115552-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: c9a6820fc0da2603be3054ee7590eb9f350508a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b8a794678763130b7e7d049985008641dc494e8
Message-Id: <157454340405.11312.14684199337068886948.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Nov 2019 21:10:04 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mst@redhat.com, khazhy@google.com, lvivier@redhat.com,
        mimu@linux.ibm.com, pasic@linux.ibm.com, wei.w.wang@intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 Nov 2019 11:55:52 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b8a794678763130b7e7d049985008641dc494e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
