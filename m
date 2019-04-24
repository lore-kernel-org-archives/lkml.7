Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B1FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6537A218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fu0+ouaI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fu0+ouaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDXFT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:19:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDXFT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 01:19:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A8AEC60595; Wed, 24 Apr 2019 05:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556083197;
        bh=zME25W7paQVjThAQm+cy1SXzlW2OlpHZ3PZ3PnN6pGk=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Fu0+ouaI36bGheCihKy7nOl5G6nHTDC+oTNks2TyzX1HnQUl5+fcnefTr3uiLpaby
         x0H0rsz3+Cs9im7Ba6UHoqhSHE3/X6a/EMGixXhGaaml+JA8RNkiRFixxdLkdEFTpd
         hw5spCnOKkkdzkf9WAXQArvwzxFxJkzqI6PJG3IE=
Received: from [10.204.78.109] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 192E66053D;
        Wed, 24 Apr 2019 05:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556083197;
        bh=zME25W7paQVjThAQm+cy1SXzlW2OlpHZ3PZ3PnN6pGk=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Fu0+ouaI36bGheCihKy7nOl5G6nHTDC+oTNks2TyzX1HnQUl5+fcnefTr3uiLpaby
         x0H0rsz3+Cs9im7Ba6UHoqhSHE3/X6a/EMGixXhGaaml+JA8RNkiRFixxdLkdEFTpd
         hw5spCnOKkkdzkf9WAXQArvwzxFxJkzqI6PJG3IE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 192E66053D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH v2] nvmem: core: add NVMEM_SYSFS Kconfig
From:   Gaurav Kohli <gkohli@codeaurora.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        gregkh@linuxfoundation.org
Cc:     maxime.ripard@bootlin.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190416095924.17428-1-srinivas.kandagatla@linaro.org>
 <20190416110144.GS2654@lahna.fi.intel.com>
 <06b77a2d-a675-965d-224f-14ad8d9df106@codeaurora.org>
Message-ID: <53011190-c0b7-a1de-c434-a7978975c5a1@codeaurora.org>
Date:   Wed, 24 Apr 2019 10:49:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <06b77a2d-a675-965d-224f-14ad8d9df106@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

Sorry for spam,

when is the plan to merge this patch.

Regards
Gaurav

On 4/16/2019 4:45 PM, Gaurav Kohli wrote:
> Hi ,
> 
> I have reviewed and tested for both enabled and disabled and working as 
> expected.
> 
> Please feel free to add:
> 
> Reviewed-by: Gaurav Kohli <gkohli@codeaurora.org>
> Tested-by: Gaurav Kohli <gkohli@codeaurora.org>
> 
> Regards
> Gaurav
> On 4/16/2019 4:31 PM, Mika Westerberg wrote:
>> On Tue, Apr 16, 2019 at 10:59:24AM +0100, Srinivas Kandagatla wrote:
>>> Many nvmem providers are not very keen on having default sysfs
>>> nvmem entry, as most of the usecases for them are inside kernel
>>> itself. And in some cases read/writes to some areas in nvmem are
>>> restricted and trapped at secure monitor level, so accessing them
>>> from userspace would result in board reboots.
>>>
>>> This patch adds new NVMEM_SYSFS Kconfig to make binary sysfs entry
>>> an optional one. This provision will give more flexibility to users.
>>> This patch also moves existing sysfs code to a new file so that its
>>> not compiled in when its not really required.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
