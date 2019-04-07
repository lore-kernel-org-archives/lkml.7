Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0822BC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C980C218CD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554636197;
	bh=5IFfYFHTLu1oiixx3crX2lcv0X/ThqFPX0MnTSo51yE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OX6TugoA3ChFZfvj9grNqy9uq7+QrF00VrSQOSryTJGY5oNC3bHBvjRueND70tZMP
	 RAcBLtxkKJ9YXw/y6+CCG4CbCCfQ7bGxJAhg/0gnhtlfrHBcn4smHvJAgG+loDhpJW
	 zs6UUVb8w/Jlxh+An9PsSeMTIrRw5K05KwzCvBMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfDGLXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfDGLXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 07:23:16 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0D4A213F2;
        Sun,  7 Apr 2019 11:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554636195;
        bh=5IFfYFHTLu1oiixx3crX2lcv0X/ThqFPX0MnTSo51yE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aNDdh/izcfvYPSuEGf0Sjwfs/8qUbSSQioy41Mleip93qpJc0HFBcEe461o7FDN99
         9dIDgtzZp8zOckqBQk8EvRa6c2er3nquVPsGmc+CPFU0jZOd/BkXRxfE2N8bru6kBh
         OeDPbGrofAo0XlE7sndTgvcLNkG+tcuM6L6CtbnI=
Date:   Sun, 7 Apr 2019 12:23:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] bmp085.yaml: transform DT documentation of iio
 sensor into YAML
Message-ID: <20190407122309.53806329@archlinux>
In-Reply-To: <CAL_JsqKY2Sh=L7OZVHjovAq9YK0qubGKpRMezA+7H0b1Gq2oXA@mail.gmail.com>
References: <20190401173142.cunj5iwz2ox454qx@arbad>
        <CAL_JsqKY2Sh=L7OZVHjovAq9YK0qubGKpRMezA+7H0b1Gq2oXA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019 20:46:54 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Mon, Apr 1, 2019 at 12:32 PM Andreas Klinger <ak@it-klinger.de> wrote:
> >
> > use bmp085.txt and change it into yaml format
> >
> > fix links to datasheets in replaced documentation
> >
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  .../devicetree/bindings/iio/pressure/bmp085.txt    | 27 ---------
> >  .../devicetree/bindings/iio/pressure/bmp085.yaml   | 70 ++++++++++++++++++++++
> >  2 files changed, 70 insertions(+), 27 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/pressure/bmp085.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied,

Thanks,

Jonathan


