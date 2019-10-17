Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363A9FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B452089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=didiksetiawan.com header.i=ds@didiksetiawan.com header.b="s2139HCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441454AbfJQSsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:48:23 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21428 "EHLO
        sender4-of-o54.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439013AbfJQSsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:48:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571338069; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Www9cc6as7sGSUWo22eft9eSTRijnWhppZ5/cL4pELPU6pdY3l5AfA/4Ie63J4i5HNgsfZ2f/h2n+X6AeF9P+FzEyKSaxA9KNFa7FhxnA76WE+BYENY4kdrLFIubLv0KSjhU3tw1dCxisZvKLKr45AEBglHEf59Yg3OAzXW0oI0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1571338069; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ZRjH4bAY0ZgjjEFktByZAYcIARBeWLfYjLwHzV7K2bU=; 
        b=YMmKF8ND2VBwUsVsyhPGjdPG8qAyiSRPc5kz0zzg0KwDKmynQXL+VI6fls4wLToYhkCHOsuMXxOcyxbgnyO3wp9JXS5wQu95l9kEfJaBFHB98LQvA/aWRN2IM4Ym8c2uECwBdnCHt76ag+9KafCrGJAPX5wirn1N5Z1UpDGAuGE=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=didiksetiawan.com;
        spf=pass  smtp.mailfrom=ds@didiksetiawan.com;
        dmarc=pass header.from=<ds@didiksetiawan.com> header.from=<ds@didiksetiawan.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571338069;
        s=zoho; d=didiksetiawan.com; i=ds@didiksetiawan.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=858; bh=ZRjH4bAY0ZgjjEFktByZAYcIARBeWLfYjLwHzV7K2bU=;
        b=s2139HCYORdRx/td1j9ZAcVvIvoXatlzQE9UM+rmePexPIV6jy5YlF4BgWRntCsB
        OLQRPzgCc7hjjL9uzw2L6Rw1S8uU5HNQHxDjX6Oc0KVAT7xCBi+IL3SAblgRA3+sTKT
        9pDoDDePoR8pP63MS6lW18Mnl6nOiP/yt1dE8wrE=
Received: from thinkpad-e420s (120.188.94.47 [120.188.94.47]) by mx.zohomail.com
        with SMTPS id 1571338068643635.640689053295; Thu, 17 Oct 2019 11:47:48 -0700 (PDT)
Date:   Fri, 18 Oct 2019 01:47:38 +0700
From:   Didik Setiawan <ds@didiksetiawan.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/92] 4.9.197-stable review
Message-ID: <20191017184738.GA10314@thinkpad-e420s>
References: <20191016214759.600329427@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 02:49:33PM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.197 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 18 Oct 2019 09:43:41 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.197-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
 
Compiled, booted, and no regressions found on my x86_64 system.

Thanks,
Didik Setiawan

