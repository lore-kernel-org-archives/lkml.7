Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D39C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 01:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB562073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 01:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfLEBIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 20:08:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38524 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbfLEBIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 20:08:47 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C54B914F35C6E;
        Wed,  4 Dec 2019 17:08:46 -0800 (PST)
Date:   Wed, 04 Dec 2019 17:08:46 -0800 (PST)
Message-Id: <20191204.170846.1266614281989376759.davem@davemloft.net>
To:     jaskaransingh7654321@gmail.com
Cc:     aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] drivers: net: qlogic: apply alloc_cast.cocci to
 qlogic/qed/qed_roce.c
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191204114013.31726-1-jaskaransingh7654321@gmail.com>
References: <20191204114013.31726-1-jaskaransingh7654321@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 04 Dec 2019 17:08:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
Date: Wed,  4 Dec 2019 17:10:13 +0530

> coccicheck reports that qlogic/qed/qed_roce.c can be patched with the
> semantic patch alloc_cast.cocci. The casts on the function
> dma_alloc_coherent can be removed. Apply the semantic patch and perform
> formatting changes as required.
> 
> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>

This is a cleanup and therefore net-next material.

net-next is closed, please resubmit this when the net-next tree is
open again.

Thank you.
