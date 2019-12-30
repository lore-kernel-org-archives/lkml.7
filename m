Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EE1C2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4022072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="GfsW+Rav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfL3JHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 04:07:23 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:29968 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727273AbfL3JHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 04:07:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577696842; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: To:
 Subject: Sender; bh=Cxlyn1MkuXzt/FXwtDlSabtnDzP8nX874OYdBzTekBY=; b=GfsW+Ravtl7cupO1RgHMh+T2hQ4AfW5W2aS2LJTCQ5kbwqS9O0j6ByyS73HjpZRFdSY4IBw+
 SfY2uHI6QyvU62ON2UTeL19yH0yUkQr1Mqkl50xiOuZ8MfX3qWc8p+cYd8jppx69seSSHi+P
 GDrIljXulpjbbCIPkVLLDl7PUc8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e09be46.7ff4e112c570-smtp-out-n01;
 Mon, 30 Dec 2019 09:07:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 58825C433A2; Mon, 30 Dec 2019 09:07:17 +0000 (UTC)
Received: from [10.201.2.161] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8019AC433CB;
        Mon, 30 Dec 2019 09:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8019AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH V2 0/7] Add minimal boot support for IPQ6018
To:     Stephen Boyd <sboyd@kernel.org>, agross@kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, robh+dt@kernel.org,
        sivaprak@codeaurora.org
References: <1576752109-24497-1-git-send-email-sricharan@codeaurora.org>
 <20191227013353.4CB292080D@mail.kernel.org>
From:   Sricharan R <sricharan@codeaurora.org>
Message-ID: <ac5700ed-5b0e-5e75-a44a-cab7c543875b@codeaurora.org>
Date:   Mon, 30 Dec 2019 14:37:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191227013353.4CB292080D@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 12/27/2019 7:03 AM, Stephen Boyd wrote:
> Quoting Sricharan R (2019-12-19 02:41:42)
>> The IPQ6018 is Qualcomm\u2019s 802.11ax SoC for Routers,
>> Gateways and Access Points.
>>
>> This series adds minimal board boot support for ipq6018-cp01 board.
>>
>> [v2]
>>  * Splitted dt bindings  and driver into different patches. Added missing bindings
>>    and some style changes.
>>  * Added ipq6018 schema
>>  * Addressed review comments for gcc clock bindings.
>>  * Removed all clk critical flags, removed 1/1 factor clocks, moved to new
>>    way of specifying clk parents, and addressed other review comments.
>>  * Sorted nodes based on address, name, label. Removed unused clock nodes,
>>    Addressed other review comments.
> 
> Can you just send the clk and clk binding to me in a different series?
> I don't want to review all the other patches in the same thread.
> 

  Sure, will send separately.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
