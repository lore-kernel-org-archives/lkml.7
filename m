Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7F3C04AAA
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0816C20651
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556952462;
	bh=rZK5lQmanQG1bKf5n/lu8QkVaDg93D9eHblvyy74bUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f7pfXqlf10jVoGS6wsJtxCoVjbrSx+9BG2fA70Mbr2i84GBIMZzBCXgzbl7FGQmw+
	 C4eJ/IUV92O3FRwiAOeHM4gQ6vt0GCou9j+krwoSzYB9F2HMD3TYrR1TNv9ktsjHLy
	 JS3WSnby72no3bWrufjY8gukrzbm6GC0w1CGkm3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfEDGrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 02:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfEDGrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 02:47:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA0EC20645;
        Sat,  4 May 2019 06:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556952460;
        bh=rZK5lQmanQG1bKf5n/lu8QkVaDg93D9eHblvyy74bUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=neukDftob/AmEKLNeOdRoGaxX7EZwmh9zblHxdXZ4THCPyc1L46ZU9dJEQg4semUy
         u453KiZclZLz0GkDqbTrTMnsT7Ip7WqRaJ9En1pAjmRac49jjKTQ0jbRy7Q7Vd+ERD
         dponjYRgghKlTqwVNV02C1SSqjKJ2QoPpHWIrae0=
Date:   Sat, 4 May 2019 08:47:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/101] 5.0.12-stable review
Message-ID: <20190504064737.GG26311@kroah.com>
References: <20190502143339.434882399@linuxfoundation.org>
 <20190504012810.GA20514@asus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504012810.GA20514@asus>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 07:28:11PM -0600, Kelsey Skunberg wrote:
> On Thu, May 02, 2019 at 05:20:02PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.12 release.
> > There are 101 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat 04 May 2019 02:32:10 PM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.12-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Compiled, booted, and no dmesg regressions on my system. 

Thanks for testing!
