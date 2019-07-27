Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E05C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 21:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E418020657
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 21:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfG0V1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 17:27:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40434 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfG0V1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 17:27:11 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3D57C1534FD20;
        Sat, 27 Jul 2019 14:27:10 -0700 (PDT)
Date:   Sat, 27 Jul 2019 14:27:09 -0700 (PDT)
Message-Id: <20190727.142709.1469820728325208550.davem@davemloft.net>
To:     pebolle@tiscali.nl
Cc:     tilman@imap.cc, hjlipp@web.de, arnd@arndb.de, kkeil@linux-pingi.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gigaset: stop maintaining seperately
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190726220541.28783-1-pebolle@tiscali.nl>
References: <20190726220541.28783-1-pebolle@tiscali.nl>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 27 Jul 2019 14:27:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Bolle <pebolle@tiscali.nl>
Date: Sat, 27 Jul 2019 00:05:41 +0200

> The Dutch consumer grade ISDN network will be shut down on September 1,
> 2019. This means I'll be converted to some sort of VOIP shortly. At that
> point it would be unwise to try to maintain the gigaset driver, even for
> odd fixes as I do. So I'll stop maintaining it as a seperate driver and
> bump support to CAPI in staging. De facto this means the driver will be
> unmaintained, since no-one seems to be working on CAPI.
> 
> I've lighty tested the hardware specific modules of this driver (bas-gigaset,
> ser-gigaset, and usb-gigaset) for v5.3-rc1. The basic functionality appears to
> be working. It's unclear whether anyone still cares. I'm aware of only one
> person sort of using the driver a few years ago.
> 
> Thanks to Karsten Keil for the ISDN subsystems gigaset was using (I4L and
> CAPI). And many thanks to Hansjoerg Lipp and Tilman Schmidt for writing and
> upstreaming this driver.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Applied.
