Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041FAC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AF9206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfIPHWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 03:22:55 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44476 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfIPHWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 03:22:54 -0400
Received: from localhost (unknown [85.119.46.8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ED851152483C6;
        Mon, 16 Sep 2019 00:22:51 -0700 (PDT)
Date:   Mon, 16 Sep 2019 09:22:44 +0200 (CEST)
Message-Id: <20190916.092244.764910996352099184.davem@davemloft.net>
To:     alexandru.ardelean@analog.com
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com
Subject: Re: [PATCH v3] net: stmmac: socfpga: re-use the `interface`
 parameter from platform data
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190916070400.18721-1-alexandru.ardelean@analog.com>
References: <20190916070400.18721-1-alexandru.ardelean@analog.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 16 Sep 2019 00:22:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Mon, 16 Sep 2019 10:04:00 +0300

> The socfpga sub-driver defines an `interface` field in the `socfpga_dwmac`
> struct and parses it on init.
> 
> The shared `stmmac_probe_config_dt()` function also parses this from the
> device-tree and makes it available on the returned `plat_data` (which is
> the same data available via `netdev_priv()`).
> 
> All that's needed now is to dig that information out, via some
> `dev_get_drvdata()` && `netdev_priv()` calls and re-use it.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied.
