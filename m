Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE51C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD15217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404143AbfGHTlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:41:40 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57252 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbfGHTlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:41:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0090E133E9BDC;
        Mon,  8 Jul 2019 12:41:36 -0700 (PDT)
Date:   Mon, 08 Jul 2019 12:41:36 -0700 (PDT)
Message-Id: <20190708.124136.118336806940211197.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     csully@google.com, sagis@google.com, jonolson@google.com,
        willemb@google.com, lrizzo@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] gve: fix unused variable/label warnings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190708124350.3470436-1-arnd@arndb.de>
References: <20190708124350.3470436-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 08 Jul 2019 12:41:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon,  8 Jul 2019 14:43:39 +0200

> On unusual page sizes, we get harmless warnings:
> 
> drivers/net/ethernet/google/gve/gve_rx.c:283:6: error: unused variable 'pagecount' [-Werror,-Wunused-variable]
> drivers/net/ethernet/google/gve/gve_rx.c:336:1: error: unused label 'have_skb' [-Werror,-Wunused-label]
> 
> Change the preprocessor #if to regular if() to avoid this.
> 
> Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
