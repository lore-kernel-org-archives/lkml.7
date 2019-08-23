Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ED9C41514
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 22:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FB82173B
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 22:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566597928;
	bh=H72hswumt/HwWDyehWRl4xZd7H5XfC9umfOF/PVPV1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p8FNM8uguBTojznRtyfHXcQVFb5B4Ovk9kjf249drtas8pwcLecaYr8LtWqC+Tu8O
	 sLzSZtROmtwL9grodIaSWjpqls3ZR3Y1zjdInS5tSzpuDUTO3FPAEfRSymUI+J0Nch
	 5Ba+T4SlpYkYfrqLFOytdlADCujauSE+TvJ4JvGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393432AbfHWWF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 18:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392604AbfHWWF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 18:05:27 -0400
Received: from localhost (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F15421019;
        Fri, 23 Aug 2019 22:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566597926;
        bh=H72hswumt/HwWDyehWRl4xZd7H5XfC9umfOF/PVPV1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bWknkq+lIb0Dw6wX0MOap8tkKNsupR2AOfC7Bl7HuS0cPmj3qR0VcH+d+ds70oJb3
         k9D+6NBGyPphV5f/pS/R2VWn+eWiWV6zofAcC0TbG63owZak86XFMwhwSLRNFVLR73
         SZvrrJ3OYBp+Vbhs9FFPSocaK3DCMN/sidbpzdDs=
Date:   Fri, 23 Aug 2019 18:05:23 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org
Subject: Re: [PATCH 5.2 000/135] 5.2.10-stable review
Message-ID: <20190823220523.GF1581@sasha-vm>
References: <20190822170811.13303-1-sashal@kernel.org>
 <00216731-a088-7d47-eafb-70409f876bda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <00216731-a088-7d47-eafb-70409f876bda@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 12:41:03PM -0600, shuah wrote:
>On 8/22/19 11:05 AM, Sasha Levin wrote:
>>
>>This is the start of the stable review cycle for the 5.2.10 release.
>>There are 135 patches in this series, all will be posted as a response
>>to this one.  If anyone has any issues with these being applied, please
>>let me know.
>>
>>Responses should be made by Sat 24 Aug 2019 05:07:10 PM UTC.
>>Anything received after that time might be too late.
>>
>>The whole patch series can be found in one patch at:
>>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-5.2.10-rc1.gz
>
>I am seeing "Sorry I can't find your kernels". Is this posted?

I proposed that we stop uploading the patch to see if anyone is actually
using it.

An alternative would be to use the git web interface instead, so for
example a patch file for 5.2.10-rc1 can be generated at:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.2.y&id2=v5.2.9

--
Thanks,
Sasha
