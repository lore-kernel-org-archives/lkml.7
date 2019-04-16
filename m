Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3A3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A9B2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CrGshxtP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fRJxlcsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfDPLQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:16:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47372 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfDPLQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:16:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7B44161132; Tue, 16 Apr 2019 11:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555413359;
        bh=U+GdDLiBFARi9OlU9psDZL5d9bLeA7eZk+vBNY9dub4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CrGshxtPe9HTx2miaTs5fzRaUjSQpJdYaNnZ7hYNVmbkx7xHwp8ftZDRn/7wV7o/3
         tObUGViPEiBgro3hf9LPhlttZl3awU6ss/8tnDlndcv33he+ZEnM2pL6IR92ovQqze
         espZBjcB8jhRST6aT9e9ABVgV2RErOjn0WDoNXes=
Received: from [10.204.78.109] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C48E260E75;
        Tue, 16 Apr 2019 11:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555413358;
        bh=U+GdDLiBFARi9OlU9psDZL5d9bLeA7eZk+vBNY9dub4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fRJxlcsWXh2NrEo7MBh+pta3e3xjxXPXpQFi1Uvujbb2ARCVjPSp0r9FqV6XU13s/
         JSoKom2/WO0jumqRpoT0Xnn/UxORNXJTx8qT8/NNerZL8ngmBiuiYoRzjrGcLxdGlk
         tpiljGAIejp8JVobZYxBWJmrEpn5NJz16qlRLEhI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C48E260E75
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH v2] nvmem: core: add NVMEM_SYSFS Kconfig
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, maxime.ripard@bootlin.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190416095924.17428-1-srinivas.kandagatla@linaro.org>
 <20190416110144.GS2654@lahna.fi.intel.com>
From:   Gaurav Kohli <gkohli@codeaurora.org>
Message-ID: <06b77a2d-a675-965d-224f-14ad8d9df106@codeaurora.org>
Date:   Tue, 16 Apr 2019 16:45:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416110144.GS2654@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

I have reviewed and tested for both enabled and disabled and working as 
expected.

Please feel free to add:

Reviewed-by: Gaurav Kohli <gkohli@codeaurora.org>
Tested-by: Gaurav Kohli <gkohli@codeaurora.org>

Regards
Gaurav
On 4/16/2019 4:31 PM, Mika Westerberg wrote:
> On Tue, Apr 16, 2019 at 10:59:24AM +0100, Srinivas Kandagatla wrote:
>> Many nvmem providers are not very keen on having default sysfs
>> nvmem entry, as most of the usecases for them are inside kernel
>> itself. And in some cases read/writes to some areas in nvmem are
>> restricted and trapped at secure monitor level, so accessing them
>> from userspace would result in board reboots.
>>
>> This patch adds new NVMEM_SYSFS Kconfig to make binary sysfs entry
>> an optional one. This provision will give more flexibility to users.
>> This patch also moves existing sysfs code to a new file so that its
>> not compiled in when its not really required.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
