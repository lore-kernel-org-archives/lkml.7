Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3CBCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61EC2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oyObPutI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ix+rQrIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfJ2RsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:48:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58066 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfJ2RsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:48:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E177E60D70; Tue, 29 Oct 2019 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572371290;
        bh=cjU1ueGqx6iKQEUNmV7NZ1LT+RZNFikmsVxsCfNz4sg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oyObPutINoTIwqMt1QRew2Zg3HJznRe9W3ICdLIgu5ci2S2lZ+5CKDyDiBjkqQmgd
         cD4mtLfCXw3WTZEjaDRfRa+6DYp5IQbHWZWJbYr6wrQAdGZ/dcX6KNZBH4h7m1fvV0
         Zrntf0Ijm4dMgTbdVBqTw6VzAAVz36fB5PzB3TtI=
Received: from [10.79.162.125] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8601560C8C;
        Tue, 29 Oct 2019 17:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572371288;
        bh=cjU1ueGqx6iKQEUNmV7NZ1LT+RZNFikmsVxsCfNz4sg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ix+rQrIxV5j/Okw398LzW2UlXBrBB/EJJfFDYcz/zWzvPZeFtbaPhbssKV21PZcYK
         KqhoSQ2lwjDt+ojJJyru7erMydIl5zi4U10Zko2UE/Tgh/C9nOL7C4e972Bp0KunmB
         tq+fwb9CsGSgYNwUhUGYs80gvGP/MOiGFTENboVQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8601560C8C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1 1/3] dt-bindings: clock: Add YAML schemas for the QCOM
 RPMHCC clock bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1571393364-32697-1-git-send-email-tdas@codeaurora.org>
 <1571393364-32697-2-git-send-email-tdas@codeaurora.org>
 <20191029020450.GA16322@bogus>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <e52cc998-85aa-6421-5bf1-b1e55f260bcc@codeaurora.org>
Date:   Tue, 29 Oct 2019 23:18:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029020450.GA16322@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Thanks for the review. I will fix the below in the next patch.

On 10/29/2019 7:34 AM, Rob Herring wrote:
>> +properties:
>> +  compatible :
> drop space     ^
> 
>> +    enum:
>> +       - qcom,sdm845-rpmh-clk
>> +       - qcom,sm8150-rpmh-clk
> Wrong indent (1 char too many).
> 
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    maxItems: 1
> Can drop this. Implied by items list.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
