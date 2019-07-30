Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50282C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1D7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564512571;
	bh=dUGxK7cJAWRc8NhYYFX/yCO+0Pi/RKnJmEh5ysehGLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E2lIn7CTV4dIWb+VNCdEjEeurU8weXRMvrqtCcmIV/UrtBciJ5yo523qkU00c/G39
	 Y4s1sE/oBS3kFD1KDyMGQkOLfq2ArptAtfmJyTBGrYNPKIz8/b51OfFDqP2jVCaYdu
	 57Tv4tbRpckVo5sGUPDnOPN9srI6Cvexfdjjuhzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbfG3Sta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387746AbfG3St3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:49:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2782820693;
        Tue, 30 Jul 2019 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564512568;
        bh=dUGxK7cJAWRc8NhYYFX/yCO+0Pi/RKnJmEh5ysehGLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emCrXQSJ00w48P3EVXPQJsHo5d7rlGebvZ/R2K7De0sUrfgs1EE/1nFGoRCEbB5/G
         X/52blqnnnURKkbXIvz2UmxYcPcv8n8NEdgLkK28Z6I9IqW6Zmxx5eiSKba33Mtxma
         n8j9D45CbKGbVXgcjG55I5gUVExc36Uti/yaSFkw=
Date:   Tue, 30 Jul 2019 20:49:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.2 000/215] 5.2.5-stable review
Message-ID: <20190730184926.GB4011@kroah.com>
References: <20190729190739.971253303@linuxfoundation.org>
 <20190730184305.GD32293@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730184305.GD32293@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:43:05AM -0700, Guenter Roeck wrote:
> On Mon, Jul 29, 2019 at 09:19:56PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.2.5 release.
> > There are 215 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed 31 Jul 2019 07:05:01 PM UTC.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 364 pass: 364 fail: 0

Thanks for testing all of these and letting me know.

greg k-h
