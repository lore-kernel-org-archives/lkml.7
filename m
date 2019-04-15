Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B902CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEBD2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfDOUKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:10:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57422 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbfDOUKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:10:54 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3169C14D8ADA5;
        Mon, 15 Apr 2019 13:10:53 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:10:50 -0700 (PDT)
Message-Id: <20190415.131050.1131678481288440475.davem@davemloft.net>
To:     wanghai26@huawei.com
Cc:     idosch@mellanox.com, eric.dumazet@gmail.com,
        alexander.h.duyck@intel.com, tyhicks@canonical.com,
        f.fainelli@gmail.com, viro@zeniv.linux.org.uk,
        amritha.nambiar@intel.com, joe@perches.com,
        dmitry.torokhov@gmail.com, andriy.shevchenko@linux.intel.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "net-sysfs: Fix memory leak in
 netdev_register_kobject"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190412203634.30392-2-wanghai26@huawei.com>
References: <20190412203634.30392-1-wanghai26@huawei.com>
        <20190412203634.30392-2-wanghai26@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Apr 2019 13:10:53 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai26@huawei.com>
Date: Fri, 12 Apr 2019 16:36:33 -0400

> This reverts commit 6b70fc94afd165342876e53fc4b2f7d085009945.
> 
> The reverted bugfix will cause another issue.
> Reported by syzbot+6024817a931b2830bc93@syzkaller.appspotmail.com.
> See https://syzkaller.appspot.com/x/log.txt?x=1737671b200000 for
> details.
> 
> Signed-off-by: Wang Hai <wanghai26@huawei.com>

I'll just apply this by itself.

Thanks Wang.
