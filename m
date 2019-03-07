Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5833CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAAE20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCGR3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:29:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52000 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGR3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:29:44 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 248261479DEDC;
        Thu,  7 Mar 2019 09:29:44 -0800 (PST)
Date:   Thu, 07 Mar 2019 09:29:43 -0800 (PST)
Message-Id: <20190307.092943.881338723409230235.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     isdn@linux-pingi.de, ndesaulniers@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isdn: isdnloop: fix pointer dereference bug
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190307093241.3380715-1-arnd@arndb.de>
References: <20190307093241.3380715-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Mar 2019 09:29:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu,  7 Mar 2019 10:32:07 +0100

> clang has spotted an ancient code bug and warns about it with:
> 
> drivers/isdn/isdnloop/isdnloop.c:573:12: error: address of array 'card->rcard' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
> 
> This is an array of pointers, so we should check if a specific
> pointer exists in the array before using it, not whether the
> array itself exists.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
