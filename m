Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2435FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000B2206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfGaPix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:38:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39312 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGaPiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:38:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 26D9812B8C6EC;
        Wed, 31 Jul 2019 08:38:50 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:38:49 -0700 (PDT)
Message-Id: <20190731.083849.181428798865323625.davem@davemloft.net>
To:     christophe.jaillet@wanadoo.fr
Cc:     jcliburn@gmail.com, chris.snook@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] net: ag71xx: Slighly simplify code in
 'ag71xx_rings_init()'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <08fbcfe0f913644fe538656221a15790a1a83f1d.1564560130.git.christophe.jaillet@wanadoo.fr>
References: <cover.1564560130.git.christophe.jaillet@wanadoo.fr>
        <08fbcfe0f913644fe538656221a15790a1a83f1d.1564560130.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 31 Jul 2019 08:38:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Wed, 31 Jul 2019 10:06:38 +0200

> A few lines above, we have:
>    tx_size = BIT(tx->order);
> 
> So use 'tx_size' directly to be consistent with the way 'rx->descs_cpu' and
> 'rx->descs_dma' are computed below.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to net-next.
