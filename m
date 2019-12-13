Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4698DC2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33F224658
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576273729;
	bh=/Np2ohZh8TPTM1BSk5i/ibn/vCP7pt+Iks8lFYajvSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LaG8vA7TOMrn3CKIEjSBbBspyUlEn1YbGmjtSOqaZd8cEfJ7zwmglVBTKS5rfGNWL
	 WkzJd37uvrDog3MQZl3gLjwbQolouwdfeAbDaNoEFOVb3wZHexZ2xPtXh6gzZgdasb
	 HfGMf7Iz/OybFhTavz+vhLBJpHQLJPl3C1JuZmCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfLMVss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:48:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfLMVsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:48:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342E92077B;
        Fri, 13 Dec 2019 21:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576273726;
        bh=/Np2ohZh8TPTM1BSk5i/ibn/vCP7pt+Iks8lFYajvSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDvt8L6HpmdXWic+WoRI66O1qfIXlozTKppfFYp2mmt6v4Sste2c5MfiJh4OytYtT
         2aXuVt0bPlz9ZcxNFltI6qTLXW0jon+M6FcXE0iHnAeRzrzDEtcxjbFilWTHtXe+9l
         Ju3w2RrcBZwEqjcPjRWuIyOlaPXliQBSLWZf9qOI=
Date:   Fri, 13 Dec 2019 15:09:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/243] 4.19.89-stable review
Message-ID: <20191213140902.GA2436279@kroah.com>
References: <20191211150339.185439726@linuxfoundation.org>
 <20191213093035.GA27637@amd>
 <b9a5af67-c7db-a2f1-b573-cbf25c1f03f6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a5af67-c7db-a2f1-b573-cbf25c1f03f6@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 05:56:41AM -0800, Guenter Roeck wrote:
> On 12/13/19 1:30 AM, Pavel Machek wrote:
> > Hi!
> > 
> > > This is the start of the stable review cycle for the 4.19.89 release.
> > > There are 243 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Fri, 13 Dec 2019 14:56:06 +0000.
> > > Anything received after that time might be too late.
> > 
> > Is there something funny going on with the timing, again? I see that
> > 4.19.89 is already out:
> > 
> 
> Just for the record, in my opinion it is perfectly fine to publish stable
> releases early after all expected feedback is in. That lets me merge the
> release early today and gives me time to fix any merge related problems.
> I don't see the benefit of waiting until 14:46:07.

And that's exactly what I do.  I wait for the expected feedback to come
in and if it looks good, I do a release.

I ususally delay the "official" announcement a bit to give the Android
builder/testers some time to give feedback after I make the tarballs as
they are good at finding problems no one else seems to catch, and then I
do the email announcements.

thanks,

greg k-h
