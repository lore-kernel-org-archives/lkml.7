Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246AEC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EB421739
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576608488;
	bh=PoKhT8q9qjRq2hvgxJe+3C+fbnYLKYLriC+Q/oiU9Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kegAOcinb48CX+o2RihCz46URJbQHgZkqN3wtRAsDY3eJV45ao1BYbYHkFLhR/FDu
	 QDEbB2BzP5uA/NkbeVD+Vy+PT0q5zpBVB3OF4osZlnR8rtXn/UhUo1ICPTLiBf7lXt
	 P1n67dMK9IhaDqDEMBX9mDNSysFLCvtgXE1giAIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfLQSsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:48:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfLQSsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:48:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED8320733;
        Tue, 17 Dec 2019 18:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576608486;
        bh=PoKhT8q9qjRq2hvgxJe+3C+fbnYLKYLriC+Q/oiU9Sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oZz8Zu0uHS+eF8771wS+/8eLF1A7B60EFhpshiPTIsBffqLqynToI8307G01gHQJR
         V6y7gcyj8WOjdl/OnS7M2+LK2kYYeMKcmWmdjwNaprlZUV95CoVXJl1cY7jFzLAuUh
         pqRUAg2UWmEgp7rlMOjwbfpBH0MEyTjk5jv8hV+0=
Date:   Tue, 17 Dec 2019 19:48:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/177] 5.4.4-stable review
Message-ID: <20191217184803.GA3867407@kroah.com>
References: <20191216174811.158424118@linuxfoundation.org>
 <20191217183159.GB29679@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217183159.GB29679@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 10:31:59AM -0800, Guenter Roeck wrote:
> On Mon, Dec 16, 2019 at 06:47:36PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.4 release.
> > There are 177 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 18 Dec 2019 17:41:25 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 158 pass: 158 fail: 0
> Qemu test results:
> 	total: 387 pass: 387 fail: 0

Thanks for testing all of these and letting me know.

greg k-h
