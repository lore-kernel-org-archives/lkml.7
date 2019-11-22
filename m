Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEE1C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558AE206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKVDa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 22:30:56 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57390 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKVDa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 22:30:56 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 27B1515103705;
        Thu, 21 Nov 2019 19:30:55 -0800 (PST)
Date:   Thu, 21 Nov 2019 19:30:54 -0800 (PST)
Message-Id: <20191121.193054.799887281860873787.davem@davemloft.net>
To:     maowenan@huawei.com
Cc:     claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, po.liu@nxp.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] enetc: make enetc_setup_tc_mqprio static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191122025240.8226-1-maowenan@huawei.com>
References: <20191122025240.8226-1-maowenan@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Nov 2019 19:30:55 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>
Date: Fri, 22 Nov 2019 10:52:40 +0800

> While using ARCH=mips CROSS_COMPILE=mips-linux-gnu- command to compile,
> make C=2 drivers/net/ethernet/freescale/enetc/enetc.o
> 
> one warning can be found:
> drivers/net/ethernet/freescale/enetc/enetc.c:1439:5:
> warning: symbol 'enetc_setup_tc_mqprio' was not declared.
> Should it be static?
> 
> This patch make symbol enetc_setup_tc_mqprio static.
> Fixes: 34c6adf1977b ("enetc: Configure the Time-Aware Scheduler via tc-taprio offload")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Applied.
