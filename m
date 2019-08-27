Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28B8C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46B820828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfH0WFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:05:10 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:40724 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfH0WFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:05:10 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-76-175-nat.elisa-mobile.fi [85.76.76.175])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 4A0923001A;
        Wed, 28 Aug 2019 01:05:07 +0300 (EEST)
Date:   Wed, 28 Aug 2019 01:05:07 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, chenhc@lemote.com,
        paul.burton@mips.com, tglx@linutronix.de, jason@lakedaemon.net,
        maz@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.co, devicetree@vger.kernel.org
Subject: Re: [PATCH 02/13] MIPS: Loongson64: Sepreate loongson2ef/loongson64
 code
Message-ID: <20190827220506.GK30291@darkstar.musicnaut.iki.fi>
References: <20190827085302.5197-1-jiaxun.yang@flygoat.com>
 <20190827085302.5197-3-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827085302.5197-3-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 27, 2019 at 04:52:51PM +0800, Jiaxun Yang wrote:
> As later model of GSx64 family processors including 2-series-soc have
> similar design with initial loongson3a while loongson2e/f seems less
> identical, we seprate loongson2e/f support code out of mach-loongson64
                ^^^^^^^

separate (typo in patch title as well)

> to make our life easier.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

[...]

> +config MACH_LOONGSON2EF

You need to update lemote2f_defconfig with his patch.

A.
