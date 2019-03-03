Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD18BC10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9043620842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551631766;
	bh=Rl2CGWLqZvnE3YMZHGeGQW42RwOoQFz5g4P0iJR2oec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=H3aGMHOeExFdqkURFW09hu5n+ainnN/Th6XH+DK32zeV9OxbL6sPUEMD2oBdPCyxB
	 KjScj94i3BY9niNjaC3ZeWzeUq3N/gR2TTXMqzvlO0q2IUiWZazC/WYV/86kxL3gdh
	 GoCBcdPxUriTYG4Vq8oXwzS6uGKhdv9JkW5RmTY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfCCQtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfCCQtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:49:25 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543982070B;
        Sun,  3 Mar 2019 16:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551631764;
        bh=Rl2CGWLqZvnE3YMZHGeGQW42RwOoQFz5g4P0iJR2oec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UlD+16/NL3RaHAylM8iR8O/g8rWEuyChbcfjGL01W6bR64+FyW/bCvZaE2VIh8IWM
         Ck/CDxT1wbdvV0asN/prvxYaPv+bPLM94WhX2dOAAHZGuS22CBoJUOHDjcIa3OiW89
         R6BSkrC+CiNhk+EJSt9u27z9xRyWequhuMWx6KUU=
Date:   Sun, 3 Mar 2019 16:49:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     Joe Perches <joe@perches.com>, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
Subject: Re: [PATCH 5/5] iio:potentiostat:lmp91000: add '\n' on dev_err
Message-ID: <20190303164918.0bb5bd72@archlinux>
In-Reply-To: <f21c5ea1-2775-91e4-4df6-3f15eec4fb81@gmail.com>
References: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
        <20190218172236.7781-6-lucasseikioshiro@gmail.com>
        <d5d88a5acc984554240047944cb3071371025085.camel@perches.com>
        <20190220094921.6777d6f8@archlinux>
        <68f8ea8165f4a87cd1c99c14f2d1cc3ecdd54ed3.camel@perches.com>
        <f21c5ea1-2775-91e4-4df6-3f15eec4fb81@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 17:15:52 -0300
Lucas Oshiro <lucasseikioshiro@gmail.com> wrote:

> Thanks for the review!
> 
> On 20/02/2019 19:22, Joe Perches wrote:
> > On Wed, 2019-02-20 at 09:49 +0000, Jonathan Cameron wrote:  
> >> On Mon, 18 Feb 2019 13:01:23 -0800 Joe Perches <joe@perches.com> wrote:  
> >>> On Mon, 2019-02-18 at 14:22 -0300, Lucas Oshiro wrote:  
> >>>> Add missing '\n' at the end of dev_err message on line 215.  
> >>> []  
> >>>> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c  
> >>> []  
> >>>> @@ -212,7 +212,7 @@ static int lmp91000_read_config(struct lmp91000_data *data)
> >>>>   	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
> >>>>   	if (ret) {
> >>>>   		if (!of_property_read_bool(np, "ti,external-tia-resistor")) {
> >>>> -			dev_err(dev, "no ti,tia-gain-ohm defined");
> >>>> +			dev_err(dev, "no ti,tia-gain-ohm defined\n");  
> >>>
> >>> Perhaps a copy/paste error as the test is for
> >>> external-tia-resistor and not tia-gain-ohm
> >>>  
> >> It is an odd construct, but I think this is correct.  What it is actually
> >> saying is that, given that we don't have an external resistor, we care
> >> that the tia-gain-ohm isn't set (otherwise it wouldn't matter).
> >>
> >>  From the docs
> >>    - ti,external-tia-resistor: if the property ti,tia-gain-ohm is not defined this
> >>      needs to be set to signal that an external resistor value is being used.
> >>
> >> So, it might be ideal to say that tia-gain-ohm is not defined and we do
> >> not have an external resistor specified.
> >>
> >> So not wrong, but could be more informative!  So perhaps a follow up patch
> >> to tidy that up would be good.  
> 
> So, this means that it's a good idea to change the dev_err message to something
> like "no ti,tia-gain-ohm defined and external resistor not specified"?

Exactly.  Thanks,

Jonathan
> 
> > 
> > Then thanks in advance for doing that.
> > cheers, Joe
> >   

