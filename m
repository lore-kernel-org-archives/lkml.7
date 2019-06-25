Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D15C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97330205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfFYUqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:46:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50920 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYUqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:46:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A11F712D8C0E8;
        Tue, 25 Jun 2019 13:46:11 -0700 (PDT)
Date:   Tue, 25 Jun 2019 13:46:11 -0700 (PDT)
Message-Id: <20190625.134611.1728588998382878928.davem@davemloft.net>
To:     ivan.khoronzhuk@linaro.org
Cc:     grygorii.strashko@ti.com, hawk@kernel.org, brouer@redhat.com,
        saeedm@mellanox.com, leon@kernel.org, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        xdp-newbies@vger.kernel.org, ilias.apalodimas@linaro.org,
        netdev@vger.kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com
Subject: Re: [PATCH v4 net-next 0/4] net: ethernet: ti: cpsw: Add XDP
 support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190625175948.24771-1-ivan.khoronzhuk@linaro.org>
References: <20190625175948.24771-1-ivan.khoronzhuk@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 25 Jun 2019 13:46:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Tue, 25 Jun 2019 20:59:44 +0300

> This patchset adds XDP support for TI cpsw driver and base it on
> page_pool allocator. It was verified on af_xdp socket drop,
> af_xdp l2f, ebpf XDP_DROP, XDP_REDIRECT, XDP_PASS, XDP_TX.

So happy to watch the progress of this patch set.

Jesper and others, please review.

Thank you.
