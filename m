Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9036CFC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666A920869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IIRBDa5U";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="btg+ahCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfKHDxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 22:53:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfKHDxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:53:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0FD4860E0E; Fri,  8 Nov 2019 03:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573185189;
        bh=Kchj0au/N2roxI5cPK5t9RsVMPtXp9zZPGu9Gafq45o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IIRBDa5URaP8XCJNl3qyTl/IBfFFqJ4hCefbJfb3CkhP24xbRNFip7SJWTMhj6b7z
         XzC5e3skCKKjhiLpWD534Dn0CgeuteXKdQiAfDUkZ1OPhFh+4oU0x45XrkjpXhOHsY
         H/op+ocYwOKWqYuo1ZWdKSuX9P0JOKqlednODtMQ=
Received: from [10.79.136.17] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B714F60F2F;
        Fri,  8 Nov 2019 03:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573185172;
        bh=Kchj0au/N2roxI5cPK5t9RsVMPtXp9zZPGu9Gafq45o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=btg+ahCv6zPYAoJbB3LJ89efoKL35mqMuestY4jQyRaRkAehfIt9qMjWhQLly8iV4
         D/Kb0W+Kvj+aFnBHPwN6vUreWvk3fE9yLflTz8tPIpmoYyWrDfPFyrqpbNHMvomugE
         bh/lSm/vo/FOEMrCnf9dEswmcdI586SXcnYFWqag=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B714F60F2F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v4 14/14] arm64: dts: sc7180: Add qupv3_0 and qupv3_1
To:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>
References: <20191106065017.22144-1-rnayak@codeaurora.org>
 <20191106065017.22144-15-rnayak@codeaurora.org>
 <5dc46805.1c69fb81.7b5fa.1eea@mx.google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <d868998f-8b4d-bf9e-2539-a0915b1442fa@codeaurora.org>
Date:   Fri, 8 Nov 2019 09:22:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5dc46805.1c69fb81.7b5fa.1eea@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/2019 12:22 AM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2019-11-05 22:50:17)
>> From: Roja Rani Yarubandi <rojay@codeaurora.org>
>>
>> Add QUP SE instances configuration for sc7180.
>>
>> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> It has the weird qup numbering too, but I guess it's correct somehow.

I responded to PATCH 2/14 as to why its weird.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
