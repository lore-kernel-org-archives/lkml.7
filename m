Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21E2C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950702053B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577705959;
	bh=o/LNttMO+BhQyprGmPOmen++LoWMdJGhCO8O8HcLZDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z83JMiTWss0dQNYVLy6D48lWREipECk64KyH5yuoQIrz08Q55tEYmN0cerC8xGE4t
	 OQ9TgHo/Jpeu8esXQOIXtbSlvQzUF9eDltuGU4I0HV5g2DWEuD+7NzPwnvfTaehN8f
	 F+fjUz/NTOwwuFyD6qH3CqBUkuKD98n1X4eXEGmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfL3LjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:39:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbfL3LjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 06:39:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 844002053B;
        Mon, 30 Dec 2019 11:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577705958;
        bh=o/LNttMO+BhQyprGmPOmen++LoWMdJGhCO8O8HcLZDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtcOEhDhb0A0MDHFGn/ZNJKfwmzIAFRYC5YBXtIVQqgNXFjZZM+huCZDQwA0ySnjp
         Kn7Xiozz1uCNsFQ2Z1YhvLFmULqS+EL4OkN71eEaPk1/PC2Vre2PnM6z3ic7ybaPff
         DrwOjHKyvODdWyvWpObiwr4wNDi1FuXNc1wnHSlQ=
Date:   Mon, 30 Dec 2019 12:39:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Hanzelik <mrhanzelik@gmail.com>
Cc:     jerome.pouiller@silabs.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Staging: wfx: Fix style issues with hif_rx.c
Message-ID: <20191230113915.GA890973@kroah.com>
References: <20191229223142.5pxmmu7sfwdtcn7d@mandalore.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229223142.5pxmmu7sfwdtcn7d@mandalore.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2019 at 05:31:42PM -0500, Matthew Hanzelik wrote:
> Fix the 80 line limit warning on line 79 of hif_rx.c.
> 
> Also fixes the missing blank line warning on line 305 of hif_rx.c after
> the declaration of size_t len.

When ever you use the word "also" in a patch, that is a huge hint that
this needs to be broken up into more than one patch.  Please do that
here, one patch per "thing" you are fixing.

Yes, for two tiny fixes like this it feels like overkill, but, if you
had done this, I would have been already able to take one of these
changes in my tree and you would have only had to redo the other by now
:)

thanks,

greg k-h
