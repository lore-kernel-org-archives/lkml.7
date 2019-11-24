Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF17C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 07:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A3D207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 07:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574578840;
	bh=NzzqisF+akJ9nukjZHOfzaIXXKGif2YRt2J9cwGPjwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h+pOf2zYM+3DZ1pOO1MftzZMchl8dkis16+Zrdez8zLPZ4agI5erex0frZhkHg+ZO
	 P+wZtQ2r/k4+zyb6NtfdnkcSnG4s2UcIc0ueXLo79vHw/+vv9wLve7F3DlUfMn/w1z
	 XJl07R73tRH2RKPUzuqUGbJDs+nidJLY94SbG0EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKXHAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 02:00:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfKXHAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 02:00:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0043207FC;
        Sun, 24 Nov 2019 07:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574578838;
        bh=NzzqisF+akJ9nukjZHOfzaIXXKGif2YRt2J9cwGPjwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ie1Bb5/q33DsFwagOoqV8xwsLY5P0dDbLONgbo8+lDgTQfIv/FMse0gB/8jssPf2Z
         CnITMSdepSBzqfInRmKqIs86B4v9TUEr36WgzqhDd8KDkIEPwIs/T0qRgDFzwHOJvM
         9YdA1xCD8s4gXzJSScRmbu6bU5KvzvDYZUIEQxqg=
Date:   Sun, 24 Nov 2019 08:00:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.3 0/6] 5.3.13-stable review
Message-ID: <20191124070034.GA2229527@kroah.com>
References: <20191122100320.878809004@linuxfoundation.org>
 <20191122181407.GE13514@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122181407.GE13514@roeck-us.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 10:14:07AM -0800, Guenter Roeck wrote:
> On Fri, Nov 22, 2019 at 11:30:02AM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.3.13 release.
> > There are 6 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 24 Nov 2019 09:59:19 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 156 pass: 156 fail: 0
> Qemu test results:
> 	total: 390 pass: 390 fail: 0

Thanks for testing all of these and letting me know.

greg k-h
