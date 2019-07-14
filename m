Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE21C742A2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 06:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCE820896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 06:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563084177;
	bh=htRhERfDkx4c+j8dMC4UolcL5W5caQMiNY7CiT/tyhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gycwp9OyhociyVF4eEhdo0lvlYpgHwUx7HlHiSKDmHtroMS0VRDBx/B3h0H7FmFMv
	 Ur5wsE5tk1pVJg9Hwd9iPmazQ/PRJdx5m2WIBIPhfM1n0P/sxWnfN4SQPu60l/D3PF
	 sovz+EoLe3MZnue21sAoC+UOa/pCJzXbSgfEu+yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfGNGC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 02:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfGNGC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 02:02:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29E720838;
        Sun, 14 Jul 2019 06:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563084175;
        bh=htRhERfDkx4c+j8dMC4UolcL5W5caQMiNY7CiT/tyhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=suh7ftrxMh30QpLBvZ2tP7YYhRx0MNak9RiHkzre+VH0oT2S1iVAfXuGzllI28hY4
         IAW3n1ldkc6IOYKjg0+UK2q1ah7kb76MMV7cpgkDa7bjEax4zzWc+lK1x4cAGSmnkj
         h391nXkodj1QgzmgxMV4cQwIRPuUk4nu/NkiWhHQ=
Date:   Sun, 14 Jul 2019 08:02:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.2 00/61] 5.2.1-stable review
Message-ID: <20190714060252.GE8005@kroah.com>
References: <20190712121620.632595223@linuxfoundation.org>
 <20190714053510.GC2385@JATN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190714053510.GC2385@JATN>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 11:35:10PM -0600, Kelsey Skunberg wrote:
> On Fri, Jul 12, 2019 at 02:19:13PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.2.1 release.
> > There are 61 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun 14 Jul 2019 12:14:36 PM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.1-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> Compiled and booted with no regressions on my system.

Thanks for testing these three and letting me know.

greg k-h
