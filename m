Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBCDC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D832084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556212143;
	bh=Z0DkJi0ys+baDYC3c0RlBG7F+ZKBibIbe4bsebiBhGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DpCMchz8+igOIZD/YZRPZkDT29+7PZGnBu7wMgZ7kH9E2/Okuzo5cFYGI0Nik3q5c
	 iQoz6wAD1a/2rta9wXb9MNoa9g4XK1/otnJwvNgLzLk7L8PcrRTWwt8kmS8ZH8iAGu
	 PdHWU5mX8msHo7zg7BwBOPfyg8qKXUqhum3M2y+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfDYRJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfDYRJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:09:01 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E00EA20717;
        Thu, 25 Apr 2019 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556212141;
        bh=Z0DkJi0ys+baDYC3c0RlBG7F+ZKBibIbe4bsebiBhGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJ9f2/J8XUY/eunrkR1awe6JJJF2toUomntN/evTZ2NVDSjBiNO6ftremhZzPF45N
         7ock+Hdddv0KQbK3X2VF36BwaPHGUo/Bb8ijtEi4l7SpEZBXGBf8eoqpV/9aWfvnbv
         pvBYFzh0q6hi9C2yYcsz2L6yYS+feaDuNWUO+0Lc=
Date:   Thu, 25 Apr 2019 19:08:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/115] 5.0.10-stable review
Message-ID: <20190425170858.GA11105@kroah.com>
References: <20190424170924.797924502@linuxfoundation.org>
 <0f4261a5-53b0-4c10-5dbe-fbb02a4f47ad@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f4261a5-53b0-4c10-5dbe-fbb02a4f47ad@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:23:57AM -0600, shuah wrote:
> On 4/24/19 11:08 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.10 release.
> > There are 115 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri 26 Apr 2019 05:07:37 PM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.10-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Great!  Thanks for testing all 6 of these and letting me know.

greg k-h
