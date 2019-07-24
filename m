Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DB1C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6756F217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P2IEkSSl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GlwlEVE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfGXUmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:42:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56034 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfGXUmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:42:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01D6F60314; Wed, 24 Jul 2019 20:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564000942;
        bh=yE4b8DVH6UNu3QtVYOP2/QoCPJazwMi7Z4vS46emglg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P2IEkSSlKMVUy3LeWMufAbJitm5TNC0i6tCCpJnHtpgadAoJmo9sMWoJrDPVkYx1f
         eQwki+EuAigzGH5WM/pauyFu0Ri57e9XQ6yEGtHs/X0fcBuPQePirqJ6XgWl9vTVFO
         cgkvLkHcRfprCuq+l0ht8IzBTUHUAvBM1HlcKasM=
Received: from [10.46.162.237] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4203360256;
        Wed, 24 Jul 2019 20:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564000940;
        bh=yE4b8DVH6UNu3QtVYOP2/QoCPJazwMi7Z4vS46emglg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GlwlEVE9LNssety46OVjURuumaCj9inIy8RTbpcCJmeyX7SXYxh/sctD1NqIGhqUo
         4U1fHOENMOhGaeQqRsy3xv7Gz8O2U3AGH9ucG/W8Im+tLmkdTtLqvBY/gNLj7I8i0o
         oO3XGSYAzij2M5m2apgGUSlhuYaD5DCz4mOAPMcg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4203360256
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Update Qualcomm SDM845 DT
 bindings
To:     Stephen Boyd <swboyd@chromium.org>, bjorn.andersson@linaro.org,
        georgi.djakov@linaro.org, robh+dt@kernel.org
Cc:     evgreen@google.com, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1563568344-1274-1-git-send-email-daidavid1@codeaurora.org>
 <1563568344-1274-2-git-send-email-daidavid1@codeaurora.org>
 <5d371ce7.1c69fb81.9650.8239@mx.google.com>
 <8c181f08-559b-5d77-a617-65cfd3d5da55@codeaurora.org>
 <5d3868a9.1c69fb81.876aa.ac30@mx.google.com>
 <8efd5c48-5d3a-97e1-1dec-6a9cdc4c8ef6@codeaurora.org>
 <5d38a31d.1c69fb81.80992.0052@mx.google.com>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <150445a8-a6be-aa46-026b-1ad254128037@codeaurora.org>
Date:   Wed, 24 Jul 2019 13:42:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d38a31d.1c69fb81.80992.0052@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/24/2019 11:27 AM, Stephen Boyd wrote:
> Quoting David Dai (2019-07-24 10:22:57)
>> The way that I view this is that the consumers consume both bandwidth
>> and QoS from these physical NoC devices by getting some path between two
>> endpoints on these different NoCs and applying some constraints. The NoC
>> providers can accomplish that either by writing to MMIO spaces or by
>> talking to some remote processor/hardware to tune its clock speed. The
>> consumer doesn't interact with the RSCs directly, but can select a
>> different bcm voter based on the endpoints that are associated with a
>> particular bcm(apps or disp rsc). Each node(endpoints) will have its own
>> BCM designation and an unique bcm voter.
> Ok. I get it now. The MMIO nodes will be interconnect providers and
> they'll know what RSCs they can use by exposing the same RSC "resource"
> multiple times for each RSC that can be targeted? This is what the
> postfix is with _DISP on your examples? Presumably there's an _APPS
> version of the same prefixed endpoint in case the consumer wants to use
> the APPS RSC instead of the DISP one, or maybe there's just no postfix
> in this case because APPS is the "default".

Right, the suffixes will denote the RSC association and will default to 
APPS otherwise.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

