Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C32C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1C7206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfGaQHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:07:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39758 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaQHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:07:21 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 113BC140AD8FF;
        Wed, 31 Jul 2019 09:07:21 -0700 (PDT)
Date:   Wed, 31 Jul 2019 09:07:20 -0700 (PDT)
Message-Id: <20190731.090720.391196858300492585.davem@davemloft.net>
To:     gregkh@linuxfoundation.org
Cc:     willy@infradead.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, yuehaibing@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging/octeon: Fix build error without
 CONFIG_NETDEVICES
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190731160219.GA2114@kroah.com>
References: <20190731160219.GA2114@kroah.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 31 Jul 2019 09:07:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 31 Jul 2019 18:02:19 +0200

> From: YueHaibing <yuehaibing@huawei.com>
> 
> While do COMPILE_TEST build without CONFIG_NETDEVICES,
> we get Kconfig warning:
> 
> WARNING: unmet direct dependencies detected for PHYLIB
>   Depends on [n]: NETDEVICES [=n]
>   Selected by [y]:
>   - OCTEON_ETHERNET [=y] && STAGING [=y] && (CAVIUM_OCTEON_SOC && NETDEVICES [=n] || COMPILE_TEST [=y])
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Reported-by: Mark Brown <broonie@kernel.org>
> Fixes: 171a9bae68c7 ("staging/octeon: Allow test build on !MIPS")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to net-next.
