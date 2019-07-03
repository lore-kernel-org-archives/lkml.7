Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DDEC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE0721882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfGCSbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:31:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60598 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCSbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:31:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4A978140F4EA9;
        Wed,  3 Jul 2019 11:31:52 -0700 (PDT)
Date:   Wed, 03 Jul 2019 11:31:51 -0700 (PDT)
Message-Id: <20190703.113151.206946398577844828.davem@davemloft.net>
To:     hayeswang@realtek.com
Cc:     netdev@vger.kernel.org, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH net] r8152: move calling r8153b_rx_agg_chg_indicate()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1394712342-15778-287-albertk@realtek.com>
References: <1394712342-15778-287-albertk@realtek.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 03 Jul 2019 11:31:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hayes Wang <hayeswang@realtek.com>
Date: Wed, 3 Jul 2019 15:11:56 +0800

> r8153b_rx_agg_chg_indicate() needs to be called after enabling TX/RX and
> before calling rxdy_gated_en(tp, false). Otherwise, the change of the
> settings of RX aggregation wouldn't work.
> 
> Besides, adjust rtl8152_set_coalesce() for the same reason. If
> rx_coalesce_usecs is changed, restart TX/RX to let the setting work.
> 
> Signed-off-by: Hayes Wang <hayeswang@realtek.com>

Applied.
