Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386C0CA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6C3217D9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfKBPvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 11:51:09 -0400
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:56248 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbfKBPvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 11:51:08 -0400
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iQvg8-0008Sp-Ij; Sat, 02 Nov 2019 16:51:04 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from dell2.five-lan.de (pD9E89706.dip0.t-ipconnect.de [217.232.151.6])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id xA2Fp2pW029369
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 2 Nov 2019 16:51:03 +0100
Subject: Re: [PATCH] arm64: dts: rockchip: Split rk3399-roc-pc for with and
 without mezzanine board.
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <075b3fa6-dab7-5fec-df68-b53f32bf061b@fivetechno.de>
 <CAMty3ZDSK4mJk0bkQ_e3m1=Ar+NnGZS7q8zFYJJHtZY3HeBkfw@mail.gmail.com>
From:   Markus Reichl <m.reichl@fivetechno.de>
Message-ID: <30fd5275-6219-3068-dc22-6ae147baef4e@fivetechno.de>
Date:   Sat, 2 Nov 2019 16:51:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMty3ZDSK4mJk0bkQ_e3m1=Ar+NnGZS7q8zFYJJHtZY3HeBkfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1572709868;15dbb537;
X-HE-SMSGID: 1iQvg8-0008Sp-Ij
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

Am 01.11.19 um 18:18 schrieb Jagan Teki:
> On Fri, Nov 1, 2019 at 10:24 PM Markus Reichl <m.reichl@fivetechno.de> wrote:
>>
>> For rk3399-roc-pc is a mezzanine board available that carries M.2 and
>> POE interfaces. Use it with a separate dts.
> 
> Thanks for the patch. Indeed have an impression to go this via overlay
> rather than a separate dts since it is HAT for base board, does it
> make sense? or is this the way it is handling in rockchip dts files?

Please see discussion here:
http://lists.infradead.org/pipermail/linux-rockchip/2019-November/027592.html

Btw. it looks like there is an upcoming roc-pc-plus board with sound and other 
peripherals on board. That could probably use the proposed rk3399-roc-pc.dtsi,
too. 


> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
