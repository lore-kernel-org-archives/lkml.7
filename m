Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3893EC32756
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 07:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F4621743
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 07:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565509050;
	bh=iK47BCHIvTG9DgRyXiak0NPqaL3gIPTXPUrcIwKQSZQ=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=mB0xz0W90eXt0Adchdp4T1aEk0fAPw7xV7kAZ7BsedQY8I3znUY0lfB+HYU0DTvaX
	 bcw2wdBxOMCF/JTZdaPMzrKwG/7S383jk0czcqjATFAIin1SbZzlecvO6kvJkRbLbR
	 wlUhE2zLUT8veg+uBVbU4nWeI6i8Pp3pQMK3gVRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfHKHh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 03:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfHKHh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 03:37:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 447B2216F4;
        Sun, 11 Aug 2019 07:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565509048;
        bh=iK47BCHIvTG9DgRyXiak0NPqaL3gIPTXPUrcIwKQSZQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=v8ali+jPhELDtwGlrod6wSitp3u3Hll+Jj7F6L2xBknXEXWCxnLKTcEE+oZlg4qxO
         qGzdpW12ESh/XqJJiSlzSm/dpH16o2S6TR5xpEVhyPNjmNJeZ/jkzE2wp1NI9R8H6l
         sXgv8z0w6BLR/FCS0HTxhQ6sT7o632LAJAlYOpdE=
Date:   Sun, 11 Aug 2019 09:37:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.4 00/21] 4.4.189-stable review
Message-ID: <20190811073724.GA3034@kroah.com>
References: <20190809134241.565496442@linuxfoundation.org>
 <20190810160247.6dx3k63wwps7gdpr@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190810160247.6dx3k63wwps7gdpr@xps.therub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 11:02:47AM -0500, Dan Rue wrote:
> On Fri, Aug 09, 2019 at 03:45:04PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.189 release.
> > There are 21 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun 11 Aug 2019 01:42:28 PM UTC.
> > Anything received after that time might be too late.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.
> 
> Note that test counts are a bit lower than previous because we are
> having some infrastructure/lab issue with our qemu/x86 environments.
> There is no evidence that it's kernel related.

thanks for testing and letting me know, and good luck with your
infrastructure issues :)

greg k-h
