Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1BFC48BDF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 05:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF6F20843
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 05:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561182243;
	bh=8XfY/ADqB/m32rtN3KWK7dF1kaYPkqEqs6tSWgPwc64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2DqlC3q9iXhaH9J9GGl/eBYwsNJX/aEmAWznE6vdYtTtMhQ9g6u4Knk2deZMACkhZ
	 ty5k++QhMMSZ8uLw0MhWSUSQel6k6RbLYrbtRVQZPp9C7BSTD2sXlmKLYCbjuBW7OO
	 tfGali6pfcApeg6NMoVNHvTaaiX4U32S2ZOlqO60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfFVFoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 01:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfFVFoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 01:44:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DB12070B;
        Sat, 22 Jun 2019 05:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561182240;
        bh=8XfY/ADqB/m32rtN3KWK7dF1kaYPkqEqs6tSWgPwc64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRC5gUXenqrX07WCB2us+4Fk7forVkRo8G6dgKtgIovGLPMxOyN1lX0aU8KSbgTrX
         EIp6bXrqm5+5PahUTy5y/+bx4W9rimLTHBiOiJSOM27mWOdjaYHj0kJjBM7z4IZtzd
         1EqC6T8Kdjk6xugvp1SYjxJHITeSpPodys0UzQco=
Date:   Sat, 22 Jun 2019 07:43:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.1 00/98] 5.1.13-stable review
Message-ID: <20190622054357.GA26075@kroah.com>
References: <20190620174349.443386789@linuxfoundation.org>
 <4efcd858-1b66-097a-1d8a-1a4e0efe7a42@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4efcd858-1b66-097a-1d8a-1a4e0efe7a42@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 05:45:58PM -0700, Guenter Roeck wrote:
> On 6/20/19 10:56 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.1.13 release.
> > There are 98 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat 22 Jun 2019 05:42:15 PM UTC.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 364 pass: 364 fail: 0

Wonderful!  Thanks for testing all of these and letting me know.

greg k-h
