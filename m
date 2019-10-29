Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D661CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068D220856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfJ2Xmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 19:42:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33018 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfJ2Xmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:42:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BECA514EBE2D4;
        Tue, 29 Oct 2019 16:42:49 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:42:49 -0700 (PDT)
Message-Id: <20191029.164249.1707480773387143512.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     epomozov@marvell.com, igor.russkikh@aquantia.com,
        sergey.samoilenko@aquantia.com, dmitry.bezrukov@aquantia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: aquantia: fix error handling in
 aq_ptp_poll
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191028070447.GA3659@embeddedor>
References: <20191028070447.GA3659@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 29 Oct 2019 16:42:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 28 Oct 2019 02:04:47 -0500

> Fix currenty ignored returned error by properly checking *err* after
> calling aq_nic->aq_hw_ops->hw_ring_hwts_rx_fill().
> 
> Addresses-Coverity-ID: 1487357 ("Unused value")
> Fixes: 04a1839950d9 ("net: aquantia: implement data PTP datapath")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
