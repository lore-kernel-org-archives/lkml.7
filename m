Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F6CC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DFD20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554915011;
	bh=NQlai9R/Pq8mylT7/8AiIG9EJdLsBwC3FvYqg3ghYrw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DBeb2PxyjuRlsQUrWycuO9wZwR2RI4eqZM/wsCuJQTCiGX8QD/fU0z3Nm0prE+2P7
	 WCg0KUAvSgUls1lSvq14B+/cm7pzub5OTMBDvVCbUloeP2+DW1fGZwfkkJkNA8TKAa
	 jblHHqJiHM8VmDH3q2IjgmXmqNnusl376h5uTSzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbfDJQuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733035AbfDJQuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:50:06 -0400
Subject: Re: [PULL] virtio: fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554915005;
        bh=NQlai9R/Pq8mylT7/8AiIG9EJdLsBwC3FvYqg3ghYrw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pbKyKubmZxwJqliTl1NOkc7l6+16espReVJjL67GDwNvPTO9E/F9XCvJgw22cxXb7
         +V2G5/2wIzyS6XapWH4rCIRtAkh//+rAYVKyu05UGoVt9UiRsRbzZ+YFJpQM80L1Eb
         t4ql7vzdzLVg1yoCURMny7WW6TfLoepSUjeH46bM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190410091858-mutt-send-email-mst@kernel.org>
References: <20190410091858-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190410091858-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: cf94db21905333e610e479688add629397a4b384
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed79cc87302bf7fbc87f05d655b998f866b4fed8
Message-Id: <155491500587.22837.2250351178461268331.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Apr 2019 16:50:05 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arei.gonglei@huawei.com, cohuck@redhat.com, longpeng2@huawei.com,
        mst@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Apr 2019 09:18:58 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed79cc87302bf7fbc87f05d655b998f866b4fed8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
