Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F37C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61022082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI9s0oDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfEPOzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:55:15 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39932 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEPOzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:55:15 -0400
Received: by mail-it1-f193.google.com with SMTP id 9so6723339itf.4;
        Thu, 16 May 2019 07:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=II2aVvOkMx3fjlXY4NrDqjsrfVAGmqJjZ4EMQ52ILtE=;
        b=QI9s0oDwhDFl8oLqw8BkhsHfiXP81XmJSPIuNP2LsqkhxGPCizT6C6BrtrKau+95iQ
         HEwVAeFV4A3hR3uQfoxZYhVXSnw2HBAFIxlRR7qcTE3HE9dG5ArKvUYgUcrxfJ901pOJ
         EYEksEV4IDkjAWi5rX6JiFuWofYXfS7y0IoWArWbjQo4B7qaoM2PIqoCbzbiPtT6NG+B
         W/VyyGEP/vtJDOLwtE+HtNcu/aIIfNave1REE3pYuiJfOql/erp+LalbXdSQoSD99kUh
         Byb6NW4nzb26fAAObiJQK/CWg6EMz0rZUVeEjPiP/UuPha8s/zNQ1dgmre4VVkKsp/cG
         Nd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=II2aVvOkMx3fjlXY4NrDqjsrfVAGmqJjZ4EMQ52ILtE=;
        b=GYAS9CFUvpSkiSvzVRtcy6aFBBJx+d+ggc5ZcQT1P/fzPfhIJ+ZGQ4v19x9BCA9AfJ
         FCaq0D63ZBkKC2nw1qxOLivUt3zWfclVj5wdxP11crDfjeNJ4ibIttO8/UalCa7LkX+G
         YzuwWdsm/w61MYwO2SMYf+Fcvy8SgE0hpdcW7ifjx9EZ6ospgXJVO+fHQ6ldk4mbxSC4
         DYRqebrUpxdicKRteVFJT/Q/PO5THQ+SO+l4kjLLZVRXj10+Fu/PCOHNvPuRxZHbHwcV
         zUpxToFxdtFEldWsM+9myE/P/3vNZ46m0ErbNGtiAP+0VmmFWHEtsFonvYBktldFaw6o
         E8jg==
X-Gm-Message-State: APjAAAUqJgyL2/Ogd0+VPJdRU9HAW30lxSWKfYwUHCue4Xy9yt6fIUYD
        dynlouKn180CKA1ehZIK/Rjca3qP
X-Google-Smtp-Source: APXvYqz+BV3HV37t6+sIkwydMn16eHxVIeUK/39DRMH4CpTNvFDNSbpwz3BieUAIoAb0OQotPcxo7Q==
X-Received: by 2002:a24:64d0:: with SMTP id t199mr13004949itc.136.1558018514328;
        Thu, 16 May 2019 07:55:14 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id c91sm314112itd.4.2019.05.16.07.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 07:55:13 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] dt-bindings: memory: Add binding for NVIDIA
 Tegra30 External Memory Controller
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>, devicetree@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190414202009.31268-1-digetx@gmail.com>
 <20190414202009.31268-3-digetx@gmail.com> <20190429220542.GA17924@bogus>
 <137c766e-66f6-828a-5c3b-f526d66d37bd@gmail.com>
 <CAL_JsqKCWytgQEDPLX27xdaDrARtHssbhFcL47RO0zfECm0Gig@mail.gmail.com>
 <27d24f4e-cf4c-b2d1-140a-5dcef021fa40@gmail.com>
 <7b6867f4-54b2-f3b5-2b4e-87ea3000fa44@gmail.com>
Message-ID: <063f38c2-d594-f584-d2b5-6586b73a2b92@gmail.com>
Date:   Thu, 16 May 2019 17:55:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7b6867f4-54b2-f3b5-2b4e-87ea3000fa44@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.05.2019 4:39, Dmitry Osipenko пишет:
> 02.05.2019 3:52, Dmitry Osipenko пишет:
>> 02.05.2019 3:17, Rob Herring пишет:
>>> On Wed, May 1, 2019 at 7:06 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 30.04.2019 1:05, Rob Herring пишет:
>>>>> On Sun, Apr 14, 2019 at 11:20:07PM +0300, Dmitry Osipenko wrote:
>>>>>> Add device-tree binding for NVIDIA Tegra30 External Memory Controller.
>>>>>> The binding is based on the Tegra124 EMC binding since hardware is
>>>>>> similar, although there are couple significant differences.
>>>>>
>>>>> My comments on Tegra124 binding apply here.
>>>>
>>>> The common timing definition doesn't fully match the definition that is
>>>> used by Tegra's Memory Controller, thus the DQS (data strobe) timing
>>>> parameter is comprised of multiple sub-parameters that describe how to
>>>> generate the strobe in hardware. There are also more additional
>>>> parameters that are specific to Tegra and they are individually
>>>> characterized for each memory model and clock rate. Hence the common
>>>> timing definition isn't usable.
>>>
>>> I don't understand. Every PC in the world can work with any DIMM
>>> (within a given generation) just with SPD data. Why is that not
>>> sufficient here?
>>
>> Because this is not a standard PC, but a custom embedded hardware that
>> is simpler and also doesn't fully follow the standards in some cases.
> 
> Even if there is a way to derive at least some of required parameters
> from the common timing, I don't have information about how to do it and
> there is pretty much no chance to get it into public.
> 
> Rob, please let me know if you're okay with this binding.
> 

I looked through the Technical Reference Manual a bit more closely and
it actually has comments about how to convert some of the common timing
parameters into register values. Some of those parameters are not
trivial to convert and the doc could be incomplete, and some of the
parameters are not documented at all.

The other much more minor reason against the common timing description
is that all boards come with the memory timing definition in a
platform-specific form in downstream kernel. We're re-using that
definition in the device-tree, hence it is easy to port the timings from
downstream into upstream.
