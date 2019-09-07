Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131DDC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE6B206CD
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394812AbfIGQCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:02:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46538 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394788AbfIGQCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:02:46 -0400
Received: from localhost (unknown [88.214.184.0])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A15F613EB2C91;
        Sat,  7 Sep 2019 09:02:44 -0700 (PDT)
Date:   Sat, 07 Sep 2019 18:02:43 +0200 (CEST)
Message-Id: <20190907.180243.1465656624015319439.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     sathya.perla@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] be2net: make two arrays static const, makes object
 smaller
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190906111943.5285-1-colin.king@canonical.com>
References: <20190906111943.5285-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Sep 2019 09:02:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Fri,  6 Sep 2019 12:19:43 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the arrays on the stack but instead make them
> static const. Makes the object code smaller by 281 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   87553	   5672	      0	  93225	  16c29	benet/be_cmds.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   87112	   5832	      0	  92944	  16b10	benet/be_cmds.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
