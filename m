Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC03EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AFB218BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AR+dqbRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfHSSaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:30:06 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7014 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfHSSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:30:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5aeaad0003>; Mon, 19 Aug 2019 11:30:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 19 Aug 2019 11:30:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 19 Aug 2019 11:30:05 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Aug
 2019 18:30:05 +0000
Received: from [10.2.161.11] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Aug
 2019 18:30:04 +0000
Subject: Re: [PATCH v2] checkpatch: add *_NOTIFIER_HEAD as var definition
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
CC:     Ofir Drang <ofir.drang@arm.com>, <linux-kernel@vger.kernel.org>
References: <20190819122917.11896-1-gilad@benyossef.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <777c39df-bef3-e095-7299-80f55b50158a@nvidia.com>
Date:   Mon, 19 Aug 2019 11:28:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819122917.11896-1-gilad@benyossef.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566239406; bh=Jb1DdjNDJxDnlJTqH9Z+PLXo3NOtPCtLYKJZYvI+tD0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AR+dqbRjBi6fXBg8VaREZztD0w9FDDOwZuwKb6Hbj6TqNztrbIQD7T2/GDglWA5eo
         KdU5D+ETpxgsrzDoL3japeA8136ahKZ0APDjwuEnYcttpG+vAm+NmAEo+8JYCyGXFI
         xxqoBI383Hw5G60n+QQT8ljRFukvv+5WMemCCp2zhyhLS63anMJhxG4yx4q91qT3vs
         Zrm6Ap53oYhvdWhyp5nuNIpJh5tBdAtgF47/IXUMy2+dq6tvKCwQ5RL+zzHWdX4iqz
         xX+MOqd9zdGkj63fiXSqY7hovbUSw9vcTniOUtUaaDGtqMgN+U2W6qloogBPBODxZY
         VufAJIBDGcV/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/19 5:29 AM, Gilad Ben-Yossef wrote:
> Add *_NOTIFIER_HEAD as variable definition to avoid code like this:
> 
> ATOMIC_NOTIFIER_HEAD(foo);
> EXPORT_SYMBOL_GPL(foo);
> 
>  From triggering the the following warning:
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Changes from v1:
> - Fixed misposition of braces.
> - Tested on 1k last commits from Linux tree.

Hi Gilad,

I re-ran this updated patch, on my local patches that were showing the problem,
and it is All Better Now. :)  So you can add:

     Tested-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
>   scripts/checkpatch.pl | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 93a7edfe0f05..8bc0e753a329 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3864,6 +3864,7 @@ sub process {
>   				^.DEFINE_$Ident\(\Q$name\E\)|
>   				^.DECLARE_$Ident\(\Q$name\E\)|
>   				^.LIST_HEAD\(\Q$name\E\)|
> +				^.${Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
>   				^.(?:$Storage\s+)?$Type\s*\(\s*\*\s*\Q$name\E\s*\)\s*\(|
>   				\b\Q$name\E(?:\s+$Attribute)*\s*(?:;|=|\[|\()
>   			    )/x) {
> 
