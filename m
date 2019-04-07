Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D60FC282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF4721738
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554634558;
	bh=zxEQLiwyX2CFmncw0h0toSoUH+MlzTILegB1mEIPd+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Eh3g+zJEk60CI8QsVkeVrkwwczTyhAJVkAD8D+TWYJPa7Gb1Ea6PilBiPA9oN1q1Z
	 jkWaMt7202awhRlx4xJXh8beH7XFjY39vZun8prlzAAhLMxgUuelGFluDRNaAdfWxd
	 XAjXomYw0HYQJROQvEPNgbfxVdsHruRhKRkfY/bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfDGKz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 06:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfDGKz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 06:55:56 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51C4720B1F;
        Sun,  7 Apr 2019 10:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554634556;
        bh=zxEQLiwyX2CFmncw0h0toSoUH+MlzTILegB1mEIPd+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JDjMl9fmmlpamSUqolS+aT2hyKT5fxhtGV0DD/9EpixFnZLv4uJDiaEsgyKzsf0Jt
         zn/OxnMFDA3594IpNxcsfSjvLsfpXe4JhyN0qb+eQJJkBLSYMNddwbLGrk7qqzp9xK
         1cwOpNV1YsJauc9QzQpdRAOZrNju3FnkOQKd9thE=
Date:   Sun, 7 Apr 2019 11:55:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Beniamin Bia <beniamin.bia@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <biabeniamin@outlook.com>
Subject: Re: [PATCH 3/3] dt-bindings: iio: adc: Add AD7616 ADC documentation
Message-ID: <20190407115549.56085920@archlinux>
In-Reply-To: <5ca841f0.1c69fb81.3c62c.c015@mx.google.com>
References: <20190402131841.8430-1-beniamin.bia@analog.com>
        <20190402131841.8430-3-beniamin.bia@analog.com>
        <5ca841f0.1c69fb81.3c62c.c015@mx.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Apr 2019 01:06:39 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, 2 Apr 2019 16:18:41 +0300, Beniamin Bia wrote:
> > Document support for AD7616 Analog to Digital Converter.
> > 
> > Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
