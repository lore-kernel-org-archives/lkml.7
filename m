Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B655CC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8121522CF7
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566669790;
	bh=pksJ/7N1JbviwXfAo0PPGp1aR3w+fvJLcubXFSzHysw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Ag5Azrhfd6pPdieEOWDaOexAglJl4gj45Jsk3fJvd7M/L6owJApJ9whfop4WEsv3t
	 C1YlLNrMfDkmedgzeosvVaRVdY9m1kBxfnJk6SYN1ng4Yh1dBEsUcrHJpL23/bFJ/g
	 qL8JPNK92IT84pw7O9pWv0gMwKW2IENGwqfZ+2W0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfHXSDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 14:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfHXSDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 14:03:09 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B8E22CE3;
        Sat, 24 Aug 2019 18:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566669788;
        bh=pksJ/7N1JbviwXfAo0PPGp1aR3w+fvJLcubXFSzHysw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dhhi/3RxMUpbrzAJCkKFa5K9beTWujSnpD5Ul/9IInAlIKjThIQl+FHf5F5+gvj+c
         8bPobPMtiGxo5AmQpXzykT8z1lHKmdVrA76D0SOfR+Fw/o/7fGYNY0O/DmLso24M5S
         /PGRp72H7IBs8rFM60n5MR02QAktbWOG2m592jzA=
Subject: Re: [PATCH 4.4 00/78] 4.4.190-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190822171832.012773482@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <25b2dca3-0cda-e88d-97a3-229e98cce0f6@kernel.org>
Date:   Sat, 24 Aug 2019 12:03:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822171832.012773482@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/19 11:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.190 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 24 Aug 2019 05:18:13 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.190-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

