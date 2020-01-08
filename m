Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9E8C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507252072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578501725;
	bh=j6P2//MHLKqz2GhzDg5E3HmPNrU87sDx/XYnqK6TwoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v+yQK7+N0yQbHpo28/pcD+6aC8nIxrxMjbbCf8xZ2wQxKQLUXqUGcvPmBpARKj3Xw
	 q4xgLvvyPt0Ov4DdIiBHK1TaI5SEdaxQprkXvY7GMoeyB1j4RqmJMkrATOv1h9s+VE
	 Lq9zsn/iJnmbybQ5C7UuO7SAZdGM+vOtaCYtXA+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAHQmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:42:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729081AbgAHQmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:42:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DE2C2070E;
        Wed,  8 Jan 2020 16:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578501722;
        bh=j6P2//MHLKqz2GhzDg5E3HmPNrU87sDx/XYnqK6TwoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LarfkwTKeSWJ3nkgtC+JFBvV2M2JwLQ74UCCoKAq4113MEIHBozlIYM4icKGMrjyd
         HG4SrM4vMpw29MOoLMg08YPceYX8H5KVgMrZoBfoLVMf1NCWqZFltY+V4K9Z2wvxp6
         CHoXf44CS2QcqCptzxOpEgrGvqTp99XFNYywwFS0=
Date:   Wed, 8 Jan 2020 17:41:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jassisinghbrar@gmail.com
Cc:     balbi@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2 2/2] usb: gadget: add udc driver for max3420
Message-ID: <20200108164159.GA2494836@kroah.com>
References: <20200105225509.21590-1-jassisinghbrar@gmail.com>
 <20200105225557.21729-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200105225557.21729-1-jassisinghbrar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2020 at 04:55:57PM -0600, jassisinghbrar@gmail.com wrote:
> --- /dev/null
> +++ b/drivers/usb/gadget/udc/max3420_udc.c
> @@ -0,0 +1,1333 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MAX3420 Device Controller driver for USB.
> + *
> + * Author: Jaswinder Singh Brar <jaswinder.singh@linaro.org>
> + * (C) Copyright 2019 Linaro Ltd
> + *
> + * Based on:
> + *	o MAX3420E datasheet
> + *		http://datasheets.maximintegrated.com/en/ds/MAX3420E.pdf
> + *	o MAX342{0,1}E Programming Guides
> + *		https://pdfserv.maximintegrated.com/en/an/AN3598.pdf
> + *		https://pdfserv.maximintegrated.com/en/an/AN3785.pdf
> + *
> + * This file is licenced under the GPL v2.

This line says that the SPDX line above is a lie :(

Please fix this.

As pennance, please re-read Documentation/process/license-rules.rst.

thanks,

greg k-h
