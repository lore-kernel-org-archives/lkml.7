Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F416EC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D98218A5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562145105;
	bh=9vDex9XUCwSmQC+2Hghtv36ZpISxOwD/Gmf81nZlWik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vcdkqlYZWs51yQf5rJh0PY+JM7T5AqAzJBSIfpxLgYyL+VaWlQaxskSrmwUsMA+qq
	 KqWTL9udR61ciUwNvkS//ZpPW3RkSzCZ6hArRAL0PO7yLA5HkNNi+ajD4qNUZ99i8n
	 Y2sSnnwbhqdmFXsHpOBKGjonPML8a0z3nud0gWX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfGCJLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfGCJLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:11:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25E7C218A3;
        Wed,  3 Jul 2019 09:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562145102;
        bh=9vDex9XUCwSmQC+2Hghtv36ZpISxOwD/Gmf81nZlWik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5FCR2G3XnAaeilDKP19uypgCUb0wqMcOmEBfO/jblK4DOr6tihH5MsIH6fipmS65
         G8iSU3ZrboYUFjeH1oDxFgLMpPjKaESVELcLTGe2s6zTN4mAy/QSPEqKcFSIQFwxYS
         tT06n2YzFxi2e7mQ7oHX15TBNHIX/P+g4a6PnRNI=
Date:   Wed, 3 Jul 2019 11:11:39 +0200
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
Subject: Re: [PATCH 5.1 00/55] 5.1.16-stable review
Message-ID: <20190703091139.GB12289@kroah.com>
References: <20190702080124.103022729@linuxfoundation.org>
 <CA+G9fYsJjfb2HakVDzUyuf9G9cQeO2DD0ErPQNHfVmKCv47BTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsJjfb2HakVDzUyuf9G9cQeO2DD0ErPQNHfVmKCv47BTA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 11:09:47PM +0530, Naresh Kamboju wrote:
> On Tue, 2 Jul 2019 at 13:34, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.1.16 release.
> > There are 55 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu 04 Jul 2019 07:59:45 AM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.16-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Great, thanks for testing and letting me know.

greg k-h
