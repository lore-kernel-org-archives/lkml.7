Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C5AC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A359A21E6B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbfGWBTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:19:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52506 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbfGWBTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 21:19:07 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 98D6F15305A0F;
        Mon, 22 Jul 2019 18:19:06 -0700 (PDT)
Date:   Mon, 22 Jul 2019 18:19:06 -0700 (PDT)
Message-Id: <20190722.181906.2225538844348045066.davem@davemloft.net>
To:     liuyonglong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, salil.mehta@huawei.com,
        yisen.zhuang@huawei.com, shiju.jose@huawei.com
Subject: Re: [PATCH net] net: hns: fix LED configuration for marvell phy
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1563775152-21369-1-git-send-email-liuyonglong@huawei.com>
References: <1563775152-21369-1-git-send-email-liuyonglong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Jul 2019 18:19:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>
Date: Mon, 22 Jul 2019 13:59:12 +0800

> Since commit(net: phy: marvell: change default m88e1510 LED configuration),
> the active LED of Hip07 devices is always off, because Hip07 just
> use 2 LEDs.
> This patch adds a phy_register_fixup_for_uid() for m88e1510 to
> correct the LED configuration.
> 
> Fixes: 077772468ec1 ("net: phy: marvell: change default m88e1510 LED configuration")
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Reviewed-by: linyunsheng <linyunsheng@huawei.com>

Applied and queued up for -stable.
