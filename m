Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980D9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB722083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ML9wC8mi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Olg4jyS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbfDRKls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:41:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40352 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388301AbfDRKlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:41:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 12C926072E; Thu, 18 Apr 2019 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555584107;
        bh=kXSxlU69iJnb9YGKa0sUqiKcdnF9XirIbZvYmrbqtTQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ML9wC8miyH4A3UlcMICwf0V2FErOvHpxoELhN1gYbI3W9iEJt0YX3wQl1pMvsK+rv
         bFK+cqYgswkcwK/OPYiaDXyRZXWWb0Vax+NxXxDbcZqqzerHEOrSd5oUVG/xf19p08
         BF9SwO/1z1aX/YCbTXDwfWV1VXNCcGgs/0O4q1eA=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 074DA60112;
        Thu, 18 Apr 2019 10:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555584106;
        bh=kXSxlU69iJnb9YGKa0sUqiKcdnF9XirIbZvYmrbqtTQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Olg4jyS40MJM+DdXd9kyYx/UVtK624bzE7x21RjcUIa4mNK9Uaw2LiS2TbgXtlApC
         lPLK8OR6Lw/mXBBfjnMmjqQudzhToIhkgLdqXPbCfPkBtKLGukebsjRtaODvllfq4J
         /Z65W2OBNrXQ/0CLD6kLTPSDhenWcCiwmXGBzEco=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 074DA60112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] char/ipmi: fix spelling mistake "receieved_messages" ->
 "received_messages"
To:     Colin King <colin.king@canonical.com>,
        Aishwarya Pant <aishpant@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190418101502.9748-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <ed610c60-329c-b4fa-56f7-fc6d39808e6c@codeaurora.org>
Date:   Thu, 18 Apr 2019 16:11:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418101502.9748-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/2019 3:45 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the documentation. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   Documentation/ABI/testing/sysfs-devices-platform-ipmi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-ipmi b/Documentation/ABI/testing/sysfs-devices-platform-ipmi
> index 2a781e7513b7..afb5db856e1c 100644
> --- a/Documentation/ABI/testing/sysfs-devices-platform-ipmi
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-ipmi
> @@ -212,7 +212,7 @@ Description:
>   					Messages may be broken into parts if
>   					they are long.
>   
> -		receieved_messages:	(RO) Number of message responses
> +		received_messages:	(RO) Number of message responses
>   					received.
>   
>   		received_message_parts: (RO) Number of message fragments
