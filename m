Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13DCC76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 03:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95EB2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 03:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VgFnL306"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfGQDzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 23:55:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbfGQDzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 23:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vyR2W0buEBQBwHqzpo3Kuz2YKIBskwD7RiIVEkP3yqY=; b=VgFnL306MBZB234zHxrAop3yh
        J60H45jix4Wp/MlViHpGWFIhp5Jf83Obs/3zEV9kF3cS/eGCH677S46DrgYTo2i5lD1eW+HRToZVq
        4yioavcYl//gv15+4hlnR5t7JXIBS3B0eoiHp+hwD9D8FZV0kGRrhl5wZmQYm84xs8uLjsLIWIKwB
        ik9Qt8RW1ywSFw+L2KmAQxw2MNn112vNiDAd04ZVKIAKdEulquWRhtNQ1kcbRzTQUh4BPyA+KV4xa
        UrNj0oqYk0/juwr7JuzNzYSW2CANtWm/W4j/k+CTcwi10FAZx78aG9AOg7Y4nFJk30b0lGstv1TBA
        6GiVaCVcQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnb1v-0004sI-Vk; Wed, 17 Jul 2019 03:55:00 +0000
Subject: Re: mmotm 2019-07-16-17-14 uploaded
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
References: <20190717001534.83sL1%akpm@linux-foundation.org>
 <8165e113-6da1-c4c0-69eb-37b2d63ceed9@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d2b7b174-36b2-e0f5-a98f-2b538eab6b6c@infradead.org>
Date:   Tue, 16 Jul 2019 20:54:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8165e113-6da1-c4c0-69eb-37b2d63ceed9@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/19 8:50 PM, Randy Dunlap wrote:
> On 7/16/19 5:15 PM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2019-07-16-17-14 has been uploaded to
>>
>>    http://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> http://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
> 
> drivers/gpu/drm/amd/amdgpu/Kconfig contains this (from linux-next.patch):
> 
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig~linux-next
> +++ a/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -27,7 +27,12 @@ config DRM_AMDGPU_CIK
>  config DRM_AMDGPU_USERPTR
>  	bool "Always enable userptr write support"
>  	depends on DRM_AMDGPU
> +<<<<<<< HEAD
>  	depends on HMM_MIRROR
> +=======
> +	depends on ARCH_HAS_HMM
> +	select HMM_MIRROR
> +>>>>>>> linux-next/akpm-base
>  	help
>  	  This option selects CONFIG_HMM and CONFIG_HMM_MIRROR if it
>  	  isn't already selected to enabled full userptr support.
> 
> which causes a lot of problems.
> 
> 

include/uapi/linux/magic.h:
<<<<<<< HEAD
=======
#define Z3FOLD_MAGIC		0x33
>>>>>>> linux-next/akpm-base


-- 
~Randy
