Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03B4C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE0420880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353525;
	bh=k1pIDXmf5qG/rFR28fZScm3JRu+jUOtfmwhZJiR+oQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n49HRMvE7JgyGt3ul54YZk4/Kw+CKWZUvp5eHrDo1oHYQkNkwsTw1JpcBWzUphrOp
	 k/p3ZgSHTcVl06QEHeWlY/mE7XMvi9EobunZqhPBQ0/2KCO6OiXTPe6h1YMsHK2VsJ
	 fo5r4hMoFiCevcHsZGKg9nIiiUBhPAqcqlT5VcUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfDOSio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfDOSio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:38:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0288A2087C;
        Mon, 15 Apr 2019 18:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353523;
        bh=k1pIDXmf5qG/rFR28fZScm3JRu+jUOtfmwhZJiR+oQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Di9iKUmZvSoRW6jDqcIgp8I48CTgpbCB9m+k2Aq1qT4GHUQ0KFE6kx3K9toYZIzWD
         qsCPFPsr32jWeFGUTwVySnmgeEGaF4ZelMXfR0KTRK69qB2Slz365Q7j4BcJnnO3Z0
         V7bOsNZwCpaUaFj+jT9kRCL/qys2vIaYuy1yUw5c=
Date:   Mon, 15 Apr 2019 20:38:41 +0200
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
Subject: Re: [PATCH 5.0 000/246] 5.0.7-stable review
Message-ID: <20190415183841.GA7423@kroah.com>
References: <20190404084619.236418459@linuxfoundation.org>
 <CA+G9fYtJrZxcnV35PYoJecUEAZpXXO1uz3g6+HKccpdshpeKZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtJrZxcnV35PYoJecUEAZpXXO1uz3g6+HKccpdshpeKZQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 12:03:28PM +0530, Naresh Kamboju wrote:
> On Thu, 4 Apr 2019 at 14:38, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.0.7 release.
> > There are 246 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat Apr  6 08:44:36 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.7-rc1.gz
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
