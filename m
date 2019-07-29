Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928F8C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B2820C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564425622;
	bh=pOrk3tU71dZX+Rcd0VhYhQmj36JdpwLj+USN8H0R2RQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nHOApIM/TM8inXXblpJ5gxYWuylVkKj6+Ob1MdInkIE+4+OwWrTtfsXfplXVQbAdI
	 3+H+yflyAPR+dmze8Bc4EDU/N5+RnV+Q4U4cOc0lwUgHEM43GxxFbGOm2KUE1HQG7Z
	 JV1BGZDy6zlu3Gxfq6IyLjLRe7tvvpdnkJpa0DUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbfG2SkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfG2SkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:40:19 -0400
Subject: Re: [PULL] vhost,virtio: cleanups and fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564425618;
        bh=pOrk3tU71dZX+Rcd0VhYhQmj36JdpwLj+USN8H0R2RQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iS/iiZeCxsWwHuTw4DA+P/VSujfoGU7q3H2maGCYU4rW0DUUmdvtoIqgX+ezb2yjS
         t+d/qQh1X/esvCv/CpXu8K3On1g0lf5/nLj7/sviPpMhsC7VU6YdTdF6oKOOTrzCv2
         b8NkV0O/NqpG/r9gTGfYVTuCiBivyIzHPdMXkNms=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190729121605-mutt-send-email-mst@kernel.org>
References: <20190729121605-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190729121605-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 73f628ec9e6bcc45b77c53fe6d0c0ec55eaf82af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a11c76e5301dddefcb618dac04f74e6314df6bc
Message-Id: <156442561858.16864.7993993619692997992.pr-tracker-bot@kernel.org>
Date:   Mon, 29 Jul 2019 18:40:18 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com, jean-philippe@linaro.org, jroedel@suse.de,
        mst@redhat.com, namit@vmware.com, wei.w.wang@intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 29 Jul 2019 12:16:05 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a11c76e5301dddefcb618dac04f74e6314df6bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
