Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB76C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D742189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfGXVME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 17:12:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51940 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfGXVMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 17:12:03 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 265871543A186;
        Wed, 24 Jul 2019 14:12:03 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:12:02 -0700 (PDT)
Message-Id: <20190724.141202.10100086363454182.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        gregkh@linuxfoundation.org, bpoirier@suse.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] qlge: Fix build error without CONFIG_ETHERNET
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190724130126.53532-1-yuehaibing@huawei.com>
References: <20190724130126.53532-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jul 2019 14:12:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 24 Jul 2019 21:01:26 +0800

> Now if CONFIG_ETHERNET is not set, QLGE driver
> building fails:
> 
> drivers/staging/qlge/qlge_main.o: In function `qlge_remove':
> drivers/staging/qlge/qlge_main.c:4831: undefined reference to `unregister_netdev'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 955315b0dc8c ("qlge: Move drivers/net/ethernet/qlogic/qlge/ to drivers/staging/qlge/")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

I'll let Greg take this.
