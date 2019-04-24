Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B40C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC1020878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfDXEQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:16:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49800 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfDXEQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 00:16:21 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A6C801423FDC2;
        Tue, 23 Apr 2019 21:16:20 -0700 (PDT)
Date:   Tue, 23 Apr 2019 21:16:18 -0700 (PDT)
Message-Id: <20190423.211618.1009243431874480506.davem@davemloft.net>
To:     taoren@fb.com
Cc:     maximmi@mellanox.com, bgolaszewski@baylibre.com,
        sam@mendozajonas.com, jakub.kicinski@netronome.com, joel@jms.id.au,
        andrew@aj.id.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH net v4] net/ncsi: handle overflow when incrementing mac
 address
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190424014310.24253-1-taoren@fb.com>
References: <20190424014310.24253-1-taoren@fb.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Apr 2019 21:16:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <taoren@fb.com>
Date: Wed, 24 Apr 2019 01:43:32 +0000

> Previously BMC's MAC address is calculated by simply adding 1 to the
> last byte of network controller's MAC address, and it produces incorrect
> result when network controller's MAC address ends with 0xFF.
> 
> The problem can be fixed by calling eth_addr_inc() function to increment
> MAC address; besides, the MAC address is also validated before assigning
> to BMC.
> 
> Fixes: cb10c7c0dfd9 ("net/ncsi: Add NCSI Broadcom OEM command")
> Signed-off-by: Tao Ren <taoren@fb.com>

Applied and queued up for -stable, thanks everyone.
