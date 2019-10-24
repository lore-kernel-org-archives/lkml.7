Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD8FCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8524820679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Wop/lkRM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FHXYYpjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392830AbfJXLAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:00:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58618 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbfJXLAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:00:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 10F6860F6F; Thu, 24 Oct 2019 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571914823;
        bh=lF7VPfa990k56WtZ+Go5dWYnjSW2LrwS9wWkHXP4Fz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wop/lkRMFXZ5nrTbnlNqKiRR3pM0eIGsKjl5sJfXD6aZfyFUfEkN55fivz7UfYWnD
         amJ3WW6UZ2zOAYIBDe/GvQ0K2jrmeenXgqBpsx1Ac4dBQaOPqrc3fA82yEciWrNnMY
         tjNW4MPlE9ScAoKIR4yFYKRZw5OMfTEgbKjQfkWw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 81C7460F6F;
        Thu, 24 Oct 2019 11:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571914821;
        bh=lF7VPfa990k56WtZ+Go5dWYnjSW2LrwS9wWkHXP4Fz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FHXYYpjVhnwjTXVDWJwmM/6h7UrDLlDN593yCL1ElgRD4TwG+aFUs4i5wweheVcsf
         8vBYWsbmkZs1K9/ang24XNX2vvMfb2OjC9w3kMAFMsxzhFupf+u48MyYjxyTqNexSk
         5Gyt3BB89Rqn1j+7hYCDaWpefVTsSF02L0TlJWRE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 16:30:21 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCHv2 0/3] Add LLCC support for SC7180 SoC
In-Reply-To: <CAL_JsqLzRRQe8UZCxgXArVNhNry7PgMCthAR2aZNcm6CCEpvDA@mail.gmail.com>
References: <cover.1571484439.git.saiprakash.ranjan@codeaurora.org>
 <20191021033220.GG4500@tuxbook-pro>
 <CAL_JsqLzRRQe8UZCxgXArVNhNry7PgMCthAR2aZNcm6CCEpvDA@mail.gmail.com>
Message-ID: <2fbab8bc38be37fba976d34b2f89e720@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2019-10-24 01:19, Rob Herring wrote:
> On Sun, Oct 20, 2019 at 10:32 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
>> 
>> On Sat 19 Oct 04:37 PDT 2019, Sai Prakash Ranjan wrote:
>> 
>> > LLCC behaviour is controlled by the configuration data set
>> > in the llcc-qcom driver, add the same for SC7180 SoC.
>> > Also convert the existing bindings to json-schema and add
>> > the compatible for SC7180 SoC.
>> >
>> 
>> Thanks for the patches and thanks for the review Stephen. Series 
>> applied
> 
> And they break dt_binding_check. Please fix.
> 

I did check this and think that the error log from dt_binding_check is 
not valid because it says cache-level is a required property [1], but 
there is no such property in LLCC bindings.

[1] - http://patchwork.ozlabs.org/patch/1179800/

-Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
