Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C893AC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0562063A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKRTFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:05:21 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:42632 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbfKRTFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:05:21 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iWmKl-000530-T0; Mon, 18 Nov 2019 20:05:12 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from dell2.five-lan.de (p508F31A5.dip0.t-ipconnect.de [80.143.49.165])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id xAIJ59Ku008128
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 18 Nov 2019 20:05:10 +0100
Subject: Re: arm64: dts: rockchip: Disable HS400 for mmc on rk3399-roc-pc
To:     Doug Anderson <dianders@chromium.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Tony Xie <tony.xie@rock-chips.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vicente Bergas <vicencb@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
References: <20190301153348.29870-1-christoph.muellner@theobroma-systems.com>
 <2766673.iMURPl8gB5@phil>
 <69472c06-8b21-c3d8-acad-1a0a292c0fa2@fivetechno.de>
 <3460135.SDF8zhHPq4@diego>
 <CAD=FV=VnjyQJpRcW6P1f4+ZrSOzAe2Cnoej=it4aCz+F_ozukw@mail.gmail.com>
From:   Markus Reichl <m.reichl@fivetechno.de>
Message-ID: <2db7a63f-a091-db8d-3414-cac289011878@fivetechno.de>
Date:   Mon, 18 Nov 2019 20:05:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VnjyQJpRcW6P1f4+ZrSOzAe2Cnoej=it4aCz+F_ozukw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1574103921;6de465a7;
X-HE-SMSGID: 1iWmKl-000530-T0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Am 18.11.19 um 17:08 schrieb Doug Anderson:
> Hi,
> 
> 
> On Fri, Nov 15, 2019 at 3:19 AM Heiko Stübner <heiko@sntech.de> wrote:
>>
>> Hi Markus,
>>
>> Am Freitag, 15. November 2019, 11:37:58 CET schrieb Markus Reichl:
>> > Am 14.11.19 um 14:10 schrieb Heiko Stuebner:
>> > > $subject is missing the [PATCH] prefix
>> > will fix.
>>
>> no need to resend just for this ... just to keep in mind for future patches ;-)
>>
>>
>> > > Am Montag, 11. November 2019, 10:51:04 CET schrieb Markus Reichl:
>> > >> Working with rootfs on two 128GB mmcs on rk3399-roc-pc.
>> > >>
>> > >> One (mmc name 128G72, one screw hole) works fine in HS400 mode.
>> > >> Other (mmc name DJNB4R, firefly on pcb, two screw holes) gets lots of
>> > >> mmc1: "running CQE recovery", even hangs with damaged fs,
>> > >> when running under heavy load, e.g. compiling kernel.
>> > >> Both run fine with HS200.
>> > >>
>> > >> Disabling CQ with patch mmc: core: Add MMC Command Queue Support kernel parameter [0] did not help.
>> > >> [0] https://gitlab.com/ayufan-repos/rock64/linux-mainline-kernel/commit/54e264154b87dfe32a8359b2726e2d5611adbaf3
>> > >
>> > > I'm hoping for some input from other people in Cc but your mail headers
>> > > also referenced the drive-impendance series from Christoph [0], which
>> > > it seems we need to poke the phy maintainer again.
>> > >
>> > > Did you check if changing the impedance helped (like the signal dampening
>> > > Philipp described in one of the replies there).
>> >
>> > checked with
>> >
>> > &emmc_phy {
>> > +       drive-impedance-ohm = <33>;
>> >
>> > gives no improvement:
>>
>> That is sad ... I guess we really should disable hs400 then ...
>> that may give others more incentive to dive deeper ;-)
> 
> Just out of curiosity, is the problem with the strobe line, or with
> hs400?  Have you tried using the solution from "rk3399-gru.dtsi"?
> Namely:
> 
>         /*
>          * Signal integrity isn't great at 200 MHz and 150 MHz (DDR) gives the
>          * same (or nearly the same) performance for all eMMC that are intended
>          * to be used.
>          */
>         assigned-clock-rates = <150000000>;
> 
> IIRC hs400 on rk3399 was a bit iffy but running at 150 MHz made it
> much more reliable and still gave you 300 MB/s transfer rate (so much
> better than hs200).  In reality many eMMC chips can't do > 300 MB/s
> anyway.
> 
I tried 150000000 and 100000000, but it did not help.

Gruß,
--
Markus

> -Doug
> 
