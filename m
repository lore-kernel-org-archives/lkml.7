Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BDFC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDE22166E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfENWmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:42:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59788 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfENWmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:42:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 01A9414C048B7;
        Tue, 14 May 2019 15:42:36 -0700 (PDT)
Date:   Tue, 14 May 2019 15:42:36 -0700 (PDT)
Message-Id: <20190514.154236.2269798493150074980.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     paulus@samba.org, gnault@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2] ppp: deflate: Fix possible crash in deflate_init
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190514145532.21932-1-yuehaibing@huawei.com>
References: <20190514074300.42588-1-yuehaibing@huawei.com>
        <20190514145532.21932-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 14 May 2019 15:42:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 14 May 2019 22:55:32 +0800

> BUG: unable to handle kernel paging request at ffffffffa018f000
 ...
> If ppp_deflate fails to register in deflate_init,
> module initialization failed out, however
> ppp_deflate_draft may has been regiestred and not
> unregistered before return.
> Then the seconed modprobe will trigger crash like this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: also check ppp_deflate_draft registration

Applied and queued up for -stable, thanks.
