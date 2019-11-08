Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F40C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495F021D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ogaerQrj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K6FMgsuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfKHDCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 22:02:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33316 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfKHDCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:02:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 141BA607C3; Fri,  8 Nov 2019 03:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573182144;
        bh=6MEqG+MyfYFaJlkiLyiU8jD24mhXwfPMDeWogUK37UQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ogaerQrjDzBnHzLxDD4lKN6b2eu0UASlRF6acUwURlQU3I9RsruXLZ/0bxPHGh+Wb
         pmJcyOclHOi47eC2w28c1yxvMa4kg6RFrsyjNDYjh37SxGrtgiOt4VW5dcb63ShOT2
         0sBOwAdt5r6GulNAG8lTjeppWiQRWWKqkumEoOkY=
Received: from [10.79.136.17] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6F2760863;
        Fri,  8 Nov 2019 03:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573182143;
        bh=6MEqG+MyfYFaJlkiLyiU8jD24mhXwfPMDeWogUK37UQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K6FMgsuwtAAgDSt6ov9n1DPelNZmzgwQtIz9B1wLoAPSLFRympd84IJ7ynpVtmZlO
         +Wh4KU/VZompUY7HZOhdqRuZGCvkIBE2y0RjgXLsw5CiNa2yNrhk4a04oM6UWWTcbD
         Lu9re3xdPNkyv4JQQeicmiAGkcrsjyM1x4p8m6z8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6F2760863
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v4 01/14] dt-bindings: qcom: Add SC7180 bindings
To:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Vinod Koul <vkoul@kernel.org>
References: <20191106065017.22144-1-rnayak@codeaurora.org>
 <20191106065017.22144-2-rnayak@codeaurora.org>
 <5dc457d2.1c69fb81.839ab.803b@mx.google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <3ee4b2ac-7977-6663-5d98-238ac702288f@codeaurora.org>
Date:   Fri, 8 Nov 2019 08:32:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5dc457d2.1c69fb81.839ab.803b@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2019 11:13 PM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2019-11-05 22:50:04)
>> Add a SoC string 'sc7180' for the qualcomm SC7180 SoC.
>> Also add a new board type 'idp'
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Reviewed-by: Vinod Koul <vkoul@kernel.org>
>> ---
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> I see that it isn't sorted but o well!

Well, it wasn't sorted to begin with, so I left it unsorted ¯\_(ツ)_/¯

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
