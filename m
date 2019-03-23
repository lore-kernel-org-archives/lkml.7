Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB49C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5713C218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553324012;
	bh=HIrGCwioA/5bAPhN7nlHjKFq0oSQxap2fIyFELLnbF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bRbMjigjsY6iF4ORSoNmz1pYGvYTB8qERz6qgbrAIE+A/fJDSi7jP6FSvGo3fA0jU
	 YdudCJPoXW1EOnI6h7rtywmtCQwDwRbJSyzUnuXYxTPagqa6InZQM5VTZtkEwH/5HQ
	 PnppFlqunpZlMbScyScUwudoHk3IFDZW7dMiQmsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfCWGxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 02:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfCWGxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 02:53:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D513218E2;
        Sat, 23 Mar 2019 06:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553323984;
        bh=HIrGCwioA/5bAPhN7nlHjKFq0oSQxap2fIyFELLnbF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbMvpnewIzHIgpk5vDpkCXMdHaf/k8OJHpGgtTe0xROj+yW8jdgdnYpOhyV25jxXW
         iKkhROpgniEo88EsMDjy1lcTKj4mHNXfkdI+36426AJoA5Bw0SwbGhPMcWPTiHPmrH
         tfjMZkICl5ta0O8xDjPlFdCZlHxUpcq+XF0PGsQw=
Date:   Sat, 23 Mar 2019 07:53:02 +0100
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
Subject: Re: [PATCH 5.0 000/238] 5.0.4-stable review
Message-ID: <20190323065302.GC13517@kroah.com>
References: <20190322111258.383569278@linuxfoundation.org>
 <CA+G9fYuzz8rkvdVMk+D2qm0pF5sFVmSbq+ad7434N_xe6D94yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuzz8rkvdVMk+D2qm0pF5sFVmSbq+ad7434N_xe6D94yw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 11:17:52AM +0530, Naresh Kamboju wrote:
> On Fri, 22 Mar 2019 at 17:42, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.0.4 release.
> > There are 238 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun Mar 24 11:11:13 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.4-rc1.gz
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

Great!  Thanks for testing 5 of these and letting me know.

greg k-h
