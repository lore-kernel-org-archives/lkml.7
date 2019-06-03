Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDD0C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEF926D0D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfFCWLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:11:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36120 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfFCWLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:11:21 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AD5D5136E16B0;
        Mon,  3 Jun 2019 15:11:20 -0700 (PDT)
Date:   Mon, 03 Jun 2019 15:11:20 -0700 (PDT)
Message-Id: <20190603.151120.958835957071709710.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de,
        ariel.elior@marvell.com, michal.kalderon@marvell.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] qed: Fix build error without CONFIG_DEVLINK
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190601080605.13052-1-yuehaibing@huawei.com>
References: <20190601080605.13052-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Jun 2019 15:11:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 1 Jun 2019 16:06:05 +0800

> Fix gcc build error while CONFIG_DEVLINK is not set
> 
> drivers/net/ethernet/qlogic/qed/qed_main.o: In function `qed_remove':
> qed_main.c:(.text+0x1eb4): undefined reference to `devlink_unregister'
> 
> Select DEVLINK to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 24e04879abdd ("qed: Add qed devlink parameters table")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
