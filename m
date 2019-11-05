Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56686ECE599
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BC4214B2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572939202;
	bh=vaOR5bAXX85TKhkjPMaF9r8/0fUEVqLopa+UPaNPiUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ls39PPcdlcgRr0OLlkelmW1V0ToLM9ZLdm7BP64cUcoHtBB4iuwIFhri02U3101Nm
	 YkS7+CXvTjzr0BaRetI6WPed4lKC5auEpM76he/RIiiIlXeCzLxo+3PBtz5dJ0SYNK
	 gyO1O8MtYdMdIoYR82Fvv2hkebsJGTN5vLak54bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbfKEHdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:33:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387484AbfKEHdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:33:20 -0500
Received: from localhost (host6-102.lan-isdn.imaginet.fr [195.68.6.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9C0E20717;
        Tue,  5 Nov 2019 07:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572939198;
        bh=vaOR5bAXX85TKhkjPMaF9r8/0fUEVqLopa+UPaNPiUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ABO0kAeEIUi6wBxL+39vA2383Ugae/rFpKALrIT2i4rUfX8ZOr2dLtZVIX/tYa1o
         6TG8C+dmCCSG/gqUMzBQ66sXRWOzBj2kFkzhMYAcIEipmGh7GBe0OhoDW4ynCKQno4
         CI3C2KezvQ5NojuAU19QpY/WLhmN7wOCDesoILdc=
Date:   Tue, 5 Nov 2019 08:33:16 +0100
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
Subject: Re: [PATCH 5.3 000/163] 5.3.9-stable review
Message-ID: <20191105073316.GA2588562@kroah.com>
References: <20191104212140.046021995@linuxfoundation.org>
 <CA+G9fYsVHLWFEV7Tc+_EAgH1QGDrN8OBUK54rK_48bnZ=JLJNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsVHLWFEV7Tc+_EAgH1QGDrN8OBUK54rK_48bnZ=JLJNQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 11:56:57AM +0530, Naresh Kamboju wrote:
> On Tue, 5 Nov 2019 at 03:34, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.3.9 release.
> > There are 163 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed 06 Nov 2019 09:14:04 PM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.3.9-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.3.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these so quickly and letting me know.

greg k-h
