Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED57C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 12:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91482208C2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 12:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557058198;
	bh=vtBPENo7aAZR7S3Rhgl2hdkd6SQwPBUaBvrdZRuvFiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HO4bXUtw7FuFO7CPxkFQ4uzTwXv8XUA2LZdSWIAjbRw+8toAjV9q0kOWt+qICxM1n
	 Hdn3+GphNyKynOm6W4aX4dixsn7wYCSzUIJiGzYBAm0B2DqtojRlSVDQsE6vc1Tuyi
	 8SWooqCtXXYJ+9qSAj+LQf7Y6695YT22cUYwSfzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfEEMJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 08:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbfEEMJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 08:09:57 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C1B12082F;
        Sun,  5 May 2019 12:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557058196;
        bh=vtBPENo7aAZR7S3Rhgl2hdkd6SQwPBUaBvrdZRuvFiY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RrYOjkhspabAaQDhFf6rj1mIVH5Ht7i0zrX7aeQPRHavpGeJpEphtx4HTNoiyqHVq
         LHll7BR4nwqeyea8lWMlPNz9R18udlokL9M8ER5yctz6xA20W+iWfaWikIV8h/yszy
         4SDMtZeqxLRSohKiqoEB694edsWvYvR1nBA/O6sI=
Date:   Sun, 5 May 2019 13:09:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: dps310: Add pressure sensing capability
Message-ID: <20190505130951.08be3104@archlinux>
In-Reply-To: <CACPK8Xc2uwPwouto4Xg8fA0OAMJ3eP6kYjKcp9Bf4R90t1NdBg@mail.gmail.com>
References: <1556721787-28500-1-git-send-email-eajames@linux.ibm.com>
        <CACPK8Xc2uwPwouto4Xg8fA0OAMJ3eP6kYjKcp9Bf4R90t1NdBg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2019 02:34:30 +0000
Joel Stanley <joel@jms.id.au> wrote:

> Hi Eddie,
> 
> On Wed, 1 May 2019 at 14:43, Eddie James <eajames@linux.ibm.com> wrote:
> >
> > The DPS310 supports measurement of pressure, so support that in the
> > driver. Use background measurement like the temperature sensing and
> > default to lowest precision and lowest measurement rate.  
> 
> Upstream didn't accept my patch as they wanted it to support pressure
> in addition to temperature first. I didn't ever get around to doing
> that.
> 
> I suggest you send my original patch and device tree binding along
> with this one as a series.
> 
> Cheers,
> 
> Joel
Exactly as Joel says. Note there were some other minor bits and pieces
in the last review I can find of Joel's driver that will also need
tidying up..

Great to see this driver making progress.

Thanks,

Jonathan

