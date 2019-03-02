Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37BDC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 08:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA62D20838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 08:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfCBIyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 03:54:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36270 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfCBIyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 03:54:15 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 57CD71451839F;
        Sat,  2 Mar 2019 00:54:15 -0800 (PST)
Date:   Sat, 02 Mar 2019 00:54:14 -0800 (PST)
Message-Id: <20190302.005414.840774048326674645.davem@davemloft.net>
To:     maowenan@huawei.com
Cc:     netdev@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: sit: fix memory leak in sit_init_net()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190301150640.85941-1-maowenan@huawei.com>
References: <20190301150640.85941-1-maowenan@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 02 Mar 2019 00:54:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>
Date: Fri, 1 Mar 2019 23:06:40 +0800

> If register_netdev() is failed to register sitn->fb_tunnel_dev,
> it will go to err_reg_dev and forget to free netdev(sitn->fb_tunnel_dev).
 ...
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Applied and queued up for -stable, thank you.
