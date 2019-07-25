Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E03C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFD22190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564050120;
	bh=A0WahpBrMhv/2QPzLBx6EFgeCdfw9G0QZeJ5evJQciA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uox4RQiDuXl3PxMOmxAv7lSWGqC3+WET5K/uEcidh8m4XrYk+U1tJxipKm8jzVzTx
	 9ASjugiIpyg6xRT6tCdoriaJHUEmS4ApGDT0743N5Od7//G/VyZ6c5jAWPgjEE92nK
	 PdxFDywR94jXyw0Iccime3sLiLwJ9P/TFzRWJZ60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfGYKV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfGYKV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:21:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3C9D218DA;
        Thu, 25 Jul 2019 10:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564050117;
        bh=A0WahpBrMhv/2QPzLBx6EFgeCdfw9G0QZeJ5evJQciA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ejS37UFdCPZuhX6R5x7nVJu2hy4BlQpEbhXpB4MOvi0LYktj73QIFXuUAyb80sX6
         3VcRo4DlY7RbCK8YlkzrhWHaI2qWhqCqGsw6A1o/VbhN6kjOqCOG9468xonT4rxN40
         M1DQuvUaRdNgV/1NhE2aW4rax+OAXG525R/5gbAY=
Date:   Thu, 25 Jul 2019 12:21:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr
Subject: Re: [PATCH] coccinelle: api/atomic_as_refcounter: add SPDX License
 Identifier
Message-ID: <20190725102154.GA23194@kroah.com>
References: <20190725101705.179924-1-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725101705.179924-1-maennich@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:17:04AM +0100, Matthias Maennich wrote:
> Add the missing GPLv2 SPDX license identifier.
> 
> It appears this single file was missing from 7f904d7e1f3e ("treewide:
> Replace GPLv2 boilerplate/reference with SPDX - rule 505"), which
> addressed all other files in scripts/coccinelle. Hence I added
> GPL-2.0-only consitently with the mentioned patch.
> 
> Cc: linux-spdx@vger.kernel.org
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>  scripts/coccinelle/api/atomic_as_refcounter.cocci | 1 +
>  1 file changed, 1 insertion(+)

I can take this through the spdx tree if no one objects.

thanks,

greg k-h
