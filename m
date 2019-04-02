Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EACC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59BE21473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ki8ugfsH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FfWNOofr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbfDBL65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:58:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60494 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730684AbfDBL6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:58:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 37BD160350; Tue,  2 Apr 2019 11:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554206335;
        bh=65r4/OALWg0ucr4XJQLnYELcYjf1mVsr/lEGIatS9ig=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ki8ugfsHftfNnYWMSpOF7nXajK73/OCpUcN/t6bxhx1ilRrT8MHHYobPLJSTLtvsb
         pFDumuWkzxPw9pKR9fuHk7nvjlkJZ97k+X2eWcb87B7786LZDhhmEBuigW351rRKpH
         7ag+28zDWBCkdCioYEJAYM4bJQVqN3zQqVhELv8w=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B3AE602BA;
        Tue,  2 Apr 2019 11:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554206334;
        bh=65r4/OALWg0ucr4XJQLnYELcYjf1mVsr/lEGIatS9ig=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FfWNOofr6mkOame8R0NqT/tAAdP/ZBraQ4ayLA0rOGKwYSBb1KNo59cr4isZblFBE
         isOF6ubKtf0uC9Yw+9+dUYuahTNW7e4lbICaJ2qj3jPqFr1j20O12ymQ7qk8E2Cph0
         jpwwixiN5ZECA/7x8JSFNA4Piu4xCd2r2i2pJmdM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B3AE602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] fs: kernfs: Corrected spelling mistake
To:     Christina Quast <cquast@hanoverdisplays.com>
Cc:     trivial@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
References: <20190402114414.23767-1-cquast@hanoverdisplays.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <3485e510-623c-dc08-35d7-c5f4f1606082@codeaurora.org>
Date:   Tue, 2 Apr 2019 17:28:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402114414.23767-1-cquast@hanoverdisplays.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flies => files

On 4/2/2019 5:14 PM, Christina Quast wrote:
> Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   include/linux/kernfs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index c8893f663470..e446ab97ee0c 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -64,7 +64,7 @@ enum kernfs_root_flag {
>   	KERNFS_ROOT_CREATE_DEACTIVATED		= 0x0001,
>   
>   	/*
> -	 * For regular flies, if the opener has CAP_DAC_OVERRIDE, open(2)
> +	 * For regular files, if the opener has CAP_DAC_OVERRIDE, open(2)
>   	 * succeeds regardless of the RW permissions.  sysfs had an extra
>   	 * layer of enforcement where open(2) fails with -EACCES regardless
>   	 * of CAP_DAC_OVERRIDE if the permission doesn't have the
