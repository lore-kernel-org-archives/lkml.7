Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD81C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261CA2244A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574229600;
	bh=F+0w7e+kyn9FzAvclRmJQUoXVg2MdIw/0JgjhcSDuX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GRxPHpDj69uvNZSgKr4RX351+6NErqBt/EAr9VRPwVi5JkEgpp1zMlASz1HNnEBAE
	 OaWNqa6fv/axGBOORsC5+fQBLkc6NBlszxLpAvWlYMhWhSPmg1DDP31+r+y4rMqwuQ
	 IBTBuZczJAdG1qk4vNduDkIawZm07tuEPoL+bC6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfKTF76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 00:59:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfKTF76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 00:59:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 594BF205C9;
        Wed, 20 Nov 2019 05:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574229597;
        bh=F+0w7e+kyn9FzAvclRmJQUoXVg2MdIw/0JgjhcSDuX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANY4s7wPo5GXVs+qYacV4dVnyY19oI16wZ238Afr9VKFn7hoilRzmeaDHFwlvD/tL
         9374iUNhd8wObfKhk8EzS0NzvKE1E6QuVaNQfQpw4xD1kQLk5gzCSvckMOr+DoMdx9
         Pj0j1j0Nb1VlW53EaUv+4g+GSapH+MJXtsFqq1to=
Date:   Wed, 20 Nov 2019 06:59:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/422] 4.19.85-stable review
Message-ID: <20191120055954.GB2853442@kroah.com>
References: <20191119051400.261610025@linuxfoundation.org>
 <20191119203511.GB14938@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119203511.GB14938@roeck-us.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 12:35:12PM -0800, Guenter Roeck wrote:
> On Tue, Nov 19, 2019 at 06:13:17AM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.85 release.
> > There are 422 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 21 Nov 2019 05:02:35 +0000.
> > Anything received after that time might be too late.
> > 
> 
> For v4.19.84-420-gd0112da1f7e6:
> 
> Build results:
> 	total: 156 pass: 156 fail: 0
> Qemu test results:
> 	total: 390 pass: 390 fail: 0

Great, thanks for testing this, and the others, and letting me know.

greg k-h
