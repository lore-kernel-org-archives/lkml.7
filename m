Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A9AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D7C20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140404;
	bh=/cTtIzKsgKH9Lv5D8HtQaNIPxy25tgffh8eLvB+G6Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gHmgt5u4zORY05lRxkHnn4ZXW7q13GLEZQdkpgzgruz5XeMj3/1Qao/qAcFFD70z7
	 vrsvrRLhRT5R6oj7bdMcIOrkr/C1sUpFHGS+Ei+hTYKSLNVuYwWfMSfKqyd0BNiOZk
	 TSr8VIcanW9H1XpSqyZbRfUHZGSzvcdsGMj/l1V0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388111AbfDARkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729869AbfDARkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:40:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ED1420896;
        Mon,  1 Apr 2019 17:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140401;
        bh=/cTtIzKsgKH9Lv5D8HtQaNIPxy25tgffh8eLvB+G6Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hszOxf7rjDekmhvCwiCLs1zYoiA+N2awyg0RFMH+/bQLm5FAeUEFPsVqHTTMZy4zP
         C/rgZ5dAP2FTTzWucrkJGzSdWtaVWL2EtdNNquxXdJPxdR9HgiDY7a1SdjKOEk0xMJ
         1XTeqVzNOgqu3zFCw/GvgvFNDunennOFNKZRjsG0=
Date:   Mon, 1 Apr 2019 19:13:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH 2/4] staging: iio: ad9832: add SPDX identifier
Message-ID: <20190401171355.GA19716@kroah.com>
References: <20190401143724.mcn73jhdtq3zp3nk@smtp.gmail.com>
 <ac167cc8-4236-2e15-d5f2-fa222d95da49@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac167cc8-4236-2e15-d5f2-fa222d95da49@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 08:36:50PM +0530, Mukesh Ojha wrote:
> 
> On 4/1/2019 8:07 PM, Marcelo Schmitt wrote:
> > Add SPDX identifier of GPL-2.0 for the ad9832 driver.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > ---
> >   drivers/staging/iio/frequency/ad9832.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> > index 50a583020072..d8d4a7936275 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> > @@ -1,9 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> FYI
> 
> Use C notations here as per https://lkml.org/lkml/2019/2/13/570.
> 
> <https://lkml.org/lkml/2019/2/13/570>
> 
> Once you fix it then you can take mine
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Did you read the documentation about how to put a proper SPDX line in
the kernel documentation?  For .c files, you have to use "//", not "/* */"

Please read:
	Documentation/process/license-rules.rst
and see the section "Style" for all of the details.

thanks,

greg k-h
