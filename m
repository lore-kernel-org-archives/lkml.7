Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2564AC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2251214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565069682;
	bh=l8IZdlPttsnsqFsNXrdJw8WPUqKCI0w3FvnJ8v0WgUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o3i3dLiOyQ34fXjL9UP1zERgG9IHVGmoKQF88cvKV0VrSmWSUL18znJgYCH/E6UDh
	 cjYvQ7ZoW1NE26oPMYZ45LBEL06JChYJgX6VTXCd2u76y7ZfEiF6zxuqnlgBk7hZfX
	 7syx7orK10AnN8WfjBTnbdiMDyIhTBxx31ykAw5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbfHFFel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 01:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfHFFek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:34:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E31820665;
        Tue,  6 Aug 2019 05:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565069679;
        bh=l8IZdlPttsnsqFsNXrdJw8WPUqKCI0w3FvnJ8v0WgUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TaRKP7RSUz17bpNvQJDe4W1T+7o4TCdNsK7sCq+XdxFzwtxzwnyzkj1a/AdobH52b
         mjckSh3PB4rkLKXKfYaYJoonJndr6nwmD0t3iX1jM/r8YuHcoj+THvaInhS6tFmt1w
         NgC1yP+NiW+eGw/QasMjQABxonxcq8TaDMygPzPQ=
Date:   Tue, 6 Aug 2019 07:34:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.2 000/131] 5.2.7-stable review
Message-ID: <20190806053437.GA14052@kroah.com>
References: <20190805124951.453337465@linuxfoundation.org>
 <f2ee51eb-d1e2-1a19-d1a2-dfa181530e03@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ee51eb-d1e2-1a19-d1a2-dfa181530e03@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 06:51:51PM -0600, shuah wrote:
> On 8/5/19 7:01 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.2.7 release.
> > There are 131 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed 07 Aug 2019 12:47:58 PM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.7-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
