Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3022BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D49026025
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfFCWNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:13:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36144 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfFCWNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:13:30 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D358F136E16B0;
        Mon,  3 Jun 2019 15:13:29 -0700 (PDT)
Date:   Mon, 03 Jun 2019 15:13:29 -0700 (PDT)
Message-Id: <20190603.151329.1880364693299986138.davem@davemloft.net>
To:     grygorii.strashko@ti.com
Cc:     ssantosh@kernel.org, richardcochran@gmail.com, robh+dt@kernel.org,
        nsekhar@ti.com, m-karicheri2@ti.com, w-kwok2@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 04/10] net: ethernet: ti: cpts: add support
 for rftclk selection
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190601104534.25790-5-grygorii.strashko@ti.com>
References: <20190601104534.25790-1-grygorii.strashko@ti.com>
        <20190601104534.25790-5-grygorii.strashko@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Jun 2019 15:13:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Sat, 1 Jun 2019 13:45:28 +0300

> +static int cpts_of_mux_clk_setup(struct cpts *cpts, struct device_node *node)
> +{
> +	unsigned int num_parents;
> +	const char **parent_names;
> +	struct device_node *refclk_np;
> +	struct clk_hw *clk_hw;
> +	u32 *mux_table;
> +	int ret = -EINVAL;

Reverse christmas tree please.

Thank you.
