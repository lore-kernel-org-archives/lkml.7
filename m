Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B2FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CC120842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551802315;
	bh=kyoptJdtsUD0bu7BBCfxDFskMQXGvh7ho0laORoURj8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=WobbXbz0XMZyafr60aP1LNe5mHICMNU5eDO9Vef7olgVGUW7dcjFkiVex9Mir486c
	 NRMG2oL3wBWgcnh9nGuzkTjLOJAutUWHXEi76+oHtFn+linf33SjjDrb5Di0OsKIYo
	 iz/G7o9UY4HbT40D/KdmHdLhHBh3GEg5fSWbC61s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfCEQLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:11:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfCEQLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:11:53 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C0AB20449;
        Tue,  5 Mar 2019 16:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551802313;
        bh=kyoptJdtsUD0bu7BBCfxDFskMQXGvh7ho0laORoURj8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HyV90HUGPSsrCFEpq9nXhSq8dy/Lel6edaxgstjytKZNqXnK6+ULQVzXrT0Rafbc/
         1VLuH9Gx2SfCu7H9oWIZ1ywfg4Kx8nyya9iArH2UsAbKzRPDI7XDEcBEu22Cj1jdo3
         mBQKuCNO6psgffY85ypjl6PGdHkVT44KGalfZClU=
Subject: Re: [PATCH 4.14 00/52] 4.14.105-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190304081617.159014799@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <abc898f4-1bc3-1cf1-ae3e-fe3be67bdfab@kernel.org>
Date:   Tue, 5 Mar 2019 09:11:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 1:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.105 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  6 08:15:55 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.105-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
