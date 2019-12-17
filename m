Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37356C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F71206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576569224;
	bh=GBDK8XppUFNSz5gp2F8XZAezflx4x5mLVQRxqNz4gkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=avPEFcNfSzZaCH2HvCHyWSUov7aniQ6/Dv2bxhFPX547uYxGKxfyvfFJVm0sI6kja
	 lI78YqfruNfHaL0N9rQcy6RoF623FmuNL2sxbIZZEOhd045bWz+NrNmZ63yc4uMtuN
	 OmZ/DZ9sPTCcGgWrvNAi9AVKVEVGE198GFQUch4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfLQHxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:53:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfLQHxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:53:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF3D2206D8;
        Tue, 17 Dec 2019 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576569222;
        bh=GBDK8XppUFNSz5gp2F8XZAezflx4x5mLVQRxqNz4gkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BdbY+e9e/+FSfuBi2RL5ZEMUEeOCQMMBWOoDI94CM9dBkAeh4OqcC9HbySIZ6PJSi
         txsQcQ73hbyzlbVYJIait0GDPgQNJ+wWKe1fi9yT6f59/NHXYpAbPcT9q2mIeG/0z/
         7ZfIoJHkoEiaaD5O2yC3VHTUnvO4yzsSfFcg4M3I=
Date:   Tue, 17 Dec 2019 08:53:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 5.4 000/177] 5.4.4-stable review
Message-ID: <20191217075337.GF2474507@kroah.com>
References: <20191216174811.158424118@linuxfoundation.org>
 <CA+G9fYt-=ZbHLEEn8VisqAN9ry6rj_Vc-7yFr+bVn3uTwhCxqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYt-=ZbHLEEn8VisqAN9ry6rj_Vc-7yFr+bVn3uTwhCxqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:53:37PM +0530, Naresh Kamboju wrote:
> On Mon, 16 Dec 2019 at 23:46, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.4.4 release.
> > There are 177 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 18 Dec 2019 17:41:25 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.4-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these other ones too.

greg k-h
