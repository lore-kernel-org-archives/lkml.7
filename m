Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E7AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FD320449
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711224;
	bh=9jPe/xMdSC2nORBXoaXs61Ncue1UPRPZr+5kbJgsQ9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dV9Glh4pUB3wJj2PPmmiNCo4JZARNhwVE0gQaBQvrEDp/Nb+qieqtICPnmfwYMC+P
	 +zH0GDFfWpqW0nhSQ3+0o46ULtpBMamPdUGS0OmHvjPar61u+3BnKyUg6r5oVsvCt2
	 Aqy5RHkJVoIujmgnQDZM2NI5sRkDPYz36Z6rd27Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391798AbfC0S1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391787AbfC0S06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:26:58 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BF6620449;
        Wed, 27 Mar 2019 18:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711218;
        bh=9jPe/xMdSC2nORBXoaXs61Ncue1UPRPZr+5kbJgsQ9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fod6riMNPC1pWJmSAqDtz5KjojxC11BI+rS0FqIBZjJKlrAxB6wlffC/5P1zn2713
         GWBWb5FoTo5xixjmAVcThW6u/TjwAYp9EmLrRA9I7/BxUvkb2Q5yFCkUGTzcOH71Tc
         tnmLx/5fzvLJZjbzk5gxWajRXNcRNaUYfjzwJLnc=
Date:   Thu, 28 Mar 2019 00:13:19 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial_core: Spelling correction
Message-ID: <20190327151319.GA17698@kroah.com>
References: <20190322030159.GA6551@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322030159.GA6551@hari-Inspiron-1545>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 08:31:59AM +0530, Hariprasad Kelam wrote:
> fix spelling mistake "overriden" -> "overridden"
> This fix resolves warning reported by checkpatch tool
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/tty/serial/serial_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You sent 3 patches with the same subject, and so I have no idea which
one is the "latest" one.

Please fix up and resend with the proper version information as the
documentation asks you to.

thanks,

greg k-h
