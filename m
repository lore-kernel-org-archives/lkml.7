Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389B9C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26AF208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556370529;
	bh=jnM29zihc11tw81fyprayFzfy6HR3G1+ASCKRlaGmIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AdWQeobpUCD3b0pv630tt8mNHHt2m8Ybbwl9W23w0C3MSp3jn8dDXL1DvFXqgdQfu
	 WU3lO5rdeQRPr7oWA1HM/804NXBtDN+8gnsuTB0xHsM3i1iURya1SVFbugPr1S2x5H
	 QQOScQSfRyAZqHjbBTn1QgmFhV3E5x8b//2WKJmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfD0NIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfD0NIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:08:47 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4745E208C2;
        Sat, 27 Apr 2019 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556370526;
        bh=jnM29zihc11tw81fyprayFzfy6HR3G1+ASCKRlaGmIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qJiuiipfOPiLp/ykpz8Fkv25u4WxlQUI9m3oqzrpZOVw9/xJY+M68FkZ/daQHCsh+
         M/4nS3olJgIYBPhut20Pt3e7pQWLp7v3VN++Xu6gRPiew2j0dPZPj4LlEF/4tEDZ3c
         WXMDbv3W8UR4UGwg+LT6nuREnmGOHthrT00jETj8=
Date:   Sat, 27 Apr 2019 14:08:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Fabien Dessenne <fabien.dessenne@st.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: stm32-dfsdm: manage the get_irq error
 case
Message-ID: <20190427140840.38acb922@archlinux>
In-Reply-To: <b53b8078-e5ef-1b38-771f-3e34d387c790@st.com>
References: <1556110286-1526-1-git-send-email-fabien.dessenne@st.com>
        <1556110286-1526-2-git-send-email-fabien.dessenne@st.com>
        <b53b8078-e5ef-1b38-771f-3e34d387c790@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 14:55:09 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On 4/24/19 2:51 PM, Fabien Dessenne wrote:
> > During probe, check the "get_irq" error value.
> > 
> > Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> > ---  
> 
> Hi Fabien,
> 
> Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> Thanks,
> Fabrice
> 
> >  drivers/iio/adc/stm32-dfsdm-adc.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> > index 19adc2b..588907c 100644
> > --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> > +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> > @@ -1456,6 +1456,12 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
> >  	 * So IRQ associated to filter instance 0 is dedicated to the Filter 0.
> >  	 */
> >  	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		if (irq != -EPROBE_DEFER)
> > +			dev_err(dev, "Failed to get IRQ: %d\n", irq);
> > +		return irq;
> > +	}
> > +
> >  	ret = devm_request_irq(dev, irq, stm32_dfsdm_irq,
> >  			       0, pdev->name, adc);
> >  	if (ret < 0) {
> >   

