Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAD1C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C015206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbfGOSGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 14:06:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40120 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbfGOSGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:06:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3465E1476D09C;
        Mon, 15 Jul 2019 11:06:52 -0700 (PDT)
Date:   Mon, 15 Jul 2019 11:06:51 -0700 (PDT)
Message-Id: <20190715.110651.1919532320008372502.davem@davemloft.net>
To:     huangfq.daxian@gmail.com
Cc:     jes@trained-monkey.org, linux-hippi@sunsite.dk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/24] hippi: Remove call to memset after
 pci_alloc_consistent
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190715031921.7028-1-huangfq.daxian@gmail.com>
References: <20190715031921.7028-1-huangfq.daxian@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Jul 2019 11:06:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuqian Huang <huangfq.daxian@gmail.com>
Date: Mon, 15 Jul 2019 11:19:21 +0800

> pci_alloc_consistent calls dma_alloc_coherent directly.
> In commit 518a2f1925c3
> ("dma-mapping: zero memory returned from dma_alloc_*"),
> dma_alloc_coherent has already zeroed the memory.
> So memset is not needed.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Applied.
