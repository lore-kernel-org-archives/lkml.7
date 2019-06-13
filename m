Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173B7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68F121537
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbfFMU7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:59:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60142 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfFMU7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:59:17 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A99C2149B0A3E;
        Thu, 13 Jun 2019 13:59:16 -0700 (PDT)
Date:   Thu, 13 Jun 2019 13:59:13 -0700 (PDT)
Message-Id: <20190613.135913.137368160395815937.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     olteanv@gmail.com, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: sja1105: Make two functions static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190611135834.21080-1-yuehaibing@huawei.com>
References: <20190611135834.21080-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Jun 2019 13:59:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 11 Jun 2019 21:58:34 +0800

> Fix sparse warnings:
> 
> drivers/net/dsa/sja1105/sja1105_main.c:1848:6:
>  warning: symbol 'sja1105_port_rxtstamp' was not declared. Should it be static?
> drivers/net/dsa/sja1105/sja1105_main.c:1869:6:
>  warning: symbol 'sja1105_port_txtstamp' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
