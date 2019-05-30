Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63575C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4109A260B6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfE3T3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 15:29:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58828 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfE3T3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 15:29:09 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4312914DA812D;
        Thu, 30 May 2019 12:29:08 -0700 (PDT)
Date:   Thu, 30 May 2019 12:29:05 -0700 (PDT)
Message-Id: <20190530.122905.427002960025853686.davem@davemloft.net>
To:     rasmus.villemoes@prevas.dk
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        Rasmus.Villemoes@prevas.se, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: mv88e6xxx: fix handling of upper half
 of STATS_TYPE_PORT
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190529070158.7040-1-rasmus.villemoes@prevas.dk>
References: <20190529070158.7040-1-rasmus.villemoes@prevas.dk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 May 2019 12:29:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date: Wed, 29 May 2019 07:02:11 +0000

> Currently, the upper half of a 4-byte STATS_TYPE_PORT statistic ends
> up in bits 47:32 of the return value, instead of bits 31:16 as they
> should.
> 
> Fixes: 6e46e2d821bb ("net: dsa: mv88e6xxx: Fix u64 statistics")
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> v2: include Fixes tag, use proper subject prefix.

Applied and queued up for -stable, thanks.
