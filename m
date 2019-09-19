Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEC1C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 06:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAA421929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 06:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568875056;
	bh=VPa0SrjRAhGZf8NCwjxSVaQoJjEkf1i9PHrA6nQ5yzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bQdff9hKhvEHweSj5lNfp6uXMJSHyC7vlG1n7I8UATEcteuD2zU6OJh5fTlgvJ6qQ
	 gW2D9vFpnvkAtNz211M/gI+dTo0peJtOqnM3w1KgxD6pkojYCyeEu35f4lekfXxOEh
	 VI4lUyQO0LWiLuBSTsdw/RVIwq4u581rr25HdCt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbfISGhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 02:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388106AbfISGhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 02:37:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 098BE218AF;
        Thu, 19 Sep 2019 06:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568875053;
        bh=VPa0SrjRAhGZf8NCwjxSVaQoJjEkf1i9PHrA6nQ5yzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o1S4aK0m/AC3hTJONsLlHbkr0DLMpR06I3zmB7a74oO+6RZ3x3rLtBKt5PfDVEJ03
         h5Cce6WQwmGJyXPL1NsDnOmvYT4sl2IICPSExMfSmU0Fh0Z/3L268+yeedgEAFHrF0
         /4B2qcfAG1m7Co2uoVGhQWIP4OD1zmG+edirLWdQ=
Date:   Thu, 19 Sep 2019 08:37:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/50] 4.19.74-stable review
Message-ID: <20190919063731.GD2069346@kroah.com>
References: <20190918061223.116178343@linuxfoundation.org>
 <20190918193749.GB30544@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918193749.GB30544@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 12:37:49PM -0700, Guenter Roeck wrote:
> On Wed, Sep 18, 2019 at 08:18:43AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.74 release.
> > There are 50 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri 20 Sep 2019 06:09:47 AM UTC.
> > Anything received after that time might be too late.
> > 
> 
> For v4.19.73-51-g7290521ed4bd:
> 
> Build results:
> 	total: 156 pass: 156 fail: 0
> Qemu test results:
> 	total: 390 pass: 390 fail: 0

Great, glad that got fixed up.

Thanks for testing all of these.

greg k-h
