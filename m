Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F4FC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2488C208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391424AbfFKIkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:40:25 -0400
Received: from waikiki.ops.eusc.inter.net ([84.23.254.155]:39112 "EHLO
        waikiki.ops.eusc.inter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391272AbfFKIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:40:24 -0400
X-Greylist: delayed 1181 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 04:40:23 EDT
X-Trace: 507c73696d6f6e2e65686c656e7c38372e37392e39332e3134307c316861633142
        2d3030304f70752d4c737c31353630323431323333
Received: from waikiki.ops.eusc.inter.net ([10.155.10.22] helo=localhost)
        by waikiki.ops.eusc.inter.net with esmtpsa (Exim 4.92) 
        id 1hac1B-000Opu-Ls; Tue, 11 Jun 2019 10:20:33 +0200
Received: from [10.16.35.209] (unknown [10.16.35.209])
        by lola.ninela.de (Postfix) with ESMTPSA id 53E6F24C28C;
        Tue, 11 Jun 2019 10:20:21 +0200 (CEST)
From:   Simon Ehlen <simon.ehlen@koeln.de>
Subject: Re: [PATCH 0/5] isdn: deprecate non-mISDN drivers
References: <20190423151143.464992-1-arnd@arndb.de>
To:     linux-netdev@vger.kernel.org, linux-driver-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Openpgp: preference=signencrypt
Autocrypt: addr=simon.ehlen@koeln.de; prefer-encrypt=mutual; keydata=
 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 0snB
Message-ID: <9da847b0-9e32-ad4b-78d3-15398b0f8fe2@koeln.de>
Date:   Tue, 11 Jun 2019 10:20:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190423151143.464992-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 87.79.93.140
X-SA-Exim-Mail-From: simon.ehlen@koeln.de
X-SA-Exim-Scanned: No (on waikiki.ops.eusc.inter.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 23.04.2019 um 17:11 schrieb Arnd Bergmann:
> It turns out that the suggestion from Karsten Keil wa to remove I4L
> in 2018 after the last public ISDN networks are shut down. This has
> happened now (with a very small number of exceptions), so I guess it's
> time to try again.
There are still public ISDN networks available. My provider (NetCologne) is still serving native ISDN.
> If anyone is still using isdn4linux and CAPI with modern kernels, please
> speak up now.
I'm using kernel isdn support in different ways.
1. To connect (b1pci,capidrv) to the PSTN of my provider to use phone (capi, chan_capi), fax (capi4hylafax, hylafax) and answering machine (vbox) services.
2. To build an internal ISDN network using hfc in NT mode.

There are other users as well still making use of isdn support in the linux kernel. [1]
As he pointed out, although public ISDN services are phasing out every AVM Fritz!Box is capable of providing VOIP services over it's internal S0 bus.
In case my provider decides to shut down ISDN I would make use of the S0 bus to keep my services running.

So please refrain from removing ISDN/CAPI support of the linux kernel.
>       Arnd
Kind regards,
Simon

[1] https://lkml.org/lkml/2019/6/9/168


