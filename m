Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A9EC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 23:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6303222CA
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 23:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570316486;
	bh=OSMf8B0AB6AIqckNzRwk3oaI7AdreTyoAu9Y39HJWY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TkhbVmiZnadcxxkvy1NNHMjrGbfM76BfnA0EkvbKXf93LOFZDRe267Pu2nWmFf1+d
	 Tm7+HIGJaSYM+PdR+z+WVobCFiApHqiot5hJp+hIzs9B3mpHzgSS6xOupq5Aw4s0k2
	 ABHtCOzbdE4n4oPytGAuVf/836ZRF/UX/NLLXBqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfJEXB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 19:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfJEXBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 19:01:25 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F123520862;
        Sat,  5 Oct 2019 23:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570316485;
        bh=OSMf8B0AB6AIqckNzRwk3oaI7AdreTyoAu9Y39HJWY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wdh7qOQEB4QaKJ9SsdQIroEMCFUpYSThpjFkzk3JTX+LmSsoc8UgEcT/7Dh+9cp4M
         hCXIakPFvhJkjm/MKMrN6YCu5z66OVEtIbxUxKmCC7vGerW1A44245MN1f7bqzjCOM
         h0u2+hCUSBGr8akNAPcZtdglTavpSlWip+KIgu1I=
Date:   Sat, 5 Oct 2019 19:01:24 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org, kishon@ti.com,
        ralf@linux-mips.org, robh+dt@kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>, mark.rutland@arm.com,
        ms@dev.tdt.de
Subject: Re: [PATCH AUTOSEL 4.19 12/33] MIPS: lantiq: update the clock alias'
 for the mainline PCIe PHY driver
Message-ID: <20191005230124.GC25255@sasha-vm>
References: <20190929173424.9361-1-sashal@kernel.org>
 <20190929173424.9361-12-sashal@kernel.org>
 <CAFBinCCD7xTnektDhDa+wRsAWmyzMwgfou59Y3=Qf8b2utaciw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAFBinCCD7xTnektDhDa+wRsAWmyzMwgfou59Y3=Qf8b2utaciw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 07:40:28PM +0200, Martin Blumenstingl wrote:
>Hi Sasha,
>
>On Sun, Sep 29, 2019 at 7:34 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> [ Upstream commit ed90302be64a53d9031c8ce05428c358b16a5d96 ]
>>
>> The mainline PCIe PHY driver has it's own devicetree node. Update the
>> clock alias so the mainline driver finds the clocks.
>the mainline PCIe PHY driver only made it into Linux 5.4
>I am pointing this out because OpenWrt uses an out-of-tree PCIe driver
>with Linux 4.19 and this patch will break that if we don't do
>additional work there
>
>thus I would like to understand why this got queued as backport for
>various -stable kernels

It went through the automatic selection process, where we attempt to
identify fixes that were not tagged for stable.

I've dropped this patch from all stable trees, thank you.

-- 
Thanks,
Sasha
