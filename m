Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D031CCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 05:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79A22085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 05:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QJq/W/+L";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AJl5A1k2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfKAFml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 01:42:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47434 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfKAFmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 01:42:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DE5A160A66; Fri,  1 Nov 2019 05:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572586959;
        bh=hfIUvKWAJJGAIiPINob40uFW3VATFr4Hy/OOMnNedZ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QJq/W/+LeemfKfbuQt8carVNB0URGDh3KbVxp+VdHth6cbpLg4YAnp5NwdNlmDGaS
         HD9E4VwrnJNbYy/qP17K3SeclV+MWLu1Nxbtv1K1qPNQ1qrbJfRLtpgZf5lE38kErP
         /DJFNVuUlQW5+mlQ/lTxmYn0RmgyFIdAaQ500YcY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D668260A66;
        Fri,  1 Nov 2019 05:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572586958;
        bh=hfIUvKWAJJGAIiPINob40uFW3VATFr4Hy/OOMnNedZ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AJl5A1k2zCnHgvYqAvbQ2tw0xbY7UZ487lMyuth0SXCeWAZy1iQ0A/UYUECO0mtq9
         iL79uI+9ha4SC15D5PMNFY3e0Jy2CVpGZQvyYxUSd31WHzpMILh7xKbf7+8R04AYUN
         CM2CgEzIe78GA80M9YzJSY2+1xt5ZUInUf3uwmh8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 Nov 2019 11:12:38 +0530
From:   kgunda@codeaurora.org
To:     Lee Jones <lee.jones@linaro.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V9 1/6] backlight: qcom-wled: Add new properties for
 PMI8998.
In-Reply-To: <20191031085845.GA5700@dell>
References: <1571814423-6535-1-git-send-email-kgunda@codeaurora.org>
 <1571814423-6535-2-git-send-email-kgunda@codeaurora.org>
 <20191031085845.GA5700@dell>
Message-ID: <4b5c264b8d4b47c48bc87ca389041a02@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-31 14:28, Lee Jones wrote:
> On Wed, 23 Oct 2019, Kiran Gunda wrote:
> 
>> Update the bindings with the new properties used for
>> PMI8998.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>> ---
>>  .../bindings/leds/backlight/qcom-wled.txt          | 74 
>> ++++++++++++++++++----
>>  1 file changed, 63 insertions(+), 11 deletions(-)
> 
> This patch no longer applies.
> 
> It looks like you dropped the rename patch.
> 
> Please rebase all of the patches in this set on top of a released
> commit and resend.
Sure. I will resend the complete series with the dropped patches.
