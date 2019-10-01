Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAF9C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AA321783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389870AbfJAQI4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:08:56 -0400
Received: from hermes.aosc.io ([199.195.250.187]:38010 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730750AbfJAQIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:08:55 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id B54A982889;
        Tue,  1 Oct 2019 16:08:52 +0000 (UTC)
Date:   Wed, 02 Oct 2019 00:08:39 +0800
In-Reply-To: <20191001.090651.796983023328992596.davem@davemloft.net>
References: <20191001082912.12905-1-icenowy@aosc.io> <20191001.090651.796983023328992596.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 0/3] Pine64+ specific hacks for RTL8211E Ethernet PHY
To:     linux-arm-kernel@lists.infradead.org,
        David Miller <davem@davemloft.net>
CC:     mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        hkallweit1@gmail.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <2CCD0856-433E-4602-A079-9F7F5F2E00D6@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2019年10月2日 GMT+08:00 上午12:06:51, David Miller <davem@davemloft.net> 写到:
>From: Icenowy Zheng <icenowy@aosc.io>
>Date: Tue,  1 Oct 2019 16:29:09 +0800
>
>> There're some Pine64+ boards known to have broken RTL8211E chips, and
>> a hack is given by Pine64+, which is said to be from Realtek.
>> 
>> This patchset adds the hack.
>> 
>> The hack is taken from U-Boot, and it contains magic numbers without
>> any document.
>
>Please contact Realtek and try to get an explanation about this.

Sorry, but Realtek never shows any idea to add more infomation about this.

These hacks had existed and worked for years.

>
>I understand that eventually we may not get a proper explanation
>but I really want you to put forth real effort to nail down whats
>going on here before I even consider these patches seriously.
>
>Thank you.
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
