Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DF5C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F210206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560440495;
	bh=52CBz1YFnDqjGoD+khsIBSWf8fBf86HbcxF2ybDC6ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G2/ssJkNWtGIAC9VFUH1kWG2U/4i0EuOSt+D2fUfrEIwO9t8VrAVd6O4QDlE6rY8R
	 /h5e3DIj37bZEF/n6yUKJGKYEfNun3ST5HxpAx2Q+4+v8NcFKk6iWwc1ugtsp0cpJo
	 RZ5qoBJDNqem0EIrSoGepiCjO9N2VRejw8GF7ous=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfFMPlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731889AbfFMJu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:50:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D9B520896;
        Thu, 13 Jun 2019 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560419458;
        bh=52CBz1YFnDqjGoD+khsIBSWf8fBf86HbcxF2ybDC6ZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXxevMIO9fCFWWRPLh7VYzX/67Z5V4zPPh5V4h3WryZ+0vkQ4N+UxGCpjtERdzhyT
         Nn5ZLqgzjxJSXZlK11fT6Lzqm4WnMyPeiXiLoEom3pviTWzVi9dN9Ubux6gSxw7X7Y
         a5i7++XZzpcEjUXpkv5WER9Msn/2M2OPGJrUEu4c=
Date:   Thu, 13 Jun 2019 11:50:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: rtl8723bs: hal: sdio_halinit: fix spaces
 preferred around that unary operator
Message-ID: <20190613095056.GB17445@kroah.com>
References: <20190612023019.GA23721@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612023019.GA23721@hari-Inspiron-1545>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 08:00:19AM +0530, Hariprasad Kelam wrote:
> CHECK: spaces preferred around that '+' (ctx:VxV)
> CHECK: spaces preferred around that '<<' (ctx:VxV)
> CHECK: spaces preferred around that '|' (ctx:VxV)
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c | 92 ++++++++++++++--------------
>  1 file changed, 46 insertions(+), 46 deletions(-)
> 

Also corrupted, please fix up and resend.

thanks,

greg k-h
