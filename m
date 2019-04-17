Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D112C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3130D2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555499066;
	bh=TQiUv2RhYFXwQ7zT/ye+ocZd8Zye7/SZCj+XvN0JLCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XBMmX0RRzX+thYRZugqRQuaY0UH4mJI4vhp7MAoiHsvgKZVniC9UeFQNLowUsRagR
	 jiA5SY0AaJJ4U3HP9fAuKQw/81UcCjozziH2kz0GkPli5/Cii1ihXgYFUpI2y48n3g
	 0xienE3wcVkfJLzM2tUayXSGmT+AsyYx8+xgh4xU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbfDQLEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731508AbfDQLEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:04:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84C0D20645;
        Wed, 17 Apr 2019 11:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555499064;
        bh=TQiUv2RhYFXwQ7zT/ye+ocZd8Zye7/SZCj+XvN0JLCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=suDw/MWnG52xlQd52iHfarmN3RmTJyFpzm4dnrGozmROtwn7t9uZJOX987hoE3kwJ
         h6vv/QomufhYWy8zJi8+Opj2jAXBWXTn1QcK5QdJ4RqkfLmBYUD0YQ2qXEg/ecUIU8
         96v/3wDhW2KlChItfBkABe4C/O2/kb7TgvDfFP+w=
Date:   Wed, 17 Apr 2019 13:04:21 +0200
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
Subject: Re: [PATCH 5.0 000/117] 5.0.8-stable review
Message-ID: <20190417110421.GB6878@kroah.com>
References: <20190415183744.887851196@linuxfoundation.org>
 <CA+G9fYtdGyJss=_4j18DUYDdojcmQ4=_hTx5FFKDxS6V2PSvvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtdGyJss=_4j18DUYDdojcmQ4=_hTx5FFKDxS6V2PSvvA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 04:57:07PM +0530, Naresh Kamboju wrote:
> On Tue, 16 Apr 2019 at 00:39, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.0.8 release.
> > There are 117 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Apr 17 18:36:42 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.8-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these and letting me know.

greg k-h
