Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B781C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33885206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfCDTcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:32:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38210 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDTcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:32:13 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5252C147159E4;
        Mon,  4 Mar 2019 11:32:12 -0800 (PST)
Date:   Mon, 04 Mar 2019 11:32:11 -0800 (PST)
Message-Id: <20190304.113211.1991255909321581564.davem@davemloft.net>
To:     kai.heng.feng@canonical.com
Cc:     mlindner@marvell.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sky2: Disable MSI on Dell Inspiron 1545 and Gateway
 P-79
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190304070003.30140-1-kai.heng.feng@canonical.com>
References: <20190304070003.30140-1-kai.heng.feng@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 04 Mar 2019 11:32:13 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon,  4 Mar 2019 15:00:03 +0800

> Some sky2 chips fire IRQ after S3, before the driver is fully resumed:
> [ 686.804877] do_IRQ: 1.37 No irq handler for vector
> 
> This is likely a platform bug that device isn't fully quiesced during
> S3. Use MSI-X, maskable MSI or INTx can prevent this issue from
> happening.
> 
> Since MSI-X and maskable MSI are not supported by this device, fallback
> to use INTx on affected platforms.
> 
> BugLink: https://bugs.launchpad.net/bugs/1807259
> BugLink: https://bugs.launchpad.net/bugs/1809843
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied and queued up for -stable, thanks.
