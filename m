Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13B8C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4D7227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576816219;
	bh=VJGqaYnhSm2JshvldWioV0bz4Nr/0zvVu1IPlllhtIw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=JAPxpoSTAO5lvN2IQxKe42Wo+O2Obwg9ospFDNs8mJhnYixdGUsYOrSipKLi1LiO3
	 yXrUGMpEIBr9acs+UbdLkVrwXIklt4RQNYFv4Wl1pwjLPGaedvSB6iSNHxuCicF/4h
	 Ci8hnWcpS6IHZqRD7BvdKgB5qE/WjwwcfKOYcuAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfLTEaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 23:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfLTEaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:30:18 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BD4121D7D;
        Fri, 20 Dec 2019 04:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576816217;
        bh=VJGqaYnhSm2JshvldWioV0bz4Nr/0zvVu1IPlllhtIw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dP9zHZHuQeIEvJJYkGeUDAPKa3eS0bL7mkNuh/dSCdbd+bTNydlvQimN/M0oMHDVC
         m8Kp3tiAbbXoPZ8pR0TBtnpvm0l2P50kjyur5Cyx8aL73BdWeDrWiUukLxwEK833xV
         NGAOBUZ1cBiQmXsFDyyyG22CjQWAtbGQgmIc9zrk=
Subject: Re: [PATCH 5.4 00/80] 5.4.6-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191219183031.278083125@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <edc11c7b-86a5-319d-a2c0-640234eb1003@kernel.org>
Date:   Thu, 19 Dec 2019 21:30:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/19 11:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.6 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 21 Dec 2019 18:24:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

