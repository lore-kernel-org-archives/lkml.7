Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86900C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF87218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfCUUW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:22:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52744 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfCUUW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:22:57 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DE709133E9775;
        Thu, 21 Mar 2019 13:22:56 -0700 (PDT)
Date:   Thu, 21 Mar 2019 13:22:56 -0700 (PDT)
Message-Id: <20190321.132256.242396753611559420.davem@davemloft.net>
To:     harini.katakam@xilinx.com
Cc:     nicolas.ferre@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        harinikatakamlinux@gmail.com
Subject: Re: [PATCH] net: macb: Add null check for PCLK and HCLK
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1553089342-2789-1-git-send-email-harini.katakam@xilinx.com>
References: <1553089342-2789-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Mar 2019 13:22:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@xilinx.com>
Date: Wed, 20 Mar 2019 19:12:22 +0530

> Both PCLK and HCLK are "required" clocks according to macb devicetree
> documentation. There is a chance that devm_clk_get doesn't return a
> negative error but just a NULL clock structure instead. In such a case
> the driver proceeds as usual and uses pclk value 0 to calculate MDC
> divisor which is incorrect. Hence fix the same in clock initialization.
> 
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>

Applied, thanks.
