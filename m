Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7B0C0650F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D44214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565052714;
	bh=Z+9tk3MU66K/tksiFxT3MI1Hc0PsUoTRcxWNrN/xtyc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=h2AQ/nqbxr8ZXDtZzHQKNZGw1SVBQ8q9OWclD4/uFa9qGtcq3WO4RQQ4MGAXT3fQ7
	 XXftdqKBD3Fe1bYGXcL8o47ST72T8bBc0dZGg82aLPZnpYxrVorBGox0vW+oMOFqrJ
	 WrqQbiAF8/9evMOHnzARNWXu/ty8+DcV4KB+qnpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfHFAvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 20:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729383AbfHFAvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:51:53 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B3D2147A;
        Tue,  6 Aug 2019 00:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565052712;
        bh=Z+9tk3MU66K/tksiFxT3MI1Hc0PsUoTRcxWNrN/xtyc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XQDLZWdKWsVDMr+DL3NrjCaZVKK5JNizg+H/cHDpZWeS56OtRgFVN34WpIGj5EUyK
         XOiJnjMSOYp2Cw+KdRTaN1A4XAsHu6ndOSR7QU4OCjZJTtJyrWDVXDYApFfH4B5BhG
         2VND5m/8JjvhYGfki9lAtS6UrmwAuPlPrFwSbUww=
Subject: Re: [PATCH 5.2 000/131] 5.2.7-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190805124951.453337465@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <f2ee51eb-d1e2-1a19-d1a2-dfa181530e03@kernel.org>
Date:   Mon, 5 Aug 2019 18:51:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/19 7:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.2.7 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 07 Aug 2019 12:47:58 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

