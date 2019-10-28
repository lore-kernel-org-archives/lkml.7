Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBD1CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851C1208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=didiksetiawan.com header.i=ds@didiksetiawan.com header.b="HnPHp53q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbfJ1JB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:01:58 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21486 "EHLO
        sender4-of-o54.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbfJ1JB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:01:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572253275; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=lhDVYBvbUlvYEKNHfNCKJorr3G1gOtXc0ZJAd4suFm6eiCgI36Islda4iAPvKb+VgB4UmQVe+/jE9loSc5Tpq5d10hyVOsl4dbvETZbBeLtSPUoUpYL+z/W9yaBH5l8J3k5g1rVkcUMQKevRG0WYWoYxUsNxeIxwVtIgeS/Rywk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1572253275; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=zfm0eWFGyzNC3X35RSPgtJ2GmBp/ytKiZ+9RKY0B63U=; 
        b=OVZKoPNyEKwOYsi3G63FpVfgiv7wYVFJjQVlafQDaHJfTEo8+JAv8NK76bOFvd8E6HSNlABZRe0Dz2wjCjjIVQmm2zCz/KVg+K94WvZH1ozPJ4oMqUL/BFTZzlSfuw1mSf+XT7EQrYl1le0P6yp+xHsvJ4YfuxqZrJzpwoj6Gmk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=didiksetiawan.com;
        spf=pass  smtp.mailfrom=ds@didiksetiawan.com;
        dmarc=pass header.from=<ds@didiksetiawan.com> header.from=<ds@didiksetiawan.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572253275;
        s=zoho; d=didiksetiawan.com; i=ds@didiksetiawan.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=859; bh=zfm0eWFGyzNC3X35RSPgtJ2GmBp/ytKiZ+9RKY0B63U=;
        b=HnPHp53qkpagmRsBBOPA8SyxqmdhuwG/0K3LNGO3GBrx1XyvPNM5FK0aWXovqog6
        k/NOYCFrhklVUctxMnTY9YTuykakQKRglBTUAB7axC61/rvjjLu3di+6VlNxTKxTVWf
        +MMckWkuswIKKHUisdl1Cx6pyjaOJYCcCBf33gxA=
Received: from notebook (117.102.74.82 [117.102.74.82]) by mx.zohomail.com
        with SMTPS id 157225327412266.43741326792463; Mon, 28 Oct 2019 02:01:14 -0700 (PDT)
Date:   Mon, 28 Oct 2019 16:01:08 +0700
From:   Didik Setiawan <ds@didiksetiawan.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/93] 4.19.81-stable review
Message-ID: <20191028090108.GA3678@notebook>
References: <20191027203251.029297948@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 10:00:12PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.81 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue 29 Oct 2019 08:27:02 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.81-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Compiled, booted, and no regressions found on my x86_64 system.

Thanks,
Didik Setiawan

