Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0F3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F97B206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfG2RY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:24:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36418 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfG2RY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:24:29 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5F7DA12BFE6D2;
        Mon, 29 Jul 2019 10:24:28 -0700 (PDT)
Date:   Mon, 29 Jul 2019 10:24:25 -0700 (PDT)
Message-Id: <20190729.102425.1302416507900603310.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     m.grzeschik@pengutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        keescook@chromium.org
Subject: Re: [PATCH] arcnet: com20020-isa: Mark expected switch
 fall-throughs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190729142503.GA7917@embeddedor>
References: <20190729142503.GA7917@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 29 Jul 2019 10:24:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 29 Jul 2019 09:25:03 -0500

> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/net/arcnet/com20020-isa.c: warning: this statement may fall
> through [-Wimplicit-fallthrough=]:  => 205:13, 203:10, 209:7, 201:11,
> 207:8
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
