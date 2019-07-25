Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45CCC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9704021852
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PzCmELI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfGYGut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:50:49 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13557 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYGut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:50:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d39514f0000>; Wed, 24 Jul 2019 23:50:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 24 Jul 2019 23:50:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 24 Jul 2019 23:50:48 -0700
Received: from [10.2.160.36] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Jul
 2019 06:50:47 +0000
Subject: Re: [PATCH 1/1] x86/boot: clear some fields explicitly
To:     <hpa@zytor.com>, <john.hubbard@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20190724231528.32381-1-jhubbard@nvidia.com>
 <20190724231528.32381-2-jhubbard@nvidia.com>
 <B7DC31CA-E378-445A-A937-1B99490C77B4@zytor.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f83947fe-8a80-8693-56bd-76cb6f37317e@nvidia.com>
Date:   Wed, 24 Jul 2019 23:49:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <B7DC31CA-E378-445A-A937-1B99490C77B4@zytor.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564037455; bh=MkGMjQ2xdNXJh3r1+WyUXNyGQwiXDPA32+WGo1hqLiY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PzCmELI3ULBQzNXt6IHcPeDyjT5LAQMq+bBfgezlNh2d2dRKcE9niHVttVae9hEU8
         1WzDue89Iornsd3GU9Yd9P6Pxi5kmbq/aEQaZZuDc49Zjx3Y4deGsyphNalbBsAAtC
         WEOch1AUKMdwzPTYM/KOVL/DhucEP7EIdtdmX5wXZcRcV4ZFYX/GjhROOQUVUm+aRu
         4Ojq0f7K49hJvQKg1t5tgnzOiok0mROUVyZoUaMCGzZAQcPO/nuLNQPfT19AFJkMAm
         G9rLTrUjE9mX3a7RQ3kLU7k3gEEPkit31aqIUxHTHS+K8QQrCd3svgs+MArNdwO9NV
         W6igeF9f9ZFbg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/19 7:12 PM, hpa@zytor.com wrote:
> On July 24, 2019 4:15:28 PM PDT, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
...
>> +		boot_params->ext_ramdisk_image = 0;
>> +		boot_params->ext_ramdisk_size = 0;
>> +		boot_params->ext_cmd_line_ptr = 0;
>> +
>> +		memset(&boot_params->_pad4, 0, sizeof(boot_params->_pad4));
>> 		memset(&boot_params->_pad7[0], 0,
>> 		       (char *)&boot_params->edd_mbr_sig_buffer[0] -
>> 			(char *)&boot_params->_pad7[0]);
> 
> The problem with this is that it will break silently when changes are made to this structure.
> 
> So, that is a NAK from me.
> 

Understood. It occurs to me, though, that it would be trivial to
just add build time assertions to check a few struct member offset
values, and fail out if they changed. That would give us everything:
warnings-free builds, and no silent failures.

Thoughts?

thanks,
-- 
John Hubbard
NVIDIA
