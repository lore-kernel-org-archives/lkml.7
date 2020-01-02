Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8943BC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F7B206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgABQqz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 11:46:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41548 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbgABQqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 11:46:54 -0500
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1in3ca-0000um-6n
        for linux-kernel@vger.kernel.org; Thu, 02 Jan 2020 16:46:52 +0000
Received: by mail-pj1-f72.google.com with SMTP id g12so5474232pje.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 08:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N+0SMH83DEMdXBxklWnpSdQi+VtqH5p+lcgEClqwKXc=;
        b=bKVPxrX2Qiw9tPIg+Iz+7n7wc8SWKvmd2j0aL2Ozx4HUQnGM5RgdqF4VblKENwNRUj
         Xjl7tY5tCeT5vj22fAlb63fYOkRz6TCL3PgYM9MNQK5IjVQDtvYHwjklp7Gk7l6z1TvZ
         U/m+tl82kpLvGlZYMhcT9HYxsnD5YWmEnkpYnBhwSVhmCSHPOsi91LJVWzu56hjP3cTV
         IrIjX8rNi2fUwwZAcYYAj+vpdfpDTe0yRRRocHzYkWwUxXPPqYbfLNo1fAIg8lK4cqRN
         A/TbAxSuf2UHGw4H25iiXABHWhQp6rNRaAH5E25OOtvkcORxSkZXDzSDSZyAbC5ylDhI
         H0Kw==
X-Gm-Message-State: APjAAAU8eJ3YJR5UtH2NRtYXt+9QNZ2Td4UdjRfRordu4xk4oEywH7PJ
        T6QeeSG1h/8E82Iz0g9Okd0xY+mff3wZ+qe121VrJi2IuhdzRXG79bGWPPzF2PwFfu/1bAYInzI
        Jh/FWb13/BE5AEIu3F2vfjVycGx5pDWPEBZ6Be1z2hQ==
X-Received: by 2002:a17:902:b609:: with SMTP id b9mr85940505pls.70.1577983610835;
        Thu, 02 Jan 2020 08:46:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIk9aPVIqBcPxzYk6x48gY3qrrcgKVCBBz9vFSwtTE8Mot2uF3FKpgNC3MV0XYtVt/cJfSfw==
X-Received: by 2002:a17:902:b609:: with SMTP id b9mr85940479pls.70.1577983610489;
        Thu, 02 Jan 2020 08:46:50 -0800 (PST)
Received: from 2001-b011-380f-35a3-d94d-dd84-8131-7958.dynamic-ip6.hinet.net (2001-b011-380f-35a3-d94d-dd84-8131-7958.dynamic-ip6.hinet.net. [2001:b011:380f:35a3:d94d:dd84:8131:7958])
        by smtp.gmail.com with ESMTPSA id b4sm65574395pfd.18.2020.01.02.08.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2020 08:46:49 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: SFP+ support for 8168fp/8117
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200102152143.GB1397@lunn.ch>
Date:   Fri, 3 Jan 2020 00:46:46 +0800
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>,
        Jason Yen <jason.yen@canonical.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <DC28A43E-4F1A-40B6-84B0-3E79215527C9@canonical.com>
References: <2D8F5FFE-3EC3-480B-9D15-23CACE5556DF@canonical.com>
 <20200102152143.GB1397@lunn.ch>
To:     Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> On Jan 2, 2020, at 23:21, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> On Thu, Jan 02, 2020 at 02:59:42PM +0800, Kai Heng Feng wrote:
>> Hi Heiner,
>> 
>> There's an 8168fp/8117 chip has SFP+ port instead of RJ45, the phy device ID matches "Generic FE-GE Realtek PHY" nevertheless.
>> The problems is that, since it uses SFP+, both BMCR and BMSR read are always zero, so Realtek phylib never knows if the link is up.
>> 
>> However, the old method to read through MMIO correctly shows the link is up:
>> static unsigned int rtl8169_xmii_link_ok(struct rtl8169_private *tp)
>> {
>>       return RTL_R8(tp, PHYstatus) & LinkStatus;
>> }
>> 
>> Few ideas here:
>> - Add a link state callback for phylib like phylink's phylink_fixed_state_cb(). However there's no guarantee that other parts of this chip works.
>> - Add SFP+ support for this chip. However the phy device matches to "Generic FE-GE Realtek PHY" which may complicate things.
>> 
>> Any advice will be welcome.
> 
> Hi Kai
> 
> Is the i2c bus accessible?

I don't think so. It seems to be a regular Realtek 8168 device with generic PCI ID [10ec:8168].

> Is there any documentation or example code?

Unfortunately no.

> 
> In order to correctly support SFP+ cages, we need access to the i2c
> bus to determine what sort of module has been inserted. It would also
> be good to have access to LOS, transmitter disable, etc, from the SFP
> cage.

Seems like we need Realtek to provide more information to support this chip with SFP+.

Kai-Heng

> 
>   Andrew

