Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19982C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EF520811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553648347;
	bh=rIJUwDzCNfbGmfrWQu9365EZumm4yrQlYkgEeUX6R/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xMcdCJfJH6R7/XIe0BZFfl1NiM46LgN5cUI/3SS4sSRt+3ugZAw3TBHw/YoPLsEFF
	 AYyigONFmQaoRuk/r/isQWek9LYFwohZ/2jFOU1PUlOkOnMVZ3w4HUYXdQPVw/1v1R
	 /nt7e8/YCffwL57XRtN9XOOTqXrQZQowDnsa4Fuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbfC0A7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfC0A7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:59:06 -0400
Received: from localhost (mobile-166-137-177-030.mycingular.net [166.137.177.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EB452075D;
        Wed, 27 Mar 2019 00:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553648345;
        bh=rIJUwDzCNfbGmfrWQu9365EZumm4yrQlYkgEeUX6R/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2kyxTz2E/OqqqzIiftQznGX1y8itkei24NOwrjDb2LFPH6AYcqWn1sF/mmJZjbh9
         uS+3sk+Y1CulZj1+bG6kgwip+aS/tiwsdVs0wQxwkOHWajfXvU362LQ5aaPea9dJaB
         25/X+bVxZxUbu2yqXzLT62LhxIqPwlDhXBwIHFnY=
Date:   Wed, 27 Mar 2019 09:59:01 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/52] 5.0.5-stable review
Message-ID: <20190327005901.GA16052@kroah.com>
References: <20190326042700.963224437@linuxfoundation.org>
 <20190326175011.GE9916@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326175011.GE9916@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:50:11AM -0700, Guenter Roeck wrote:
> On Tue, Mar 26, 2019 at 03:29:47PM +0900, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.5 release.
> > There are 52 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Mar 28 04:26:38 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 345 pass: 345 fail: 0

Great, thanks for testing all of these and letting me know.

greg k-h
