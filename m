Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B669C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045AA2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gThPoZTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfKGTKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:10:04 -0500
Received: from mout.gmx.net ([212.227.15.15]:38345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfKGTKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573153788;
        bh=+jCINLffjUOyT+IY08Y5zx4Vxskk9OJZTse82HsxTz4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gThPoZTR1eidwzNRwz/Rpz8F9GxRZbr8OjLint+Fa57V8TMbCKrq3pr5YwOSBFmIB
         u4pqHGnosQL6RsGqMG2MM9FRiYx7qmMMECkcnuseUPXPHgvpdANoOHqHZcAuZE2PYk
         con9IEykthBhd6QArNo0lkZaKfFxtOJCVOZH3daI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.167] ([37.4.249.112]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fn0-1hn1Ge0GNM-011zQB; Thu, 07
 Nov 2019 20:09:48 +0100
Subject: Re: [PATCH v3 1/2] ARM: dts: bcm2711: force CMA into first GB of
 memory
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20191107095611.18429-1-nsaenzjulienne@suse.de>
 <20191107095611.18429-2-nsaenzjulienne@suse.de>
 <20191107112020.GA16965@arrakis.emea.arm.com>
 <4f82d3b5-fe5e-03a5-220e-f1431cb3a50c@gmail.com>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <8c84654e-f91e-7865-0cf7-99b30820b7d0@gmx.net>
Date:   Thu, 7 Nov 2019 20:09:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4f82d3b5-fe5e-03a5-220e-f1431cb3a50c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:ds3wIfCrqN8mXv4xV2yOkIAZhuvU/WXha9+QIZbz4jW5afq1ugo
 nxjvgEy4zXDiM3p6JevaZKdzdE1nVBUQS5rVNVX7LWE3+B06qt0Zdoi9xkuuhXBb+9hTNDK
 qIM8qmvGI0T3IGX9yQlLDgzn2yIGy1ft1bPIHFQ7zXqXayblhOKRNUs6yC+9sbQHFggoFyH
 EfjC1oBZCE8lPFuiBoHuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fnoUzY9B470=:Ck+piXC91e3UO6kAhBaICU
 7ygijkBy5cG7QMTWiwVxlGSUIZ41eFePjzKTNBmlqFU6iyAYaxLvn5Yq9Z0oPwmQAzwRw47zX
 3oU3JDLceXv21bdCiFtvGtLi4/aC+gzHPr/wfv3SSZCJdprq4ncTsuZaa3SPabyiO7z6ZSMhW
 FocRvE3+PuegJUKVimw3Lo4Y9U64vBcy6Q/gINOyZG2lNL+TJZ51VabJsNO6R1HRqbQr8PCJL
 RnJnLnZIaB61JxLTqx/DWAJacDV1NW6WGDmkYwC8O9wCYOY568oQLIntI2MI/rIPfmBBdQRps
 DZjO2AEd1Apd8MCL6NjxWyY1iAm3q/NsvdpCHEstg3fBtY0VwxWEnwRLM4fMOjYlKXBr1L00r
 5IwCLZWa/VWV828GOSqIotecrZmZm6OOSjG3u0UHzPqKLdUz0OKFcm8725FoSTazqAeMDDwbU
 JTyyM/jB8vrTs5P07tkfHHVD3Z2GUJOwbqKGT7UCO/a96djW9iPasBBi1OzjN4t3BxLroMlh0
 OYr8baQYeLQdSH7wWqZjMzM1tKewa5yV2WKUY2O1MNDimmseaO+Gw335DZg5RmnRKrtlvEb8K
 uEjaI+iJCGK6OnX5Qb+Khm5dTHlGVNx1yRJ+08zlG29IEq+EqGsfhs7+wiksGu2qjusvALi7I
 8NaaLrjRoa7ATT16j2xuNbLpgjIp3lcKhzqsw+vIHZsPx91oVeNWuEAZCPnlZWihvtPkbQUor
 2u4pD7FlpOxAHOGMXRcpQoYhTlF7MPowy1cfUsBEvXBy9C83rvggrj2A2XqSvjkXLKoBM40eT
 YIUG7RqiS/+2zS4bInx5b1OFicvrzYdemOuPoc/6p5g+WktzQZhZ+Wc9vzkbS038L46VopI+q
 0Fx3I91zjQ0gtnUytX8TKy7evYlxjAp13OTH11SIGXl7x0JFcWL5kOPrkiLlZ+s2qk+RL0V5m
 qTDhxhgLQLjnjogcyW+G0gn9S82KIr1Oy8xa8dtVYrQw+3qsET16ky4cpsisAuxB4hixxVcxl
 RI7BzRBqC2H7hwssXmBYs9yD9OGhXD/+CBeViiV4ORu4TsEfL+rzM+BIPyvbf5GDBPs+nxyUJ
 Sf+RjIOfVKNH76+Xzd+Ctk1bfcxpzSF5DKWoPacS+u7CtKiO56DwwgdiE3w/icuO7fyKziVAM
 Se46vmhmq61yCYmrTKjr7LxZZSk2XgxMDu+HlEiVa3oFJ9N+83ZcqKhHxrM9ZCPm+9g4rn0lV
 54Nf6g/sANuMDnSQ1LOmHGrG0UcVkaVaUbRdHbdrlGXj6xa4OIQGmuoxgCLk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 07.11.19 um 18:59 schrieb Florian Fainelli:
> On 11/7/19 3:20 AM, Catalin Marinas wrote:
>> Hi Nicolas,
...
>> Sorry, I just realised I can't merge this as it depends on a patch
>> that's only in -next: 7dbe8c62ceeb ("ARM: dts: Add minimal Raspberry Pi
>> 4 support").
>>
>> I'll queue the second patch in the series to fix the regression
>> introduces by the ZONE_DMA patches and, AFAICT, the dts update can be
>> queued independently.
> I will take it directly, unless you have more stuff coming Stefan?
Please take. Thanks

Stefan
