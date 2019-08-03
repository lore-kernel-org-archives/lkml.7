Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AC3C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED3D2087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564816288;
	bh=ajstKe5PuFFBN89gudYLlb5gh/kfKS0Fkqi8b7DCbmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=utVRYLSjH2bosuQS+Q3NmsXpF/HfXYOA3+tgWIvrn+bSITsRwZtf79ANGwUNnWPNM
	 xBaymjsust9yLZfTrg9plX1AR+7b5UlDsYo96xM5lrJDt3G51Viii/LkcEA4988UM9
	 pq1HpbIQwWnLdbv3mAjSTwJittuc/8Pw+kKcp8yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfHCHL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 03:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfHCHL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 03:11:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C04620665;
        Sat,  3 Aug 2019 07:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564816285;
        bh=ajstKe5PuFFBN89gudYLlb5gh/kfKS0Fkqi8b7DCbmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YvTTveD9w5kTexAG7KSW2Y7q+jjtwLof2XIi8PZthb9KWWFqVnRoR9dTqjix/lBZe
         wSeSC0LY5hO4g5+5hUU6Yq/JWibIy/KtgDj3ufFj4yfnLHR2e7szpv2wPWf52EXuFF
         uU9SevEP0/aMYsNVFxKxYqyvfR1WSPRtIHiGyicE=
Date:   Sat, 3 Aug 2019 09:11:23 +0200
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
Subject: Re: [PATCH 5.2 00/20] 5.2.6-stable review
Message-ID: <20190803071123.GD24334@kroah.com>
References: <20190802092055.131876977@linuxfoundation.org>
 <CA+G9fYsFFZvU74RN-ucQ_P4WZ_Wi1nHdbyiRN77sw6vV9AV+xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsFFZvU74RN-ucQ_P4WZ_Wi1nHdbyiRN77sw6vV9AV+xg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2019 at 11:20:05AM +0530, Naresh Kamboju wrote:
> On Fri, 2 Aug 2019 at 15:28, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.2.6 release.
> > There are 20 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun 04 Aug 2019 09:19:34 AM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.6-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these and letting me know.

greg k-h
