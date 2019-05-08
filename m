Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0DFC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749B920989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfEHUOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:14:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51640 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfEHUOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:14:41 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 19A8A12B05D2B;
        Wed,  8 May 2019 13:14:41 -0700 (PDT)
Date:   Wed, 08 May 2019 13:14:40 -0700 (PDT)
Message-Id: <20190508.131440.579353613998007502.davem@davemloft.net>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide: officially deprecated the legacy IDE driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <c0332901-27ac-7d8c-7bee-a1d7616627f8@kernel.dk>
References: <20190508180140.12364-1-hch@lst.de>
        <c0332901-27ac-7d8c-7bee-a1d7616627f8@kernel.dk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 May 2019 13:14:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 8 May 2019 12:08:49 -0600

> On 5/8/19 12:01 PM, Christoph Hellwig wrote:
>> After a recent chat with Dave we agreed to try to finally kill off the
>> legacy IDE code base.  Set a two year grace period in which we try
>> to move everyone over.  There are a few pieces of hardware not
>> supported by libata yet, but for many of them we aren't even sure
>> if there are any users.  For those that have users we have usually
>> found a volunteer to add libata support.
> 
> I fully support this.
> 
> Acked-by: Jens Axboe <axboe@kernel.dk>

Yeah I totally support this too, I'll apply.
