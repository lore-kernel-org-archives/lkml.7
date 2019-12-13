Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0738CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72702467A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576273738;
	bh=kD8gD2snPJ4W8mQCRSZozjmG7xwh/SD2SwvmlVPI/OM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lFrOdIo54A/P53mh0wgwtWmohYLwcsTaMJruJG0WWctFMKz8rZ/3fGQT7L8dSxMAi
	 B0yzGDFV5/pGry/78ObkxrH+M6IHUhAjSFIMWH5eAv2LRioYSlrBl1FOdSLUbcbwF1
	 FtqcozE4luqEX1b5Poa1Fdo7SlKtRhk/8fcUdjks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLMVs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:48:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfLMVsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:48:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D09B2253D;
        Fri, 13 Dec 2019 21:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576273733;
        bh=kD8gD2snPJ4W8mQCRSZozjmG7xwh/SD2SwvmlVPI/OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRKrRtvx9VsBOQ2jNxZVVCov6gqckQDFSEnSrRJD07eWQXFurRxrPbPYV6dNO0f0P
         9pWHU/NlJOX5PlbpkXxzmZzb1iYa3KeZxMAaifzVArxy2xtVw5u3Q/7Scu1mcZlNu0
         Sk2nO8lxAjpxtMKFPcBhemTlEAb27ffSl8B6M05k=
Date:   Fri, 13 Dec 2019 17:07:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 00/92] 5.4.3-stable review
Message-ID: <20191213160755.GC2632926@kroah.com>
References: <20191211150221.977775294@linuxfoundation.org>
 <20191212182518.GC26863@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212182518.GC26863@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:25:18AM -0800, Guenter Roeck wrote:
> On Wed, Dec 11, 2019 at 04:04:51PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.3 release.
> > There are 92 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 13 Dec 2019 14:56:06 +0000.
> > Anything received after that time might be too late.
> > 
> 
> For v5.4.2-102-g2d52a20a4c40:
> 
> Build results:
> 	total: 158 pass: 158 fail: 0
> Qemu test results:
> 	total: 397 pass: 397 fail: 0

Wonderful, thanks for testing all of these and letting me know.

greg k-h
