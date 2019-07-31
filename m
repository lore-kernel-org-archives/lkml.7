Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2B8C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4813220657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfGaXKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 19:10:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45294 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGaXKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:10:46 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CE1C1126598C9;
        Wed, 31 Jul 2019 16:10:45 -0700 (PDT)
Date:   Wed, 31 Jul 2019 19:10:45 -0400 (EDT)
Message-Id: <20190731.191045.1364878383424980981.davem@davemloft.net>
To:     brgl@bgdev.pl
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fisaksen@baylibre.com, bgolaszewski@baylibre.com
Subject: Re: [PATCH] net: stmmac: Use netif_tx_napi_add() for TX polling
 function
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190730113814.13825-1-brgl@bgdev.pl>
References: <20190730113814.13825-1-brgl@bgdev.pl>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 31 Jul 2019 16:10:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 30 Jul 2019 13:38:14 +0200

> From: Frode Isaksen <fisaksen@baylibre.com>
> 
> This variant of netif_napi_add() should be used from drivers
> using NAPI to exclusively poll a TX queue.
> 
> Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
> Tested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied and queued up for -stable.
