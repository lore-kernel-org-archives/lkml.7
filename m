Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A491C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1462722314
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgACExr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 23:53:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50298 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgACExq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 23:53:46 -0500
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1inEy0-0005BA-5s
        for linux-kernel@vger.kernel.org; Fri, 03 Jan 2020 04:53:44 +0000
Received: by mail-pj1-f70.google.com with SMTP id c31so6386591pje.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 20:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nKqZexjELWegBXPMGK5MiRW3PCznSDINX5EDFriPXxU=;
        b=Qb+SOHTqB97VX7z5VEhJCu4pL0UIxMvmVSD5ENIL9nOL3vosB4NPkDAA6KKoRQYAhc
         owtI96Uw2qG5pmynkTakCy9suYOSEY9v97cS8ml4/k8DyFB4VBsGeb8TvX+ketXtW29k
         vsLZId6SevgV+33oCyh9QFjkvtnyBg7G5EbNU2Co1WoqgEfQn27Mo3UYFq1GSVaWoaNI
         rDMs2Tws5Hbj6cDxd+aCEedRK/jWHSzFV7ZwfMtnSS27gkfjSdeMQwY1UKJJDZMMZ2YK
         +ifA9XD7Z5ZKIv91AsCDBcLOC0zkVKMuI267ZfJ+emke4Wpd3RfE4VH5Pj1NLj1bZQoO
         O94w==
X-Gm-Message-State: APjAAAUMUUoBq8l42uGfuuW+uXoHfBwNorXG7rSAkajNLU8UQ1ckURbu
        0KM5ja5+K9stM5hn+wnA5yIGv3OZTRQXT8kxA05iG+wARZKVbGO+E9a+kgc9AamnEFvGS14S7Ib
        uRnoZ/X3p9eEX5BJDc8bWa6xhhmx5au2XWPkkVXyt9Q==
X-Received: by 2002:a63:e30a:: with SMTP id f10mr92066810pgh.331.1578027222140;
        Thu, 02 Jan 2020 20:53:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFh7lSr8kLV/vkY7+fo4mchsm3YsgjklONz2dU1GbpkU/Rya+BAmUyif+zQAQ0ThFhDg8DzA==
X-Received: by 2002:a63:e30a:: with SMTP id f10mr92066776pgh.331.1578027221750;
        Thu, 02 Jan 2020 20:53:41 -0800 (PST)
Received: from 2001-b011-380f-35a3-58a8-ce0f-e12f-6096.dynamic-ip6.hinet.net (2001-b011-380f-35a3-58a8-ce0f-e12f-6096.dynamic-ip6.hinet.net. [2001:b011:380f:35a3:58a8:ce0f:e12f:6096])
        by smtp.gmail.com with ESMTPSA id s130sm60077705pgc.82.2020.01.02.20.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2020 20:53:41 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: SFP+ support for 8168fp/8117
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <c148fefc-fd56-26a8-9f9b-fbefbaf25050@gmail.com>
Date:   Fri, 3 Jan 2020 12:53:38 +0800
Cc:     Andrew Lunn <andrew@lunn.ch>, Chun-Hao Lin <hau@realtek.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>,
        Jason Yen <jason.yen@canonical.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <02F7CBDE-B877-481C-A5AF-2F4CBF830A2C@canonical.com>
References: <2D8F5FFE-3EC3-480B-9D15-23CACE5556DF@canonical.com>
 <20200102152143.GB1397@lunn.ch>
 <DC28A43E-4F1A-40B6-84B0-3E79215527C9@canonical.com>
 <c148fefc-fd56-26a8-9f9b-fbefbaf25050@gmail.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 3, 2020, at 05:24, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
> On 02.01.2020 17:46, Kai-Heng Feng wrote:
>> Hi Andrew,
>> 
>>> On Jan 2, 2020, at 23:21, Andrew Lunn <andrew@lunn.ch> wrote:
>>> 
>>> On Thu, Jan 02, 2020 at 02:59:42PM +0800, Kai Heng Feng wrote:
>>>> Hi Heiner,
>>>> 
>>>> There's an 8168fp/8117 chip has SFP+ port instead of RJ45, the phy device ID matches "Generic FE-GE Realtek PHY" nevertheless.
>>>> The problems is that, since it uses SFP+, both BMCR and BMSR read are always zero, so Realtek phylib never knows if the link is up.
>>>> 
>>>> However, the old method to read through MMIO correctly shows the link is up:
>>>> static unsigned int rtl8169_xmii_link_ok(struct rtl8169_private *tp)
>>>> {
>>>>      return RTL_R8(tp, PHYstatus) & LinkStatus;
>>>> }
>>>> 
>>>> Few ideas here:
>>>> - Add a link state callback for phylib like phylink's phylink_fixed_state_cb(). However there's no guarantee that other parts of this chip works.
>>>> - Add SFP+ support for this chip. However the phy device matches to "Generic FE-GE Realtek PHY" which may complicate things.
>>>> 
>>>> Any advice will be welcome.
>>> 
>>> Hi Kai
>>> 
>>> Is the i2c bus accessible?
>> 
>> I don't think so. It seems to be a regular Realtek 8168 device with generic PCI ID [10ec:8168].
>> 
>>> Is there any documentation or example code?
>> 
>> Unfortunately no.
>> 
>>> 
>>> In order to correctly support SFP+ cages, we need access to the i2c
>>> bus to determine what sort of module has been inserted. It would also
>>> be good to have access to LOS, transmitter disable, etc, from the SFP
>>> cage.
>> 
>> Seems like we need Realtek to provide more information to support this chip with SFP+.
>> 
> Indeed it would be good to have some more details how this chip handles SFP+,
> therefore I add Hau to the discussion.
> 
> As I see it the PHY registers are simply dummies on this chip. Or does this chip
> support both, PHY and SFP+? Hopefully SFP presence can be autodetected, we could
> skip the complete PHY handling in this case. Interesting would be which parts of
> the SFP interface are exposed how via (proprietary) registers.
> Recently the STMMAC driver was converted from phylib to phylink, maybe we have
> to do the same with r8169 one fine day. But w/o more details this is just
> speculation, much appreciated would be documentation from Realtek about the
> SFP+ interface.
> 
> Kai, which hardware/board are we talking about?

It's a regular Intel PC.

The ethernet is function 1 of the PCI device, function 0 isn't bound to any driver:
02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device [10ec:816e] (rev 1a)
02:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 22)

Kai-Heng

> 
>> Kai-Heng
>> 
>>> 
>>>  Andrew
>> 
> Heiner

