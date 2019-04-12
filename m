Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C19C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93A8218AF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfDLXzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:55:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50924 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfDLXzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 19:55:00 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 263B9140764C6;
        Fri, 12 Apr 2019 16:55:00 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:54:59 -0700 (PDT)
Message-Id: <20190412.165459.691438507916310102.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     jdmason@kudzu.us, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vxge: fix return of a free'd memblock on a failed dma
 mapping
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190412134512.28164-1-colin.king@canonical.com>
References: <20190412134512.28164-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 12 Apr 2019 16:55:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Fri, 12 Apr 2019 14:45:12 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if a pci dma mapping failure is detected a free'd
> memblock address is returned rather than a NULL (that indicates
> an error). Fix this by ensuring NULL is returned on this error case.
> 
> Addresses-Coverity: ("Use after free")
> Fixes: 528f727279ae ("vxge: code cleanup and reorganization")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.
