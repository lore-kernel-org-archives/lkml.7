Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5747DC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE8D20640
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441427AbfIXOpb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:45:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52592 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfIXOpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:45:31 -0400
Received: from localhost (231-157-167-83.reverse.alphalink.fr [83.167.157.231])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DB0881527F8DE;
        Tue, 24 Sep 2019 07:45:29 -0700 (PDT)
Date:   Tue, 24 Sep 2019 16:45:28 +0200 (CEST)
Message-Id: <20190924.164528.724219923520816886.davem@davemloft.net>
To:     uwe@kleine-koenig.org
Cc:     talgi@mellanox.com, saeedm@mellanox.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] dimlib: make DIMLIB a hidden symbol
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190920133115.12802-1-uwe@kleine-koenig.org>
References: <20190920133115.12802-1-uwe@kleine-koenig.org>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 24 Sep 2019 07:45:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <uwe@kleine-koenig.org>
Date: Fri, 20 Sep 2019 15:31:15 +0200

> According to Tal Gilboa the only benefit from DIM comes from a driver
> that uses it. So it doesn't make sense to make this symbol user visible,
> instead all drivers that use it should select it (as is already the case
> AFAICT).
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>

Since this doesn't apply due to the moderation typo being elsewhere, I'd
really like you to fix up this submission to properly be against 'net'.

Thank you.
