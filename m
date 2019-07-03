Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB57C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD32218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562165204;
	bh=AwY60TRJ/DmztBUPpaqXV1YeRzPfDnODBjapMjTOfik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PoPFQHggHYF4QhJY6jjFwHQJSqE5wtD0CMest3ZuuR4WaRZRATSHYSFo9/GI13akD
	 v5T9ZOEI48ZaujWkgJnfIm8rdyl+GxiZhiFLkblR5D5KfbDt4R/qJHdTWGkb9O1BIu
	 xvAS/oOJjg07c2PM4BPhxPtV2ZZ7L2KMVQCCrUyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfGCOqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfGCOqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:46:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9041321871;
        Wed,  3 Jul 2019 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562165199;
        bh=AwY60TRJ/DmztBUPpaqXV1YeRzPfDnODBjapMjTOfik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pxYrIwt8UyyWVDHyc/jRpOOCSexC/bnNpAzfLOWosFalXraZYjgGvj5Uyr+lcfE/r
         sRmXoI3WWBuVu2FnUDkYTCjK59uO1uSlmjAtOR8VKFbyT3472wyV8UkYSe8kndB4zX
         tFIYyVeXacvwQYWG/diZ97nCO6JFKKQTcFVcVLjE=
Date:   Wed, 3 Jul 2019 16:46:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/72] 4.19.57-stable review
Message-ID: <20190703144636.GA24961@kroah.com>
References: <20190702080124.564652899@linuxfoundation.org>
 <20190702202300.GB29128@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702202300.GB29128@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 01:23:00PM -0700, Guenter Roeck wrote:
> On Tue, Jul 02, 2019 at 10:01:01AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.57 release.
> > There are 72 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu 04 Jul 2019 07:59:45 AM UTC.
> > Anything received after that time might be too late.
> > 
> Build results:
> 	total: 156 pass: 156 fail: 0
> Qemu test results:
> 	total: 364 pass: 364 fail: 0

Thanks for testing these and letting me know.

greg k-h
