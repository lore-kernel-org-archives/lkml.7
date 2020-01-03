Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FF8C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 20:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7D4222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 20:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgACU0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 15:26:36 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46662 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgACU0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 15:26:35 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C19D115976611;
        Fri,  3 Jan 2020 12:26:34 -0800 (PST)
Date:   Fri, 03 Jan 2020 12:26:34 -0800 (PST)
Message-Id: <20200103.122634.2163230632525723815.davem@davemloft.net>
To:     vulab@iscas.ac.cn
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Remove redundant BUG_ON() check in phonet_pernet
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1578043240-35541-1-git-send-email-vulab@iscas.ac.cn>
References: <1578043240-35541-1-git-send-email-vulab@iscas.ac.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 03 Jan 2020 12:26:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Wang <vulab@iscas.ac.cn>
Date: Fri,  3 Jan 2020 09:20:40 +0000

> Passing NULL to phonet_pernet causes a crash via BUG_ON.
> Dereferencing net in net_generic() also has the same effect.
> This patch removes the redundant BUG_ON check on the same parameter.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Applied.
