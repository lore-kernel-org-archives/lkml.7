Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D35C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 07:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9A220868
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 07:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552116229;
	bh=h+6GNBsiEEMdw33rODj2cl5qE3p418pTfBpniOcNnoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TiiAxdBNYpcULE3o/uihNDurvDiCftBduU09t6P7oNtxGcYKad+jXGyVIjw8oXxie
	 sKkKNnoD0uasu8H+rKDXZOVRU/lnKpLOXi1Qio3xKxC7gMbnLUEQELlfZfMtJ90oUP
	 laOkW0KtvM75VdgW5AzWP0B/h8w98Ea7NIAiFAOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfCIHXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 02:23:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfCIHXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 02:23:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA24D2081B;
        Sat,  9 Mar 2019 07:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552116227;
        bh=h+6GNBsiEEMdw33rODj2cl5qE3p418pTfBpniOcNnoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=laIQ282+BvT1t+aD7KxIlSRaPBS1dJTraKJrHtQBib73dlxqrJBMYDy46PPCuztu5
         jyScMuOY2+7N9YxTxp8uBHF1Z97siQ7J+SkKJavZo3LVnjl1fjHaYbXQS8vMXC6E+u
         JDaVjZJU20Fd8IRRwgfj649hyEznOR5JK9w9L58g=
Date:   Sat, 9 Mar 2019 08:23:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.0 00/46] 5.0.1-stable review
Message-ID: <20190309072344.GA5616@kroah.com>
References: <20190308124902.257040783@linuxfoundation.org>
 <CA+G9fYt20F5npxSv9EwTKs+huXHU6eEo2=VbL2QKFOx1OQ5vwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYt20F5npxSv9EwTKs+huXHU6eEo2=VbL2QKFOx1OQ5vwQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 12:40:51PM +0530, Naresh Kamboju wrote:
> On Fri, 8 Mar 2019 at 18:23, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.0.1 release.
> > There are 46 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun Mar 10 12:48:36 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.1-rc1.gz
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

Great, thanks for testing all of these and letting me know.

greg k-h
