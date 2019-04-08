Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF22C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EDE20663
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="Azj7FY8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDHNzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:55:21 -0400
Received: from vern.gendns.com ([98.142.107.122]:39066 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfDHNzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ffeayMoWofTom/YrUv5WoLE4sVJQVvrtxWSZZuYbARM=; b=Azj7FY8EEXb49iIsDmtfXKbpnM
        TmAjGsYImwEIDQ2PtUrchHJ3SFWRJEYU+kxpLnJ8+CAFBMp24TiRC7dxRSd+o9/ZDrUKB4YZh7vXM
        KldieuFoGn5RU1c8uDtVByJlqJ/UTb5EYNJ2zTe3YMaXJIvzJNC7Ny7HTCF08xfmMTPBWKRDK/8Ur
        j5wAmKCoFJkLVCDGMkIQcfjOqB2AwyqW2B367O7ODMeX2g6WnMPHw5tpU5T26Qu6lHy3wFRaePT7t
        uodMV33EpxY85Y9s7WW04ibzA6DOWynyFSYMlzCVva742BkEZ/2T3169c6D2qmQqyjuFj79JPUq8N
        NagiJJWQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:58444 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1hDUk2-0000r0-3m; Mon, 08 Apr 2019 09:55:18 -0400
Subject: Re: [PATCH v3 1/3] ARM: dts: da850: add cpu node and operating points
 to DT
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adam Ford <aford173@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190408075924.2284-1-brgl@bgdev.pl>
 <20190408075924.2284-2-brgl@bgdev.pl>
 <236c4d1d-7275-3223-ee06-0a25982b1fe3@lechnology.com>
 <CAMRc=Mf7tT1j5n8kM4TJXy7sHYmyfu8DTOwMKwo-d3VG4qOXgQ@mail.gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <f5d08299-8cc5-e70e-fc14-e172be544168@lechnology.com>
Date:   Mon, 8 Apr 2019 08:55:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mf7tT1j5n8kM4TJXy7sHYmyfu8DTOwMKwo-d3VG4qOXgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 8:51 AM, Bartosz Golaszewski wrote:
> pon., 8 kwi 2019 o 15:47 David Lechner <david@lechnology.com> napisał(a):
>>
>> On 4/8/19 2:59 AM, Bartosz Golaszewski wrote:
>>> From: David Lechner <david@lechnology.com>
>>>
>>> This adds a cpu node and operating points to the common da850.dtsi file.
>>>
>>> Additionally, a regulator is added to the LEGO EV3 board along with
>>> some board-specific CPU configuration.
>>>
>>> Regulators need to be hooked up on other boards to get them working.
>>>
>>
>> I still have the same comments that I made on v1. It would be nice to
>> also mention the LCDK board in the commit message since it is included
>> in this patch.
>>
> 
> My bad, I forgot it.
> 
>> Also, the 415MHz operating point is something I just made up for testing
>> and I'm not sure that it is actually useful in general. It could be
>> omitted from this patch.
>>
> 
> The board file has the 408 opp, I guess this is in line with other
> operating points defined by you which have slightly higher frequencies
> than those in the da850.c. Let's see what Sekhar thinks.
> 
> Bart
> 

My bad this time. I guess I put more thought into it that I remembered.
:-)
