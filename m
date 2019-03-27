Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE23AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0182147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711313;
	bh=/bTJTUTGytAl6DDHjZVsHi0IODh0WfDSZxVqvIng7PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nhb1oK1qz5QsD0i0caJXc6qNDF4dPJPOSjC+6fMlCvfX/kyKplmPwbPWoxJ/fdOr3
	 18ZsEBr8SJmDQkBt8PTghukyS0kB9m2yK6zvj1BIb+ML1ogPa/REY+mnz31LHCSlaz
	 4ELyEteUNyxqAARwTi8/3ydsSVM4F/lO/UA4Ww0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391900AbfC0S2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391236AbfC0S2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:28:30 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81CC62082F;
        Wed, 27 Mar 2019 18:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711309;
        bh=/bTJTUTGytAl6DDHjZVsHi0IODh0WfDSZxVqvIng7PA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bp5Tlz8bsW0OZmvVzVHcNgW4AF3TpWO3iNEu3yT4cnRtI+5ZJe3tfxyE4p/VA4ZbK
         QWgescTLSj9Cp9VMwZfaWW25XEbxPwoOGpbsAS8YrE1DqgGi+lnW0NjZW58lSHrkeg
         k21LuucZNt/Wd7ukA+LQkp3QWOn4l5v4hV9xP2fc=
Date:   Thu, 28 Mar 2019 01:37:46 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Morris Ku <saumah@gmail.com>
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH 1/4] Add support for SUNIX Multi-I/O card
Message-ID: <20190327163746.GA11712@kroah.com>
References: <20190308123322.20467-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308123322.20467-1-saumah@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 08:33:22PM +0800, Morris Ku wrote:
> Add Kconfig and Makefile entry.
> 
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  Kconfig  | 2 ++
>  Makefile | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index 4f9f9905..645dcc85 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -228,4 +228,6 @@ source "drivers/siox/Kconfig"
>  
>  source "drivers/slimbus/Kconfig"
>  
> +source "drivers/char/snx/Kconfig"
> +

And now the kernel build just broke :(

Please always test-build your patches in the order you have them.

Please fix up this series and resend, it needs a lot of work.

greg k-h
