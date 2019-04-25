Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04703C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8602088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556209597;
	bh=eL3h6L+dEemWppAf9tFcdWtKS3g4fMNL2TFqGJ476lo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=nSLvKTTHKny7XKCFQ0nKEo0s4uMD58gTgXym90CAIwhQpsTCvq7YEw0vsW6rqmHTW
	 9VQEQM9lTFv9XVyRTpxHl7/P1oV5YTehKM34xymCweHL+E5soVlvSzPv5qYmUi9muA
	 fvPdiLSDH291J97d4DDbbxamQLHoNIjJ9sujYbss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfDYQ0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729304AbfDYQ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:26:32 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87C772077C;
        Thu, 25 Apr 2019 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556209593;
        bh=eL3h6L+dEemWppAf9tFcdWtKS3g4fMNL2TFqGJ476lo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=u109q5jPbdpYtlhtSAHw4IiUdjWg5CNoV54CAReEGC1FXU3Xzn6j+g17VDV/Pw5qN
         IcfU/Vn5RDSOaS5OVLpSf7zA24lGNNdYsmgB12dKsFKXFrC2Hq89Rf1+nBEjDchTS/
         HwP2GZM+QisKSXDOApLygN8zlG/qCUl+RNLehlWE=
Subject: Re: [PATCH 4.9 00/44] 4.9.171-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190424170839.924291114@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <4ce88cec-1581-4600-8c12-dd3676b3cfb1@kernel.org>
Date:   Thu, 25 Apr 2019 10:26:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424170839.924291114@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 11:09 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.171 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 26 Apr 2019 05:07:31 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.171-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
