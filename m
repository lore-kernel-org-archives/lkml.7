Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAFBC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 18:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784AD215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 18:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfF2SGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 14:06:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38388 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfF2SGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 14:06:41 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 41DA914B8DAC4;
        Sat, 29 Jun 2019 11:06:41 -0700 (PDT)
Date:   Sat, 29 Jun 2019 11:06:40 -0700 (PDT)
Message-Id: <20190629.110640.41970452437281023.davem@davemloft.net>
To:     c0d1n61at3@gmail.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees][PATCH v2] packet: Fix undefined
 behavior in bit shift
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190627032532.18374-2-c0d1n61at3@gmail.com>
References: <20190627010137.5612-1-c0d1n61at3@gmail.com>
        <20190627032532.18374-2-c0d1n61at3@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 29 Jun 2019 11:06:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiunn Chang <c0d1n61at3@gmail.com>
Date: Wed, 26 Jun 2019 22:25:30 -0500

> Shifting signed 32-bit value by 31 bits is undefined.  Changing most
> significant bit to unsigned.
> 
> Changes included in v2:
>   - use subsystem specific subject lines
>   - CC required mailing lists
> 
> Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>

Applied.
