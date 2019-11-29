Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A412C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679CB21781
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfK2L6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:58:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:50934 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbfK2L6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:58:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0230BABD0;
        Fri, 29 Nov 2019 11:58:38 +0000 (UTC)
Date:   Fri, 29 Nov 2019 12:58:37 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     joe@perches.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, tj@kernel.org, arnd@arndb.de,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Subject: Re: [PATCH 0/4] part2: kill pr_warning from kernel
Message-ID: <20191129115837.7hzuyqlmhbqsi4zm@pathway.suse.cz>
References: <20191128004752.35268-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128004752.35268-1-wangkefeng.wang@huawei.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-11-28 08:47:48, Kefeng Wang wrote:
> This is the part2 of kill pr_warning, as most pr_warning conversion merged
> into v5.5, let's cleanup the last two stragglers. Then, completely drop
> pr_warning defination in printk.h and check in checkpatch.pl.
> 
> Part1: https://lore.kernel.org/lkml/20190920062544.180997-1-wangkefeng.wang@huawei.com
> 
> Kefeng Wang (4):
>   workqueue: Use pr_warn instead of pr_warning
>   staging: isdn: gigaset: Use pr_warn instead of pr_warning

This one is already in mainline via staging tree.

>   printk: Drop pr_warning definition
>   checkpatch: Drop pr_warning check

The other patches are committed in printk.git, branch
for-5.5-pr-warning-removal.

I am going to sent pull request after 5.5-rc1 is tagged.
It is should be fine according to linux-next. But I am not
sure if all coming changes are really tested in linux-next.

Best Regards,
Petr
