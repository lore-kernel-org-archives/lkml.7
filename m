Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E91BC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5633E2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfEMQFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:05:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39162 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbfEMQFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:05:00 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7C4F614E14FF4;
        Mon, 13 May 2019 09:04:59 -0700 (PDT)
Date:   Mon, 13 May 2019 09:04:58 -0700 (PDT)
Message-Id: <20190513.090458.111530651468733326.davem@davemloft.net>
To:     tbogendoerfer@suse.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: seeq: fix crash caused by not set dev.parent
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190513111517.14780-1-tbogendoerfer@suse.de>
References: <20190513111517.14780-1-tbogendoerfer@suse.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 May 2019 09:04:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Date: Mon, 13 May 2019 13:15:17 +0200

> The old MIPS implementation of dma_cache_sync() didn't use the dev argument,
> but commit c9eb6172c328 ("dma-mapping: turn dma_cache_sync into a
> dma_map_ops method") changed that, so we now need to set dev.parent.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Applied and queued up for -stable.
