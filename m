Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6D5C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04132053B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfEQSjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:39:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46288 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQSjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:39:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 434B613F18502;
        Fri, 17 May 2019 11:39:36 -0700 (PDT)
Date:   Fri, 17 May 2019 11:39:24 -0700 (PDT)
Message-Id: <20190517.113924.1441508070379690525.davem@davemloft.net>
To:     swkhack@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: caif: fix the value of size argument of snprintf
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190517075922.29123-1-swkhack@gmail.com>
References: <20190517075922.29123-1-swkhack@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 17 May 2019 11:39:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weikang shi <swkhack@gmail.com>
Date: Fri, 17 May 2019 15:59:22 +0800

> From: swkhack <swkhack@gmail.com>
> 
> Because the function snprintf write at most size bytes(including the
> null byte).So the value of the argument size need not to minus one.
> 
> Signed-off-by: swkhack <swkhack@gmail.com>

Applied.
