Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DCBC2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A445E2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577727871;
	bh=Zry9tGL/4H7+WhpfYKIkXHUYm4GfEb8U4gr7Ch1OsgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r+bl90RzVqNW+vTFdovZBlGHClg6xNzHRDBy7+6oOwwcHN+gZPmuVzx++PDy4lmYz
	 dYRyFOozC7ixCL6CNhW2Yv/eHDb5Jd+5kN2TnRwmJ4PIncAJns2yb+owIaR464vnfS
	 IseYqOxgRQ9CbE32pXVlaZZr48rxx+Iej2Ao0dRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfL3Roa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:44:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfL3Roa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:44:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CBEA2053B;
        Mon, 30 Dec 2019 17:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577727870;
        bh=Zry9tGL/4H7+WhpfYKIkXHUYm4GfEb8U4gr7Ch1OsgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+pZ1R+VJCvgUER0k4Blmw2AKb6VI+kQoE+xYRVpnvh1S9SACKrU99FJzzElNKYD9
         25mrlJHylkSve/reuRJfI2INJh6nsxRMbrP3fZc65p70LAAiQUOkwBdv9SXceVOMOC
         RRViqxvnrmGEMujzor9lAAZl0hi/KdC2t79Juqz0=
Date:   Mon, 30 Dec 2019 18:44:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/161] 4.14.161-stable review
Message-ID: <20191230174427.GC1498696@kroah.com>
References: <20191229162355.500086350@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2019 at 06:17:28PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.161 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 31 Dec 2019 16:17:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.161-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.

I have pushed out a -rc2 to resolve some reported issues:
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.161-rc2.gz



