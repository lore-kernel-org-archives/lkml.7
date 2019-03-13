Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EC0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4518B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552511653;
	bh=2a5/rvnG1VmKGYVn3U/WZeaMrArTCHM3IKYPLn+ycqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wHtVVYJT5kM/kOzxO1qaYKuhO5bnlfWKNkERpKDO1XvDE6hTw7uP655A07KWdc6Bq
	 qWX5dzZoPEUIXcG/oErwQlu1/coMTNuLW5T2j8XbRdzttHkG7rnebMvTFB5ET9DMVw
	 xJ1uxfxaMrrSPDoyKdX4H/3amuoJYmepmsoa6Yi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfCMVOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfCMVOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:14:11 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5A48213A2;
        Wed, 13 Mar 2019 21:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552511650;
        bh=2a5/rvnG1VmKGYVn3U/WZeaMrArTCHM3IKYPLn+ycqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p6lcjCU+PA1GEfD14+tGZoqluqqfeRX5aKj/xJ3JM3FuVkchS+dPFAiW3hlyNLeal
         x0kQDFHUuu7oFydm/RwASr6XXVrhvC/7P7odeEQy5iw5ZPxXhzFZsQsTrlqDHALOUl
         6BZyqtnSfZfBNdvqw1WbNnXhdorsK3GGihB6AC3A=
Date:   Wed, 13 Mar 2019 14:14:10 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Peter Rosin <peda@axentia.se>,
        Robert Shearman <robertshearman@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Shearman <robert.shearman@att.com>
Subject: Re: [PATCH v4 3/3] i2c: mux: pca954x: allow management of device
 idle state via sysfs
Message-ID: <20190313211410.GB32331@kroah.com>
References: <20190228114343.36443-1-robertshearman@gmail.com>
 <20190228114343.36443-4-robertshearman@gmail.com>
 <e07248e6-4987-b7a1-327a-7d30a3e5cdf5@axentia.se>
 <20190313152044.GD10250@kroah.com>
 <20190313163610.qbuexiowfcqgqndu@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313163610.qbuexiowfcqgqndu@ninjato>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 05:36:10PM +0100, Wolfram Sang wrote:
> Hi Greg,
> 
> > > I was wondering if you think the below ABI addition looks sane to you?
> > I am not the i2c maintainer :)
> 
> Peter is the i2c-mux maintainer, so I trust him very much on the I2C
> side of things. We just wondered if you'd notice a general flaw when
> exposing such an interface to userspace.

Ah, I see.  No, looks fine to me, it's a single value, well documented,
should be just fine.

thanks,

greg k-h
