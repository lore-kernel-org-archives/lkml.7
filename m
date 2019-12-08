Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468A1C2D0BF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 19:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208CC20663
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 19:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575832486;
	bh=tTkmzbY4m+GKco6n1uwSzJblEedVC6WFt6EjHSfS5Ig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HX63NAp0btJb0ek2ADaAWk682RfDpA2Da1BwJ5lki4EzZRXjTcKvnZaaaVMcgFxUz
	 1nKVsswBUBfoqCB1H3at6Kt3HfzWJxmBYb4a5DyNX+NIN3OItw97Cq0RNL+XA3UdNi
	 txTlOBqj+2i7VA0WjCVR+RkIJdsLsBXiwX5WrI3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLHTOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 14:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfLHTOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 14:14:44 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59DA820663;
        Sun,  8 Dec 2019 19:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575832483;
        bh=tTkmzbY4m+GKco6n1uwSzJblEedVC6WFt6EjHSfS5Ig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QK050Y3INjD1EssBXAmgItNIdmGUfnDGORDizBHL7bLQjmL77lx61/JB+nC7w59H5
         nGW443OOavMV4qkp/CiWnOKya6I+cj6P/nJO9jz+UVA45tX8sykS7giSE4206Po596
         Mxcu4IzfJ6d1ZhuayRW7B5GXF3eaHLsT/3MsZKDw=
Date:   Sun, 8 Dec 2019 19:14:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ad7292: Update SPDX
 identifier
Message-ID: <20191208191439.3d24086b@archlinux>
In-Reply-To: <CAL_JsqKOdmCn2cxGcjioUibXc=_2cTWtZb81nEx08CMv2fo6Pw@mail.gmail.com>
References: <20191116205026.dvlevawj5obq7weh@smtp.gmail.com>
        <CAL_JsqJzi_0eYj=rMxwQe+OTh_m3ngocOvcPZd-tykAwAJAw6g@mail.gmail.com>
        <20191123122548.54f0f529@archlinux>
        <CAL_JsqKOdmCn2cxGcjioUibXc=_2cTWtZb81nEx08CMv2fo6Pw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2019 10:48:01 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Nov 23, 2019 at 6:25 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri, 22 Nov 2019 10:05:52 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >  
> > > On Sat, Nov 16, 2019 at 2:50 PM Marcelo Schmitt
> > > <marcelo.schmitt1@gmail.com> wrote:  
> > > >
> > > > Update SPDX identifier to the preferred dual GPL-2.0 OR BSD-2-Clause
> > > > licensing.
> > > >
> > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > > ---
> > > > I split the changes into 2 different patches since they are about
> > > > different issues.
> > > >
> > > >  Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)  
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>  
> > I've applied this to the fixes-togreg branch so it'll go in during
> > the early RCs.  Nice not to have a release with a different
> > license, particularly as this was me running too fast at taking
> > patches.  
> 
> Please send patch 2 sooner rather than later. I would like 'make
> dt_binding_check' to pass in rc1 (or rc2 at the latest) rather than
> rc5/6 as happened in 5.4 cycle. It's hard to complain that patches
> fail it when mainline is already broken.

I've sent Greg a pull request with these in, so hopefully should be in 
place before rc2.

Thanks,

Jonathan

> 
> Rob

