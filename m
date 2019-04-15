Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D934FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A581D218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353576;
	bh=FOJ5zy0hEMPRwS0soSWR/w6/BukbZ/uZ9E9vUJME4KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C4S1T2e8+pvIiSr2mfOXDpuHaw9P4DqzTbqCkAJJkr19kyzbfyi2un8cSwCSdp/cM
	 omV24UVg6HLYghCeoF6XNY3oqpLlfrlCoXvTwL7H0eZroaaHuzwmfhVAotkp3ED2Q/
	 jk+Oi9AMZNZxHopbKqzAosYFfkrU3xVHraXaoZ80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfDOSjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfDOSjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:39:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC2F12087C;
        Mon, 15 Apr 2019 18:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353571;
        bh=FOJ5zy0hEMPRwS0soSWR/w6/BukbZ/uZ9E9vUJME4KI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3A96tQcZg3DohvssobYlADuDm83xUDvsPdjmOCcKgD61M8/WPoSf9CpHfC5z2zns
         rcCefCIV21lvGU8HgPS7EUyYY9ZJXElpgfoAAmlOleds2dwHI7OsEwcYpdWaNjWvSy
         /9JvBD9eq4SU7bI6rbN0BgemVOBba42gpFPsb+b4=
Date:   Mon, 15 Apr 2019 20:39:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/246] 5.0.7-stable review
Message-ID: <20190415183928.GB7423@kroah.com>
References: <20190404084619.236418459@linuxfoundation.org>
 <d1c881e4-7538-8b4e-7db4-35047d6b71c6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1c881e4-7538-8b4e-7db4-35047d6b71c6@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 04:40:06PM +0100, Jon Hunter wrote:
> 
> On 04/04/2019 09:45, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.7 release.
> > There are 246 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Apr  6 08:44:36 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.7-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> All tests are passing for Tegra ...
> 
> Test results for stable-v5.0:
>     11 builds:	11 pass, 0 fail
>     22 boots:	22 pass, 0 fail
>     30 tests:	30 pass, 0 fail
> 
> Linux version:	5.0.7-rc1-gcfe0614
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04

Thanks for testing all of these and letting me know.

greg k-h
