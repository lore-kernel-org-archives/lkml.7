Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC881C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EB920675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555482323;
	bh=sJBUKC1YKU2VXUbKeuzPParCLxNe2/Q4zGC2ajENzxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jSFBzWPhwxBXaDOJy7kTGxjvoYsllcnJ3qEHuNNna76154QFRNimH6gKeitE9ZoJD
	 y81pvQKREK1J1mSMiCQ8+Xnbk5fCtxlI6eJrF64D2Fur9aVfZu5zsky0BROAF5UyV/
	 hGDrMwgN2tkFpWn2xbU6pJccnKwaYLHBYfXvHdvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfDQGZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfDQGZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:25:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2CED20675;
        Wed, 17 Apr 2019 06:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555482321;
        bh=sJBUKC1YKU2VXUbKeuzPParCLxNe2/Q4zGC2ajENzxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+Hhq9Niz7jhQHAmPdqi3Zxa/ecvzGGx0F84dqaVvmjpkYGnFC7yPQoPjKizeK88i
         BwQ4m9c8avpRulHsQCfnxahI1goX0gCAAVWIWIWe8YNFoiv6i/Mg+aYBhlhkMPvX3W
         gMTatJGVLjwdUxVEzaLJRUgWM7zBdeQzNykV45Wc=
Date:   Wed, 17 Apr 2019 08:25:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: greybus: Cleanup in greybus driver
Message-ID: <20190417062518.GA23076@kroah.com>
References: <20190416221318.21161-1-madhumithabiw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416221318.21161-1-madhumithabiw@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 05:13:18PM -0500, Madhumitha Prabakaran wrote:
> Fix a blank line after structure declarations. Also, convert
> macros into inline functions in order to maintain Linux kernel
> coding style based on which the inline function is
> preferable over the macro.
> 
> Blank line fixes are suggested by checkpatch.pl
> 
> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> 
> Changes in v2:
> - To maintain consistency in driver greybus, all the instances of macro
> with container_of are fixed in a single patch.
> ---
>  drivers/staging/greybus/bundle.h    |  6 +++++-
>  drivers/staging/greybus/control.h   |  6 +++++-
>  drivers/staging/greybus/gbphy.h     | 12 ++++++++++--
>  drivers/staging/greybus/greybus.h   |  6 +++++-
>  drivers/staging/greybus/hd.h        |  6 +++++-
>  drivers/staging/greybus/interface.h |  6 +++++-
>  drivers/staging/greybus/module.h    |  6 +++++-
>  drivers/staging/greybus/svc.h       |  6 +++++-
>  8 files changed, 45 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/greybus/bundle.h b/drivers/staging/greybus/bundle.h
> index 8734d2055657..84956eedb1c4 100644
> --- a/drivers/staging/greybus/bundle.h
> +++ b/drivers/staging/greybus/bundle.h
> @@ -31,7 +31,11 @@ struct gb_bundle {
>  
>  	struct list_head	links;	/* interface->bundles */
>  };
> -#define to_gb_bundle(d) container_of(d, struct gb_bundle, dev)
> +
> +static inline struct gb_bundle *to_gb_bundle(struct device *d)
> +{
> +	return container_of(d, struct gb_bundle, dev);
> +}

Why are we changing this to an inline function?  The #define is fine,
and how we "normally" do this type of container_of conversion.

I understand the objection of the "no blank line", but this was the
"original" style that we used to create these #defines from the very
beginning of the driver model work a decade ago.  Changing that
muscle-memory is going to be hard for some of us.  Look at
drivers/base/base.h for other examples of this.

thanks,

greg k-h
