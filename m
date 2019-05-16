Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3C4C04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA0D21473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SwoVfhlJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SwoVfhlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfEPBrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:47:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57784 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfEPBJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 21:09:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E8538608A5; Thu, 16 May 2019 01:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557968993;
        bh=cQq76+TzxEIOrTYAXj+6tOgvQ0AcPkRO0c35l9YJI04=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SwoVfhlJWk/EkeAW1fWE1QLQlUPKJvTjkZduF7TXTkK7oUUbnlP8nk9jzqNvQymq0
         U1z/AzggWUomKJtvzlbNQOeCfAmgBKTcLuzeQhd4c1S4KtvuA2SRTEs0sYL2IOmiiQ
         mKgB6z4bHEUO1eysqe8Hd+1NkPbV/8kIGFs2bMhk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E859E60709;
        Thu, 16 May 2019 01:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557968993;
        bh=cQq76+TzxEIOrTYAXj+6tOgvQ0AcPkRO0c35l9YJI04=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SwoVfhlJWk/EkeAW1fWE1QLQlUPKJvTjkZduF7TXTkK7oUUbnlP8nk9jzqNvQymq0
         U1z/AzggWUomKJtvzlbNQOeCfAmgBKTcLuzeQhd4c1S4KtvuA2SRTEs0sYL2IOmiiQ
         mKgB6z4bHEUO1eysqe8Hd+1NkPbV/8kIGFs2bMhk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 15 May 2019 19:09:52 -0600
From:   Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
To:     Alex Elder <elder@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        stranche@codeaurora.org, YueHaibing <yuehaibing@huawei.com>,
        Joe Perches <joe@perches.com>, syadagir@codeaurora.org,
        mjavid@codeaurora.org, evgreen@chromium.org, benchan@google.com,
        ejcaruso@google.com, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/18] soc: qcom: create "include/soc/qcom/rmnet.h"
In-Reply-To: <9cae00c4-29ab-6c3e-7437-6ed878a3061f@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-3-elder@linaro.org>
 <CAK8P3a16HpKEUB7_6G_W_RKkyVeVBW_rofLbdhC2QmWjVOAHMg@mail.gmail.com>
 <9cae00c4-29ab-6c3e-7437-6ed878a3061f@linaro.org>
Message-ID: <005ae8fb4ea9ba86fd0924b1719f1753@codeaurora.org>
X-Sender: subashab@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +#ifndef _SOC_QCOM_RMNET_H_
>>> +#define _SOC_QCOM_RMNET_H_
>>> +
>>> +#include <linux/types.h>
>>> +
>>> +/* Header structure that precedes packets in ETH_P_MAP protocol */
>>> +struct rmnet_map_header {
>>> +       u8  pad_len             : 6;
>>> +       u8  reserved_bit        : 1;
>>> +       u8  cd_bit              : 1;
>>> +       u8  mux_id;
>>> +       __be16 pkt_len;
>>> +}  __aligned(1);
>> 
>> If we move this into include/soc/, I want the structure to be 
>> portable,
>> and avoid the bit fields. Please use mask/shift operations or the
>> include/linux/bits.h macros instead to make this work with big-endian
>> kernels.
> 
> Sure, I'll do that.  I did that everywhere else in the driver,
> but here I just tried to preserve the original code as I moved
> it.  I will update at least these structures, and all existing
> code (plus the IPA code) to use fields masks.
> 
> 					-Alex
>> 
>>      Arnd
>> 

Hi Alex

Could we instead have the rmnet header definition in
include/linux/if_rmnet.h

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
