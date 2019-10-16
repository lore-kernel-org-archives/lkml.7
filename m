Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB68C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FE720854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391153AbfJPD4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:56:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44262 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733277AbfJPD43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:56:29 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D3A2A12EEA661;
        Tue, 15 Oct 2019 20:56:28 -0700 (PDT)
Date:   Tue, 15 Oct 2019 20:56:28 -0700 (PDT)
Message-Id: <20191015.205628.1701790705408520886.davem@davemloft.net>
To:     ben.dooks@codethink.co.uk
Cc:     linux-kernel@lists.codethink.co.uk, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] davinci_cpdma: make cpdma_chan_split_pool static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191015161558.18506-1-ben.dooks@codethink.co.uk>
References: <20191015161558.18506-1-ben.dooks@codethink.co.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 15 Oct 2019 20:56:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Date: Tue, 15 Oct 2019 17:15:58 +0100

> The cpdma_chan_split_pool() function is not used outside of
> the driver, so make it static to avoid the following sparse
> warning:
> 
> drivers/net/ethernet/ti/davinci_cpdma.c:725:5: warning: symbol 'cpdma_chan_split_pool' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied, thanks.
