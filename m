Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC378C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22FF2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556347777;
	bh=x8HbbNWlDCI8RKD4nA+0bcuYxFUyJgRXv1+O6MNLcZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aJbE0VrIZm7uvDZHvxZCymbsn7VyV0zYvH8+ucYfNeUaFquN8lUEAmvyRqYSunKd5
	 7HfKM4DOhbuRrzEd5NxhWU5Mj/CMytyC7sMa3izsQiOfWdwMKLVU8FdsLVeFd1jJPo
	 xRDzX9b4EnbQ3ag4KfoN9NunXBoOCBjU4FJiZTz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfD0Gtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfD0Gtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:49:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 719E92054F;
        Sat, 27 Apr 2019 06:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556347776;
        bh=x8HbbNWlDCI8RKD4nA+0bcuYxFUyJgRXv1+O6MNLcZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFWQxCIF2UnpnbY+a/xFLKbD3JgKYhK6IXLDRQHlIxa+8fIizyaIwZs2evQ5UAx/U
         ovgKF6s40LA3WEBO+IyrhxafcZtbRb4AaElDcAD6rnQ6nWILHFDGkeVu+oKybuSOLu
         xbN08qbr8NHUaG+YJq4yrd2v59Jq5ND016IXaExc=
Date:   Sat, 27 Apr 2019 08:49:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/115] 5.0.10-stable review
Message-ID: <20190427064933.GA28091@kroah.com>
References: <20190424170924.797924502@linuxfoundation.org>
 <20190425193936.GF13462@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425193936.GF13462@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 12:39:36PM -0700, Guenter Roeck wrote:
> On Wed, Apr 24, 2019 at 07:08:56PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.10 release.
> > There are 115 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri 26 Apr 2019 05:07:37 PM UTC.
> > Anything received after that time might be too late.
> > 
> 
> For v5.0.9-117-ge428bc9cd366:
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 349 pass: 349 fail: 0

Wonderful, many thanks for testing all of these and letting me know.

greg k-h
