Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649A2C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE74206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560881188;
	bh=ywTAzS6PnjPNgGXbrpsoPgcUIqAYyPOI5rdEt/0+45c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bXV0dIl+x50Na4lepZbOwyH/dgUozPz2BbIVXizni9Vae+E42+XC1pUt658+lLbI7
	 hQj/pxqc6UWiSRX4NF2Pa+IoitZ8LeJlrXGyIWp/KNtcd5GKcce/S/WQgrvm4PEt1X
	 pa0vPAEu8yCcwI36ezauO5kcXtQfqMl+jZcj4HhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbfFRSG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729715AbfFRSG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:06:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2110B2063F;
        Tue, 18 Jun 2019 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560881185;
        bh=ywTAzS6PnjPNgGXbrpsoPgcUIqAYyPOI5rdEt/0+45c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RT/DMCHJLRJFLus4HeBNgutI1Q6kceJR4q3d+UdHNbI46kEbG49/Rf63ecJBPVlbl
         C/uX63tbGnnJuoZOYtaPxznZP6PAvXyquHXiPySxL2EzSnfeFXqa+/L4XIsa4iCgFG
         SVVHLdtURFxcvdJcZ/YZZe36AW1lgXvHUYJ/WjIM=
Date:   Tue, 18 Jun 2019 20:06:23 +0200
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
Subject: Re: [PATCH 5.1 000/115] 5.1.12-stable review
Message-ID: <20190618180623.GD31484@kroah.com>
References: <20190617210759.929316339@linuxfoundation.org>
 <CA+G9fYsUmFrTDHJfS=1vYVfv4BVRZ0AByEOHV6toidAxWuDqDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsUmFrTDHJfS=1vYVfv4BVRZ0AByEOHV6toidAxWuDqDg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 06:04:25PM +0530, Naresh Kamboju wrote:
> On Tue, 18 Jun 2019 at 02:50, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.1.12 release.
> > There are 115 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed 19 Jun 2019 09:06:21 PM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.12-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these and letting me know.

greg k-h
