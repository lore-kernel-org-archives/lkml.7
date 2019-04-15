Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44564C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073B520880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353619;
	bh=zoh490a43YapFXHdpRBg3mcatWteUosJrFSkq/3yv+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PNHCFGU+Bb1JdtQOnOggJ/POGdItsTeTjNp5aqrZOS5CdQArdA2XlmQWq6qeqfRPX
	 4vpnvHQn1fxB4h4QQTZU9s5GtYOZoK3k0CZO4s8Is6+IUrbGOPDDjfg83bMwZou/lU
	 RUDL1dBofnU9N+wdqu/ucK2JGMm1L4b+V7dBy2Fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfDOSkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbfDOSkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:40:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14F2E2087C;
        Mon, 15 Apr 2019 18:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353616;
        bh=zoh490a43YapFXHdpRBg3mcatWteUosJrFSkq/3yv+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZ92NK1hMpUIDlGrRO0kg6JjJUrYWh9BzUjV6whqTmB7d1hGofjby9rySZ1sI6Khr
         2meTMpR4QWcyDNC/fB4l3vIZTL6cA4sUU4hhcPKpu6C/9PA6xdfWLkJgLFVyRqgA+j
         L0f5E7aq7dAl0u4vaTpb8NGuZohx8MW0ClYcUuPM=
Date:   Mon, 15 Apr 2019 20:40:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/246] 5.0.7-stable review
Message-ID: <20190415184014.GD7423@kroah.com>
References: <20190404084619.236418459@linuxfoundation.org>
 <20190405183225.GE11563@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405183225.GE11563@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 11:32:25AM -0700, Guenter Roeck wrote:
> On Thu, Apr 04, 2019 at 10:45:00AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.7 release.
> > There are 246 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Apr  6 08:44:36 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> For v5.0.6-248-gc3237e4b7d6e:
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 345 pass: 345 fail: 0

Thanks for testing all of these and letting me know.

greg k-h
