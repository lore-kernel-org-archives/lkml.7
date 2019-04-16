Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA301C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78800223FE
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555424417;
	bh=IFi13bSnoHOzM92OplAPRdDp61tf5Mr/IsyMwVnsJr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XxzlX0BZOdtRnG3/xUTvZTzQEDo8UCA2BqluazBRC02LZqqcLdpwEdmG4jc0hYo0S
	 VTT9SViN8USfZ7JdNTEbfmx0tSj/+e5jHZDa0rPjabg3e3637RtFpD/8s75X3PkVE8
	 IK5O2LGbvSoe/4EHKtz1MlRSAx2awT9+1qkIBZGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfDPOUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbfDPOUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:20:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52512223FE;
        Tue, 16 Apr 2019 14:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555424404;
        bh=IFi13bSnoHOzM92OplAPRdDp61tf5Mr/IsyMwVnsJr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EpASk/C+vsc6IZIfFf5rzXgC6r1APB+VFy56pYtYA/TikZEoUzuU8Ev9sJXkTqdqn
         Dq992rLtM0ixaUQEcx8lNDn8TlC8J4jJcW5QI0zw2DnC4i2KJTbHT2bFxuoULtQyHr
         ZlMnWXuSGr9AMsMgRZSxiYh0HP59/73ufSQ7DIDQ=
Date:   Tue, 16 Apr 2019 15:40:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] driver core: fix statics initilisation
Message-ID: <20190416134009.GB17762@kroah.com>
References: <20190412154819.oiztq2uf4teuxewn@macpro-scc.lancs.ac.uk>
 <CAJZ5v0hSTVHp43TtK9_yjcy2t2V9jSL6VyPJg9cQHE2SYBOejA@mail.gmail.com>
 <20190415152900.7axwpeczvu7i5kkj@macpro-scc.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415152900.7axwpeczvu7i5kkj@macpro-scc.lancs.ac.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 04:29:01PM +0100, Willy Wolff wrote:
> Thank you for your review.
> 
> I follow https://kernelnewbies.org/FirstKernelPatch to write this patch.
> It's not stated that checkpatch.pl is for new patches only. Moreover,
> https://kernelnewbies.org/FirstKernelPatch#Running_checkpatch.pl suggest to
> run over the entire file.

FirstKernelPatch is a good thing to do in drivers/staging/, not anywhere
else in the kernel tree unless you _KNOW_ the maintainer of that
subsystem is ok to take tiny cleanup patches like this.

thanks,

greg k-h
