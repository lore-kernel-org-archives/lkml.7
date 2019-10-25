Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1489ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF81C20867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfJYXWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 19:22:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38440 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfJYXWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 19:22:07 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A57E2148A08FF;
        Fri, 25 Oct 2019 16:22:06 -0700 (PDT)
Date:   Fri, 25 Oct 2019 16:22:03 -0700 (PDT)
Message-Id: <20191025.162203.1070448136525719648.davem@davemloft.net>
To:     ben.dooks@codethink.co.uk
Cc:     linux-kernel@lists.codethink.co.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [V2] net: mvneta: make stub functions static inline
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191023100108.11253-1-ben.dooks@codethink.co.uk>
References: <20191023100108.11253-1-ben.dooks@codethink.co.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 25 Oct 2019 16:22:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Date: Wed, 23 Oct 2019 11:01:08 +0100

> If the CONFIG_MVNET_BA is not set, then make the stub functions
> static inline to avoid trying to export them, and remove hte
> following sparse warnings:
> 
> drivers/net/ethernet/marvell/mvneta_bm.h:163:6: warning: symbol 'mvneta_bm_pool_destroy' was not declared. Should it be static?
> drivers/net/ethernet/marvell/mvneta_bm.h:165:6: warning: symbol 'mvneta_bm_bufs_free' was not declared. Should it be static?
> drivers/net/ethernet/marvell/mvneta_bm.h:167:5: warning: symbol 'mvneta_bm_construct' was not declared. Should it be static?
> drivers/net/ethernet/marvell/mvneta_bm.h:168:5: warning: symbol 'mvneta_bm_pool_refill' was not declared. Should it be static?
> drivers/net/ethernet/marvell/mvneta_bm.h:170:23: warning: symbol 'mvneta_bm_pool_use' was not declared. Should it be static?
> drivers/net/ethernet/marvell/mvneta_bm.h:181:18: warning: symbol 'mvneta_bm_get' was not declared. Should it be static?
> drivers/net/ethernet/marvell/mvneta_bm.h:182:6: warning: symbol 'mvneta_bm_put' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>

Applied, thank you.
