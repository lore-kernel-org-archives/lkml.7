Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F48CC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBF4216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561578267;
	bh=rBu+OldLiSngbm8/ysQRYN+O50QJLZUCg6OA0kQV0p4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yK2RPyhXZHKfyqlaspUSuS5ofESKuwtq2JRWL8ofXrohXyn8k5VUYtdsOdr3fdIhg
	 NnD30Eg2r2OoTXKpkYUXs9VA64RDiqRg2rBSiqG0/k7B6kasxlRdQMNkt9AoWrAabR
	 YabDvMu83znsA+Qx5kajd9f9ZepwyHbY8HLaXvkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfFZTo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZToZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:44:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFAE92085A;
        Wed, 26 Jun 2019 19:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561578264;
        bh=rBu+OldLiSngbm8/ysQRYN+O50QJLZUCg6OA0kQV0p4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BDyuIxJXWJ4a6rkOTPOPomy/c5pCTAc5ySuDGJTdDox7Nns92WdfOFbVru3h/7EZj
         MbhDDklmqDmsrnrRZ6keYfLc3WL/T1GzOSHYHTK1irpSQ00WcleP5AuBN+BeNJhKJf
         sSKXLiVjKwQvU3FhRItfZvijoT/nVxGg8cLQxI24=
Date:   Wed, 26 Jun 2019 20:44:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stefan Popa <stefan.popa@analog.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: iio: frequency: Add ADF4372 PLL
 documentation
Message-ID: <20190626204419.5b0f56f8@archlinux>
In-Reply-To: <CAL_JsqKW5qKYOXD8N=uCdoUxuw9iT+Lw-NhJuUuUPWj0dzdv-Q@mail.gmail.com>
References: <1561389162-26291-1-git-send-email-stefan.popa@analog.com>
        <CAL_JsqKW5qKYOXD8N=uCdoUxuw9iT+Lw-NhJuUuUPWj0dzdv-Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 08:45:58 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Mon, Jun 24, 2019 at 9:40 AM Stefan Popa <stefan.popa@analog.com> wrote:
> >
> > Document support for ADF4372 SPI Wideband Synthesizer.
> >
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> >  Documentation/devicetree/bindings/iio/frequency/adf4371.yaml | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan


