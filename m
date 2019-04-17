Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCCBC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41DA20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555481740;
	bh=BU0uz6cOEIBqgt7VJoQDU02PRfwgZjs/Vfebs2j6LFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zu07drHtj8HUfFZFC5Tvv7J8jh9EchlT64vjtyMpADfer2xXsjnJDNIyvpGqPdN2W
	 7ffnDwjmUbaxhehBvF7ywshKWFO8l5MsSLuV8H/y9tOa6RFMGJZB5qaVQobsFWVvYk
	 A/aAQeLBwAIOOKqOPlcIZ6RF6wD3Q9IK/5RxqTnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfDQGPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728650AbfDQGPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:15:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53DBF20675;
        Wed, 17 Apr 2019 06:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555481738;
        bh=BU0uz6cOEIBqgt7VJoQDU02PRfwgZjs/Vfebs2j6LFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n9nqh4sGuXkDc9+7jwzyFgTy9kTungpkQ7hcvOx6IYB0smmPoFvGHBNqyTizrhgka
         s28D/PEA8JILglFHd2EVxQ6XoXlyNDgpjVVwfGrFo2oH9NpvPnRyc0btgIaipqTQM0
         hEDEuSQnT1+GXtIsRqvrEEleNiC4MO8Frv4V+NA0=
Date:   Wed, 17 Apr 2019 08:15:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/117] 5.0.8-stable review
Message-ID: <20190417061536.GC18320@kroah.com>
References: <20190415183744.887851196@linuxfoundation.org>
 <d01fd527-fc6d-e86b-6683-cf9767e685ee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d01fd527-fc6d-e86b-6683-cf9767e685ee@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:41:02PM -0600, shuah wrote:
> On 4/15/19 12:59 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.8 release.
> > There are 117 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Apr 17 18:36:42 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.8-rc1.gz
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

Thanks for testing these and letting me know.

greg k-h
