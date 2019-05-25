Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725DBC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E7A20862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfEYSAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 14:00:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57478 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEYSAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 14:00:30 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7345712B05D2E;
        Sat, 25 May 2019 11:00:29 -0700 (PDT)
Date:   Sat, 25 May 2019 11:00:29 -0700 (PDT)
Message-Id: <20190525.110029.1339691720534150701.davem@davemloft.net>
To:     blackgod016574@gmail.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6_sockglue: Fix a missing-check bug in
 ip6_ra_control()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190524031946.GA6463@zhanggen-UX430UQ>
References: <20190524031946.GA6463@zhanggen-UX430UQ>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 25 May 2019 11:00:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gen Zhang <blackgod016574@gmail.com>
Date: Fri, 24 May 2019 11:19:46 +0800

> In function ip6_ra_control(), the pointer new_ra is allocated a memory 
> space via kmalloc(). And it is used in the following codes. However, 
> when there is a memory allocation error, kmalloc() fails. Thus null 
> pointer dereference may happen. And it will cause the kernel to crash. 
> Therefore, we should check the return value and handle the error.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

Applied.
