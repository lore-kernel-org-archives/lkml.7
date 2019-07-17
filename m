Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC22C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD892184B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563388207;
	bh=SsgEQ229BFDzVjWE4Rfd94cxbm2rr6++cJP0jupJNlI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=riavyI6a1GaLqvjjrhgqKgU8v7r6Do+f+0HiqlJaguA1a5PX+O50mK2lOM34AMmrs
	 uFrsKaMhAHj1G7yct0NXq3DqG/27JOsgOEry47N3zLB4t32ILUbcct+6kNy/QOn5EQ
	 I7/PIw1LG575qU4KPEy0/dNICuNnp7JhSuq/RlIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbfGQSaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 14:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbfGQSaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 14:30:04 -0400
Subject: Re: [PULL] virtio, vhost: fixes, features, performance
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563388203;
        bh=SsgEQ229BFDzVjWE4Rfd94cxbm2rr6++cJP0jupJNlI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1OMBw+NNcoYT1euAQa76cEb1EnJLTbURZO01B9VLtWDbz6o2ygQuSEU/k5bwly/JN
         I9WKTyRViJihLBuveQwr15VdePBK/oENdwCbcZIOCueP649B9L4SUwnKWdXebZmJ3r
         0AOCFDDnCBkwuFhQ3rgUh397M2+y0SfUzso6xWjs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190716113151-mutt-send-email-mst@kernel.org>
References: <20190716113151-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190716113151-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 5e663f0410fa2f355042209154029842ba1abd43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a1d5384b7decbff6519daa9c65a35665e227323
Message-Id: <156338820366.716.10416228849149522179.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jul 2019 18:30:03 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, bharat.bhushan@nxp.com, bhelgaas@google.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, davem@davemloft.net,
        eric.auger@redhat.com, gustavo@embeddedor.com, hch@infradead.org,
        ihor.matushchak@foobox.net, James.Bottomley@hansenpartnership.com,
        jasowang@redhat.com, jean-philippe.brucker@arm.com,
        jglisse@redhat.com, mst@redhat.com, natechancellor@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Jul 2019 11:31:51 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a1d5384b7decbff6519daa9c65a35665e227323

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
