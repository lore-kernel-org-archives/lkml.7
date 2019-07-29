Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBCAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784BD20659
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfG2UoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:44:09 -0400
Received: from atlmailgw1.ami.com ([63.147.10.40]:59396 "EHLO
        atlmailgw1.ami.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfG2UoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:44:09 -0400
X-AuditID: ac1060b2-413ff70000003a7d-87-5d3f5a99b31b
Received: from atlms1.us.megatrends.com (atlms1.us.megatrends.com [172.16.96.144])
        (using TLS with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by atlmailgw1.ami.com (Symantec Messaging Gateway) with SMTP id 08.6A.14973.99A5F3D5; Mon, 29 Jul 2019 16:44:09 -0400 (EDT)
Received: from hongweiz-Ubuntu-AMI.us.megatrends.com (172.16.98.93) by
 atlms1.us.megatrends.com (172.16.96.144) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 29 Jul 2019 16:44:08 -0400
From:   Hongwei Zhang <hongweiz@ami.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
CC:     Hongwei Zhang <hongweiz@ami.com>, Joel Stanley <joel@jms.id.au>,
        <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [v6 2/2] gpio: aspeed: Add SGPIO driver
Date:   Mon, 29 Jul 2019 16:43:46 -0400
Message-ID: <1564433026-32163-1-git-send-email-hongweiz@ami.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563564291-9692-3-git-send-email-hongweiz@ami.com>
References: <1563564291-9692-3-git-send-email-hongweiz@ami.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.98.93]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWyRiBhgu7MKPtYg7/nZCx2Xeaw+DL3FIvF
        /CPnWC1+n//LbDHlz3Imi02Pr7FaNK8+x2xxedccNgcOj6vtu9g93t9oZfe4+PEYs8eda3vY
        PDYvqfc4P2Mho8fnTXIB7FFcNimpOZllqUX6dglcGb9ubmUr2MhdcXvrOcYGxk7OLkYODgkB
        E4kXp6y6GDk5hAR2MUkcmSPfxcgFZB9mlHjSeJ0RJMEmoCaxd/McJhBbRMBP4vqtt6wgRcwC
        jUwSP18fYAZJCAsYSPxc/JQdZCiLgKpEyxFdkDCvgINE25ubrCC2hICcxM1znWDlnEDxXz0t
        TBCL7SWe79rLBFEvKHFy5hMWEJtZQELi4IsXzBA1shK3Dj1mgpijIPG87zHLBEaBWUhaZiFp
        WcDItIpRKLEkJzcxMye93FAvMTdTLzk/dxMjJLw37WBsuWh+iJGJg/EQowQHs5II72Jx+1gh
        3pTEyqrUovz4otKc1OJDjNIcLErivCvXfIsREkhPLEnNTk0tSC2CyTJxcEo1MKqw5PhOPML+
        45zOW5bG/e6NZSeF7t9n+RXpUnLgg8oE4YOT3yxL8u6avbZT4bvOfQ3bBwy3fzZuaUm61mDz
        /O2bpa98Z65etvz3doNYzTWsVje6HzYonRANbo/4eERixrYTW+wqNhiECU/o1GnRLe28UsaS
        9Z1Ba1uKwqlkxe7rCTbH6wST7JVYijMSDbWYi4oTASmAHMldAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Thanks for your detailed comments.

We just submitted a v6 of sgpio-aspeed.c, it includes the updates based on
your initial feedback:

1. fix a bug in aspeed_sgpio_dir_out()
2. some comments clean up.

Regards,
--Hongwei 

> From:	Linus Walleij <linus.walleij@linaro.org>
> Sent:	Sunday, July 28, 2019 7:38 PM
> To:	Hongwei Zhang
> Cc:	Andrew Jeffery; linux-gpio; Joel Stanley; linux-aspeed; Bartosz Golaszewski; linux-kernel; linux-
> arm-kernel
> Subject:	Re: [v5 2/2] gpio: aspeed: Add SGPIO driver
> 
> On Mon, Jul 22, 2019 at 10:37 PM Hongwei Zhang <hongweiz@ami.com> wrote:
> 
> > As you suspected it correctly, AST2500 utilizes all the 32 bits of the 
> > registers (data value, interrupt, etc...), such that using 8-bit bands 
> > [7:0]/[15:8]/23:16]/[31:24] of GPIO_200H for SGPIO_A/B/C/D .
> > so registering 10 gpiochip drivers separately will make code more 
> > complicated, for example gpio_200 register (data_value reg) has to be 
> > shared by 4 gpiochip instances, and the same is true for gpio204 
> > (interrupt reg), and other more registers.
> > So we would prefer to keeping current implementation.
> 
> OK this is a pretty good argument. My review assumed one 32-bit register was not shared between 
> banks but it is, I see.
> 
> The above situation can be managed by regmap, but that will just a different complexity so go with this 
> approach then.
> 
> Yours,
> Linus Walleij
