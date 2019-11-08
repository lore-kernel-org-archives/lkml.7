Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5D3FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1031B222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QZ851sH0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QZ851sH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfKHDbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 22:31:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41802 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfKHDbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:31:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E197A60DA7; Fri,  8 Nov 2019 03:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573183859;
        bh=rHEApjQnqfCTZgUSmDIEe5R3XTHBwcKEcnceTTvqqOA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QZ851sH0LCUcD/iOhvnwNcQBEgoMlJkQZJ8hZJGp4Jnjp6ywX67AxO1eonJ+VwlOc
         +C+qqmPD+moUzeWA63Qd5HPd+cgCOC7Sny4Px7MTt1tqYSuPiHZ9u8MmihbVeoGOeY
         DDpdLXUkHumy28X5QLtuzi2Gd0V8wgOELnzQK/yg=
Received: from [10.206.28.9] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 33C1360D9B;
        Fri,  8 Nov 2019 03:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573183859;
        bh=rHEApjQnqfCTZgUSmDIEe5R3XTHBwcKEcnceTTvqqOA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QZ851sH0LCUcD/iOhvnwNcQBEgoMlJkQZJ8hZJGp4Jnjp6ywX67AxO1eonJ+VwlOc
         +C+qqmPD+moUzeWA63Qd5HPd+cgCOC7Sny4Px7MTt1tqYSuPiHZ9u8MmihbVeoGOeY
         DDpdLXUkHumy28X5QLtuzi2Gd0V8wgOELnzQK/yg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33C1360D9B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: Introduce RPMHCC bindings for
 SC7180
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org
References: <1572371299-16774-1-git-send-email-tdas@codeaurora.org>
 <1572371299-16774-3-git-send-email-tdas@codeaurora.org>
 <20191107212409.58CA82087E@mail.kernel.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <a47926fb-fb39-c533-8995-fe8563f6c282@codeaurora.org>
Date:   Fri, 8 Nov 2019 09:00:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107212409.58CA82087E@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/2019 2:54 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2019-10-29 10:48:18)
>> Add compatible for SC7180 RPMHCC.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
> 
> Applied to clk-next + fixed the sort.
> 

Thank you Stephen, will keep them sorted from next time.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
