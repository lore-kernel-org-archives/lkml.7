Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47C5CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21C4217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572637206;
	bh=4s8kkFjDHSBB9ziGWMKgy53QMczI/E5GrCnwYN/RUyQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oLvqHUVvMHTHotej75teUR2sZM+o7r//XFpFhZVIr2VpUFzA6UlUcjtdoejS2N9sY
	 08eVR8x7zt1GQTe2z6dhgUfB6xsJlgdsS1R7eFrgCKdvIm8sRrxG52a7uyEQWqA8n4
	 B6qmM2LjdmUx7xUQcDfPr1fCmsAgrY+5V7FZ9C0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfKATkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfKATkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:40:05 -0400
Subject: Re: [PULL RESEND] virtio: fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572637204;
        bh=4s8kkFjDHSBB9ziGWMKgy53QMczI/E5GrCnwYN/RUyQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hB34jki1umUDR2s6uEc4UODACvC5P/wxEjErnSCcnv+kG75P0sltDXREUoXP+Sefz
         D0sz838gEl1QZtVZfEHzUHN9xbMOq9w8IVOsMTW8AsrdUAj7ib3S2XY0m83M/vsOwb
         8qMcTc7pgBB/onqN4gy6H26RvZbpUXIpSI90CLLY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191028042900-1-mutt-send-email-mst@kernel.org>
References: <20191028042900-1-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191028042900-1-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: b3683dee840274e9997d958b9d82e5de95950f0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e5eefba3d098d66defa1ce59a34a41a96f49771
Message-Id: <157263720474.9839.17625724873379326376.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Nov 2019 19:40:04 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, yong.liu@intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Nov 2019 15:33:57 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e5eefba3d098d66defa1ce59a34a41a96f49771

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
