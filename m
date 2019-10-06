Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C59C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 11:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950852087E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 11:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfJFLYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 07:24:12 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:22116
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726224AbfJFLYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 07:24:11 -0400
X-IronPort-AV: E=Sophos;i="5.67,263,1566856800"; 
   d="scan'208";a="321762246"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2019 13:24:08 +0200
Date:   Sun, 6 Oct 2019 13:24:08 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        outreachy-kernel@googlegroups.com, johan@kernel.org,
        elder@kernel.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] Re: [PATCH] staging: greybus: add blank line
 after declarations
In-Reply-To: <2ed3bf96312dbd9abcd626868ce84e01a066b201.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1910061322070.2515@hadrien>
References: <20191005210046.27224-1-gabrielabittencourt00@gmail.com>  <20191006095042.GA2918514@kroah.com> <2ed3bf96312dbd9abcd626868ce84e01a066b201.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Oct 2019, Joe Perches wrote:

> On Sun, 2019-10-06 at 11:50 +0200, Greg KH wrote:
> > On Sat, Oct 05, 2019 at 06:00:46PM -0300, Gabriela Bittencourt wrote:
> > > Fix CHECK: add blank line after declarations
> []
> > > diff --git a/drivers/staging/greybus/control.h b/drivers/staging/greybus/control.h
> []
> > > @@ -24,6 +24,7 @@ struct gb_control {
> > >  	char *vendor_string;
> > >  	char *product_string;
> > >  };
> > > +
> > >  #define to_gb_control(d) container_of(d, struct gb_control, dev)
> >
> > No, the original code is "better" here, it's a common pattern despite
> > what checkpatch.pl tells you, sorry.
>
> Statistics please.
>
> I believe it's not a common pattern.

I get 464 that have a blank line before the container_of #define and 185
that have no blank line.

Of the 464 that have a blank line, 135 contain clk in the file name.

julia
