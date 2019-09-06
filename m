Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FB1C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4262070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567746811;
	bh=R65YdSxknHDvQl7aHI+aK+SqlQFUfgHww7JUZmPjoTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j66JWRxHIzcBsqR2k+yY9r3+7nFgo7AZczgnzabK50mk0kpzBKRKThdqp25WlGIer
	 3lRz1M5VNR7clY9z+nWEIZJsl+OM9bCEZgRYj2vvxOBRpH5TCjRVIgfC8kxb4AA5Hx
	 ZgfnicmeWka8tVnJvd7GUJ3lBIcaO7ulqTkcAjYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404486AbfIFFNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 01:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732560AbfIFFNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 01:13:30 -0400
Received: from localhost (unknown [223.226.32.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C802070C;
        Fri,  6 Sep 2019 05:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567746809;
        bh=R65YdSxknHDvQl7aHI+aK+SqlQFUfgHww7JUZmPjoTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2IIidAqriAyaF57J4ZosnZDlZFadGIx6JOWHmwcTOue7kHaxCuCUOywEwgcftLJ0N
         C6l9/rmyyMW33ltPrPpHIdA92V+PcT0wAKZQ8todpOPz7sev7ZnqAacqhng2LFHr1a
         aQHoKmC9FEGM8hFQ7Vcn8OJEZ3q/8YRt8OyidXf8=
Date:   Fri, 6 Sep 2019 10:42:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     dmaengine@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: milbeaut-m10v-hdmac: Add Socionext
 Milbeaut HDMAC bindings
Message-ID: <20190906051221.GF2672@vkoul-mobl>
References: <20190818051647.17475-1-jassisinghbrar@gmail.com>
 <20190818051754.17548-1-jassisinghbrar@gmail.com>
 <20190904055037.GC2672@vkoul-mobl>
 <CABb+yY1RT2TuUyuU2C+m6w=AOVzXkuG7cOwbWsccywxU7HwkQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY1RT2TuUyuU2C+m6w=AOVzXkuG7cOwbWsccywxU7HwkQg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-09-19, 01:18, Jassi Brar wrote:
> On Wed, Sep 4, 2019 at 12:51 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 18-08-19, 00:17, jassisinghbrar@gmail.com wrote:
> > > From: Jassi Brar <jaswinder.singh@linaro.org>
> > >
> > > Document the devicetree bindings for Socionext Milbeaut HDMAC
> > > controller. Controller has upto 8 floating channels, that need
> > > a predefined slave-id to work from a set of slaves.
> > >
> > > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> > > ---
> > >  .../bindings/dma/milbeaut-m10v-hdmac.txt      | 32 +++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> > > new file mode 100644
> > > index 000000000000..f0960724f1c7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> > > @@ -0,0 +1,32 @@
> > > +* Milbeaut AHB DMA Controller
> > > +
> > > +Milbeaut AHB DMA controller has transfer capability bellow.
> >
> > s/bellow/below:
> >
> > > + - device to memory transfer
> > > + - memory to device transfer
> > > +
> > > +Required property:
> > > +- compatible:       Should be  "socionext,milbeaut-m10v-hdmac"
> > > +- reg:              Should contain DMA registers location and length.
> > > +- interrupts:       Should contain all of the per-channel DMA interrupts.
> > > +                     Number of channels is configurable - 2, 4 or 8, so
> > > +                     the number of interrupts specfied should be {2,4,8}.
> >
> > s/specfied/specified
> >
> Hi Vinod,
>   Do you want me to spin yet another revision for the two types in text?

Yes that would be easier for me

Thanks

-- 
~Vinod
