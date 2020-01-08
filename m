Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF2FC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F592072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgAHOWA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:22:00 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbgAHOV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:21:59 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1B4E09E0BF418F42DA76;
        Wed,  8 Jan 2020 14:21:57 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 8 Jan 2020 14:21:56 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 8 Jan 2020
 14:21:56 +0000
Date:   Wed, 8 Jan 2020 14:21:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     Jonathan Cameron <jic23@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: buffer-dmaengine: Use dma_request_chan() directly
 for channel request
Message-ID: <20200108142154.00003ccf@Huawei.com>
In-Reply-To: <4d4c4338-b028-e28b-a603-323eadebd261@ti.com>
References: <20191113092453.30838-1-peter.ujfalusi@ti.com>
        <20191114043318.GE952516@vkoul-mobl>
        <20191116162257.550f62d6@archlinux>
        <4d4c4338-b028-e28b-a603-323eadebd261@ti.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 14:19:43 +0200
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> Jonathan,
> 
> On 16/11/2019 18.22, Jonathan Cameron wrote:
> > On Thu, 14 Nov 2019 10:03:18 +0530
> > Vinod Koul <vkoul@kernel.org> wrote:
> >   
> >> On 13-11-19, 11:24, Peter Ujfalusi wrote:  
> >>> dma_request_slave_channel_reason() is:
> >>> #define dma_request_slave_channel_reason(dev, name) \
> >>> 	dma_request_chan(dev, name)    
> >>
> >> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> >>  
> > 
> > Applied to the togreg branch of iio.git and pushed out as testing
> > for the autobuilders to play with it.  
> 
> The sole user in mainline for dma_request_slave_channel_reason() is
> industrialio-buffer-dmaengine.c (since v5.5-rc1, 5.4 had 36 users).
> 
> Are you planning to queue this patch for 5.6 (not sure if it could be
> sent to -rc6) so I can retire it from the dmaengine.h?

It's queued up for the 5.6 merge window. 

Jonathan

> 
> Regards,
> - Péter
> 
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


