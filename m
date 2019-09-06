Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A978C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85212070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567785912;
	bh=6dKqhgHm+LF4MKNxNOJfMbZ8mldeK+fKzvmBs20KYGA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sujpI37CR+h1P0QUWHtK0MsrLOHDwP7ZJKmvU7fMf4D/vXzKX6k54/x4jmIPLpJ0T
	 dJTNH7HKZgnvfnx5w1PiSG/+9kcb/O89Pg+90ruIsjzgSIIe2R459JCN/jVWk44PFA
	 EpMu+0nyeeaqND45Wxseyg+AWeWYS+YERwR0IjTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392214AbfIFQFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392102AbfIFQFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:05:07 -0400
Subject: Re: [PULL] vhost, virtio: last minute fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567785907;
        bh=6dKqhgHm+LF4MKNxNOJfMbZ8mldeK+fKzvmBs20KYGA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sxSJKpT53C48cNP3QTWWR1YL/uamT1Lq4S08NoR3g7HXAvQoRBBd89dr28qJOujuT
         WGMEVQDUyboqrradEl1dLNmYucJNt51UkPP1w9LmXd2dl2TnBCvkWykPnG1ly63RNy
         99/8h9vVmlPyvqckxH/tOkJdMsPJUzCJmxdIz0I4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190906094103-mutt-send-email-mst@kernel.org>
References: <20190906094103-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190906094103-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 02fa5d7b17a761f53ef1eedfc254e1f33bd226b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d098a6234c135c3fd1692fc451908b5c2a43244
Message-Id: <156778590706.8517.1772605570873720347.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Sep 2019 16:05:07 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, jiangkidd@hotmail.com, linyunsheng@huawei.com,
        mst@redhat.com, namit@vmware.com, tiwei.bie@intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Sep 2019 09:41:03 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d098a6234c135c3fd1692fc451908b5c2a43244

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
