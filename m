Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FFDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21F1218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfDXKuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:50:14 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:46423 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726790AbfDXKuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:50:14 -0400
Received: from [IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676] ([IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676])
        by smtp-cloud7.xs4all.net with ESMTPA
        id JFTahJiZEZVjxJFTdha81T; Wed, 24 Apr 2019 12:50:12 +0200
Subject: Re: [PATCH 0/5] Aspeed: Enable video engine
To:     Eddie James <eajames@linux.ibm.com>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        joel@jms.id.au, andrew@aj.id.au, mchehab@kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <b524e352-2e9d-6360-5517-18eee2e02c2c@xs4all.nl>
Date:   Wed, 24 Apr 2019 12:50:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfClRnGEmmvsjAmZ6WsMrfn9ojbVDq+RnKJoF1TYkNQnafmXDBrLctyOIdqxY6QFyjoqJQ851+tiXMc25OcmQahV5IV9Vv3TS/+ADvNHfpR02caCnxC62
 TrFhkBG3lPcl0VkKtI3rM3S0v+MnPUe+k1sCISaMFBQjBkrYrQ6vBdPB2yd+WCqcLmQVldn/Pzk43ifSaep5qkMx0GuNCpKdGz0i4uoW6w23HsgD7TLPNl4h
 ydj4GLcNCgOOlBNEux1CHDjRGeyBUh/xEtnQpEargmhcxWqS5pvKFXo2HqPpbyPxlE2VnKzmX1wCnlePyOojIWhEGqafDjnchxueHZ2Ii0PcrwWsqPeLR3fB
 3d5p1Qe1KOontEwlj6i2XCC4DDKXhGH2bfLR0JyF5X3bpXZsHNgjF/vygZ7FPPeEUKptcO1rlb0RFf1saYmnx/iGcsWOQ4jEXATf0Ib07/xzirFu813j9s5d
 TRDtHaySY1SO/EkGMdxO8nryob5RY4y4HW01pYFv41Gr26pYAgh0TNHCnW4ByiHefZZuvA9AYvrTbZ9APzkMltWOtgB77Y0lLz34SHrJfKx8zHoumgMxE0Da
 J6njZ8THjga6nOrnAOGGLBj4+NNryL+PfTon1VOLjzZdlxC5FnSLL5CBhBz8iPlx2GFMy4P88Me6jrAoYSxQNzWD9UX25RZHti1mvHLosII3Mw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

On 4/2/19 8:24 PM, Eddie James wrote:
> This series enables the video engine on Aspeed BMC platforms. The video engine
> clocking is added to the Aspeed clock driver. The use of the video engine reset
> line, originally planned to be made externally available in the clock driver,
> is removed from the video engine driver. Finally a node for the video engine is
> added to the AST2500 devicetree.
> The series also includes a missing property for reserved memory in the
> devicetree documentation, and a small change to make the video engine driver
> start without reserved memory.

I assume you'll post a v3 since there were some comments?

If you want to get it in for 5.2, then be aware that you should post it tomorrow
at the latest.

Regards,

	Hans

> 
> Eddie James (5):
>   media: platform: Aspeed: Remove use of reset line
>   media: platform: Aspeed: Make reserved memory optional
>   media: dt-bindings: aspeed-video: Add missing memory-region property
>   clk: Aspeed: Setup video engine clocking
>   ARM: dts: aspeed-g5: Add video engine
> 
>  .../devicetree/bindings/media/aspeed-video.txt     |  6 ++++
>  arch/arm/boot/dts/aspeed-g5.dtsi                   | 10 ++++++
>  drivers/clk/clk-aspeed.c                           | 42 ++++++++++++++++++++--
>  drivers/media/platform/aspeed-video.c              | 33 ++++-------------
>  4 files changed, 61 insertions(+), 30 deletions(-)
> 

