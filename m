Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07507C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09F820873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEBHq3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:46:29 -0400
Received: from hermes.aosc.io ([199.195.250.187]:41439 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfEBHq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:46:29 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 8DC4721C48E;
        Thu,  2 May 2019 07:46:24 +0000 (UTC)
Date:   Thu, 02 May 2019 15:46:17 +0800
In-Reply-To: <20190502074303.g3px63n4v4o7xade@flea>
References: <20190424062543.61852-1-icenowy@aosc.io> <20190502074303.g3px63n4v4o7xade@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] arm64: dts: allwinner: h6: add PIO VCC bank supplies for Pine H64
To:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
CC:     devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <8CB1EDA4-E4B7-486D-8BCD-884E0025C6EA@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2019年5月2日 GMT+08:00 下午3:43:03, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>Hi,
>
>On Wed, Apr 24, 2019 at 02:25:43PM +0800, Icenowy Zheng wrote:
>> The Allwinner H6 SoC features tweakable VCC for PC, PD, PG, PL and PM
>> banks.
>>
>> This patch adds supplies for PC and PD banks on Pine H64 board. PG
>and
>> PM banks are used for Wi-Fi and should be added when Wi-Fi is added
>
>Not really. The regulator is still there, whether we use it or not. If
>it's not used, then it will be left disabled so it doesn't really
>change anything.

Okay, I will include them in the next revision.

>
>> PL bank is where PMIC is attached, and currently if a PMIC regulator
>> is added for it a dependency loop will happen.
>
>I guess we should fix that somehow

But this patch is needed for eMMC to be functional again in HS200 mode, so I hope
it can get applied before this get fixed.

>
>Maxime
>
>--
>Maxime Ripard, Bootlin
>Embedded Linux and Kernel engineering
>https://bootlin.com

-- 
使用 K-9 Mail 发送自我的Android设备。
