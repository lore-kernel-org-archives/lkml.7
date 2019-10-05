Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08706C4360C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 01:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E2A20873
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 01:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfJEBfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 21:35:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60858 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJEBfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 21:35:53 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E1EC714F363A7;
        Fri,  4 Oct 2019 18:35:52 -0700 (PDT)
Date:   Fri, 04 Oct 2019 18:35:52 -0700 (PDT)
Message-Id: <20191004.183552.2267048284594964377.davem@davemloft.net>
To:     navid.emamdoost@gmail.com
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qlogic: Fix memory leak in ql_alloc_large_buffers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191004202440.26100-1-navid.emamdoost@gmail.com>
References: <20191004202440.26100-1-navid.emamdoost@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 04 Oct 2019 18:35:53 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>
Date: Fri,  4 Oct 2019 15:24:39 -0500

> In ql_alloc_large_buffers, a new skb is allocated via netdev_alloc_skb.
> This skb should be released if pci_dma_mapping_error fails.
> 
> Fixes: 0f8ab89e825f ("qla3xxx: Check return code from pci_map_single() in ql_release_to_lrg_buf_free_list(), ql_populate_free_queue(), ql_alloc_large_buffers(), and ql3xxx_send()")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Applied and queued up for -stable.
