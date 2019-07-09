Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAE2C73C5C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7742073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfGIVwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 17:52:43 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46262 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfGIVwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:52:43 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 807CC1425B0FD;
        Tue,  9 Jul 2019 14:52:42 -0700 (PDT)
Date:   Tue, 09 Jul 2019 14:52:41 -0700 (PDT)
Message-Id: <20190709.145241.634478641391763394.davem@davemloft.net>
To:     suratiamol@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] ide: use BIT() macro for defining bit-flags
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190707085729.GA22964@arch>
References: <20190707085729.GA22964@arch>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 09 Jul 2019 14:52:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amol Surati <suratiamol@gmail.com>
Date: Sun, 7 Jul 2019 14:27:29 +0530

> The BIT() macro is available for defining the required bit-flags.
> 
> Since it operates on an unsigned value and expands to an unsigned result,
> using it, instead of an expression like (1 << x), also fixes the problem
> of shifting a signed 32-bit value by 31 bits (e.g. 1 << 31).
> 
> Signed-off-by: Amol Surati <suratiamol@gmail.com>

Applied, thank you.
