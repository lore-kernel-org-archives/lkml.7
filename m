Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921EDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 09:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC1A20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 09:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552211460;
	bh=htOw4tdxWQCJUPS2iqo/VrmQSv2QtekFyBlI2Ke/dKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hPHUi3pk4VdQRiVq/XPAAR9xi+uykhnZVc9PBFQs8ZxF7WbSXCDGUmO0cCQwHu9+P
	 2N2qWr3wxI1wKAjoBEV7WUKsHLnRXwdVRr3e5QTAJHeL8hPgpNkzqYPat5UN84ZTND
	 BWJ2hBsGghh9PIQFb8CYicNUrz30clSuLy1QWYKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfCJJu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 05:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfCJJu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 05:50:58 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2584F20657;
        Sun, 10 Mar 2019 09:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552211457;
        bh=htOw4tdxWQCJUPS2iqo/VrmQSv2QtekFyBlI2Ke/dKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o0KdypDt3o2Vq0N5fBT0PC/e1mP1y4SkHv49k2v53i7KvmE3h7timQzkHgjvUi9ss
         7eDxoSIQLxFxKbpui75RhBNO3QxuglkLiXuZD9AIR/zGXBEgneL5ToZxV/amp7nSe1
         fACKKyAGhM4c8OD6HvZsLJx4epZkjPAw06KUWSUI=
Date:   Sun, 10 Mar 2019 10:48:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc] mei: convert to SPDX license tags
Message-ID: <20190310094817.GA2987@kroah.com>
References: <20190310100323.6912-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310100323.6912-1-tomas.winkler@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 12:03:23PM +0200, Tomas Winkler wrote:
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

I can not take patches without any changelog text.

Especially a patch that does not actually do what your subject: line
says it does.

> --- a/drivers/misc/mei/Makefile
> +++ b/drivers/misc/mei/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # Makefile - Intel Management Engine Interface (Intel MEI) Linux driver
> -# Copyright (c) 2010-2014, Intel Corporation.
> +# Copyright (c) 2010-2019, Intel Corporation.
>  #
>  obj-$(CONFIG_INTEL_MEI) += mei.o
>  mei-objs := init.o

As an example, why did you update this copyright line?  That has nothing
to do with the SPDX identifier :(


> --- a/drivers/misc/mei/client.c
> +++ b/drivers/misc/mei/client.c
> @@ -1,17 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> + * Copyright(c) 2003-2019, Intel Corporation. All rights reserved.
>   *
>   * Intel Management Engine Interface (Intel MEI) Linux driver
> - * Copyright (c) 2003-2012, Intel Corporation.

Are you _SURE_ you mean to change the dates of the copyright in this
manner for this file (and elsewhere?)  Was the copyright really updated
every year for the past 7 years?

Please break this up into two (at the least) patches and resend as a
series.

This patch makes me feel like it is a kernel intern application process
patch, and that's not good, you all know better than this.  No, sorry, I
take that back, the intern application patches are of much higher
quality...

greg k-h
