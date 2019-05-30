Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D5DC28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644E226156
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559247536;
	bh=ceVcsPKIV2y+/b5zNkGiaYOU0XHWWX3tRD7gIIQNa5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y7wpRT0wb7/M5Pbg3yeIHzUnzWWsE0nXBR2Y6qku7zFK1biduPet4hBZ5Q8ufC8SF
	 x0MjufC5rGgbQjsit9ymKGToi/2t/3z/jQPiaVQbCqvyCMDaWda7XPXmToDjHX/Iuv
	 3xkgUaoRjK2sLvIzGiL+Zw3K0lrMqo6CH9fH87Hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfE3USz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 16:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfE3USz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:18:55 -0400
Received: from localhost (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E45B326153;
        Thu, 30 May 2019 20:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559247535;
        bh=ceVcsPKIV2y+/b5zNkGiaYOU0XHWWX3tRD7gIIQNa5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARfkuACHy/E6tzx9n6XI5rSUxTdLebrRd78v1Q4G9lkZNZkCe4NsoZcnItbdaYUkP
         VjNG7FHoxg00oduWlIBFKePot/oBRvvpxWxGZULt+x2HAlwaLmfnJYsIAxe36hkWt9
         rVRgkfbrGT7agixSPEL0GGSygmZ6UuFMZZLVwscU=
Date:   Thu, 30 May 2019 13:18:54 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.1 000/405] 5.1.6-stable review
Message-ID: <20190530201854.GB816@kroah.com>
References: <20190530030540.291644921@linuxfoundation.org>
 <20190530183550.GB9720@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530183550.GB9720@roeck-us.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 11:35:50AM -0700, Guenter Roeck wrote:
> On Wed, May 29, 2019 at 07:59:58PM -0700, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.1.6 release.
> > There are 405 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat 01 Jun 2019 03:01:59 AM UTC.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 349 pass: 349 fail: 0

Wonderful, thanks for testing all of these and letting me know.

greg k-h
