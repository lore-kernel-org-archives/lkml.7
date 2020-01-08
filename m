Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B1FC33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A26120705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578507807;
	bh=z5h2BCAJYT6Nmaz2VIY5if8GIhM340+Nbv2b4nnrgN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SgtQQZqEyyTmlRRQkuRQA22rglCX5b5DrR053Q8fxy3M47L1RBHsI3iJleolKZmY3
	 jjUMyWf6ioHph7zkTBKwyvy87lo50SEK8YnXCGtZAQgeAOZBQZRxUOO6UXZQvbCVaq
	 x51xRuE66Lw3YvqN5Ax9EnaYKRrNzKsZRzIvKlbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgAHSX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:23:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbgAHSX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:23:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F47B20720;
        Wed,  8 Jan 2020 18:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578507806;
        bh=z5h2BCAJYT6Nmaz2VIY5if8GIhM340+Nbv2b4nnrgN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EB8UhSLBy6nn1eq6bDkAyFfKlWlVbONxEa7OsF1RlbSASr5VTnzRnHdd6xvlHeO2f
         eRpq+8TiNOf+VehEXR55HB5KDYkfZHlExEhbonVX6c1ypnEvqm+pSX4AO+HclAHmVo
         PVfe5LOVxNpEQQg82gDAsrm0azeYhtLr22lhzYu0=
Date:   Wed, 8 Jan 2020 19:23:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/191] 5.4.9-stable review
Message-ID: <20200108182323.GC2547623@kroah.com>
References: <20200107205332.984228665@linuxfoundation.org>
 <20200108154418.GC28993@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108154418.GC28993@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 07:44:18AM -0800, Guenter Roeck wrote:
> On Tue, Jan 07, 2020 at 09:52:00PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.9 release.
> > There are 191 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 09 Jan 2020 20:44:51 +0000.
> > Anything received after that time might be too late.
> > 
> 
> For v5.4.8-191-gdd269ce619cb:
> 
> Build results:
> 	total: 158 pass: 158 fail: 0
> Qemu test results:
> 	total: 385 pass: 385 fail: 0

Great, thanks for testing all of these and letting me know.

greg k-h
