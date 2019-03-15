Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A390AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD6E218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfCOS0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:26:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60136 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfCOS0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:26:14 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 303FF14D9DD6B;
        Fri, 15 Mar 2019 11:26:14 -0700 (PDT)
Date:   Fri, 15 Mar 2019 11:26:13 -0700 (PDT)
Message-Id: <20190315.112613.282237147383602540.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     joe@perches.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] appletalk: Fix potential NULL pointer dereference
 in unregister_snap_client
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190314054759.17848-1-yuehaibing@huawei.com>
References: <20190314054759.17848-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 Mar 2019 11:26:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Thu, 14 Mar 2019 13:47:59 +0800

> From: YueHaibing <yuehaibing@huawei.com>
> 
> register_snap_client may return NULL, all the callers
> check it, but only print a warning. This will result in
> NULL pointer dereference in unregister_snap_client and other
> places.
> 
> It has always been used like this since v2.6
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: del timer in aarp_proto_init error patch

Applied, thanks for following up.
