Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7A0C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BA320830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554281765;
	bh=3yrlKdp1GXB5y5TWOVAnwszgqtS8Gt9SsSrRmuUdXNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NLaXgEg94uvgySqnnjcDLzdoVSQf0PcokZlWdnI2wHNcG+GsNvRqCDjnabwivc6E+
	 nvvrGK3P3jF8McbGT8/IiUVoW1K3z58ym3z0XJj/45Fyr56PBoxdUkwObxiGdAREuK
	 bg8wuNU8mUZYIDMsaOrYEZZlZB2F/QJ+0V/3Tyk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDCI4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:56:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfDCI4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:56:04 -0400
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E39AC206B7;
        Wed,  3 Apr 2019 08:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554281763;
        bh=3yrlKdp1GXB5y5TWOVAnwszgqtS8Gt9SsSrRmuUdXNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQWfxWwGrVbRI0Cd67J6BYCGtnVodi1yZX9+n80LIL1Ya8Kpyn6VYTSbaGne66vXS
         v6YkzPg6w/zc+Vrcy/ezgHMS0kes6R/kZCTuvL81yv55/sIVq8TKF1n794YSHC+yCK
         1IskuFJbcNXYkPqB/ORWMEvvBdDygjCcDuzm8SVI=
Date:   Wed, 3 Apr 2019 10:56:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/146] 5.0.6-stable review
Message-ID: <20190403085600.GA4601@kroah.com>
References: <20190401170048.449559024@linuxfoundation.org>
 <20190402190606.GF14232@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402190606.GF14232@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 12:06:06PM -0700, Guenter Roeck wrote:
> On Mon, Apr 01, 2019 at 07:00:12PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.6 release.
> > There are 146 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Apr  3 16:59:21 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 345 pass: 345 fail: 0

Thanks for testing all of these and letting me know.

greg k-h
