Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F371AC282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88AD217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556176737;
	bh=iPKphjaAT+PGTk5ikCxL3rBInlIALV7+ItOmRAXDPSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1kkxPKNxU3stylj0MuuBpca5tNiE3c4mNbPMsHJdr3jYb5vYHWLOPafdjX4favNxL
	 6EzBnPzwsr3gIHDZlp4gS1Ht3DmuWEUGFi4OU2khSEHtNL0fjOX6abnJNJwGdNUM6+
	 JuwSjUNjIFaHi7iGg3Kgjx7StFYNWEBYXcdQEkj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfDYHS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfDYHS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:18:56 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2480B2077C;
        Thu, 25 Apr 2019 07:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556176735;
        bh=iPKphjaAT+PGTk5ikCxL3rBInlIALV7+ItOmRAXDPSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qrcZlZVa++0FEYHswBZnka7JO+bTXZozHVeoXo6OmjRE27Yd3KHBR0SB7bZn2jfLu
         yDIcxf4QpeKc+OIM7Tt0Iv+vE+higBllo63F4Vdq4U0m6QjWA+Mdzol75iWYunOo+I
         jVyqJjZp35u/rcq+aixY/FHKgeivpyzsd/KDfq0A=
Date:   Thu, 25 Apr 2019 09:18:53 +0200
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
Subject: Re: [PATCH 5.0 000/115] 5.0.10-stable review
Message-ID: <20190425071853.GA4120@kroah.com>
References: <20190424170924.797924502@linuxfoundation.org>
 <CA+G9fYsNWE=qd1aZJ+cUhaZEzB3KP5d6CWmB7O_bKJFXG3vf3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsNWE=qd1aZJ+cUhaZEzB3KP5d6CWmB7O_bKJFXG3vf3A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:55:54AM +0530, Naresh Kamboju wrote:
> On Wed, 24 Apr 2019 at 23:04, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.0.10 release.
> > There are 115 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri 26 Apr 2019 05:07:37 PM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.10-rc1.gz
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

Thanks for testing 4 of these and letting me know.

greg k-h
