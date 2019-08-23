Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1051FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA5B22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Mfz0sRoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbfHWMAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:00:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:51627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388734AbfHWMAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566561616;
        bh=7uurcdjt1pmuPWMDE7aso5Yad1UCHW6aP/em6TNpjuY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Mfz0sRoaAZdo1EVRhSEewVIdbP3GGiVgQiWc4Y5gwYCCJymIoiUrXSbGqaL6ujXKp
         VCHKiKyQ0mG246vLmsRpYVESsx3NThbOE8KD38pmCFAbMF9rNJ+f73EoMWghYbrV1y
         oFV1lSg4UV+6jLBuJxGM1IqGWn6Ss9vGElBRY9q0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.154.8] ([217.61.154.8]) by web-mail.gmx.net
 (3c-app-gmx-bs11.server.lan [172.19.170.62]) (via HTTP); Fri, 23 Aug 2019
 14:00:16 +0200
MIME-Version: 1.0
Message-ID: <trinity-2f905f45-85d8-4343-8613-31dda5f7556f-1566561616610@3c-app-gmx-bs11>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Mark Brown" <broonie@kernel.org>
Cc:     "Liam Girdwood" <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        =?UTF-8?Q?=22Ren=C3=A9_van_Dorst=22?= <opensource@vdorst.com>,
        "Hsin-Hsiung Wang" <hsin-hsiung.wang@mediatek.com>,
        "Lee Jones" <lee.jones@linaro.org>
Subject: Aw: Re:  Re: BUG: devm_regulator_get returns EPROBE_DEFER
 (5.3-rc5..next-20190822) for bpi-r2/mt7623/mt7530
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 23 Aug 2019 14:00:16 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20190823100424.GL23391@sirena.co.uk>
References: <trinity-584a4b1c-18c9-43ae-8c1a-5057933ad905-1566501837738@3c-app-gmx-bs43>
 <20190822193015.GK23391@sirena.co.uk>
 <trinity-5d117f0d-9f34-4a2b-8a12-1cd34152c108-1566505724458@3c-app-gmx-bs43>
 <20190823100424.GL23391@sirena.co.uk>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:4oV9+ee+6El0HLRs2W95csYW5AXq49DnxYVQONxY9IZMFf61P45ZDW+O+/cY9Xfhy/liD
 5yba4Mn1sDmlhLQXQmi4hpVI+CgHG+jge9lMRX8PMEcMzJOlYwQ5WiNeVHB67YWUfd4C/SNCeHuc
 Lc4iVTwPptXGTxjj6qX/obf7YOID6e62FAkh7Y/8Xg6r7xlOQoYpRyErSZ01KgWioHfyEWrTxMfh
 jFQjB/JfbwjwaVXWqzdPAcE813uRh1+9pidEoT266QA3raAaKhnYmOb9IfTUDuNb6iipSGLFxm1k
 JQ=
X-UI-Out-Filterresults: notjunk:1;V03:K0:1gveNljnRH4=:IFYeteQjU1im3ch0YoBiil
 tatpL2DwoDvC8wCdBuUoQXu9CycEhxXWGet+e52M7NHdBL62FlVlBvNAlJM9LlhR7VqQxMBlT
 gSskEcZVO6TtErPk7cVCGmhAE4vGHVhb3tP+4GDV/eu3fCEifLLad80tqBUfqQpTjeBeoSDbJ
 UzgdqSeSBziaxcXCwlVUb+DhQRIrLi9Da9H7/3XANr/NPnm7nfPBOm/d9PVXt+hpfWlRDYzDB
 3J/8xSblKKhM3ZurWTqaXkxEjZycLXS7/lEsEXL+DymJKtxwpYmdeZtDSDRtWq11t0oU0Qg8m
 rTOPf7RE3tv29UdwTOhJ63D25OW1h3z8TIM0/ur1AXsc9aJCQIknpONNZFJuwCgOa6EWWXi0D
 B4syyeSGSInU6VlHwUIojk3GYnYkiqVFnw3m6doBEnLJFy9jK0MtUzP6cHCeoyWgyh+6KgQbg
 nL3pvNy1Sp5dgo1f3F0mk6BCYzy16dzSq037cRDMrQyllm0vSgsy4vQ88LEjY7Izr7aL1Sm/w
 Sgrx1R3mkPfYjLAx6vawbefupVYV+0dSy/Z1ImZNLyo3fX0hR020iBc4DlkB08KTlJ5TuTx3C
 TpeTxhTk5f+7GpiomFTOSCBCQJyB5uaNugoUMWEeXHyfHbedfJ0Fxpk+XkrExV2NlRo1ZeDej
 e41UGpXVIzkG9N1VpmYHT3xJXIQYSiCEHdu56SmwfDhxLrQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Freitag, 23. August 2019 um 12:04 Uhr
> Von: "Mark Brown" <broonie@kernel.org>

> Can you run a git bisect to try to identify the commit that
> caused things to fail?

i have not figured out, how to rebase linux-next on my current (working) c=
odebase :) (failes on file untouched by me at Patch 3/7000+)

> Look to see if there is a device driver bound to that device, or
> check if the parent regulator is visible in /sys/class/regulators.
> You'll also see a mesage printed out for each regulator as it
> instantiates in the boot logs, you can check there too.

in working version i only get this message in dmesg which
looks like a device-binding:

mt6323-regulator mt6323-regulator: Chip ID =3D 0x2023

this is my regulator: mt6323_vpa_reg

defined in arch/arm/boot/dts/mt6323.dtsi

&pwrap {
	pmic: mt6323 {
	  mt6323regulator: mt6323regulator{
		compatible =3D "mediatek,mt6323-regulator";
		mt6323_vpa_reg: buck_vpa{
			regulator-name =3D "vpa";
			regulator-min-microvolt =3D < 500000>;
			regulator-max-microvolt =3D <3650000>;
		};
	  };
	};
};

parent regulator is then
mt6323regulator: mt6323regulator

which is the one i see i dmesg.

in working version i see the regulator in sys-fs

cat /sys/class/regulator/regulator.*/name | grep vpa
vpa

=2D------------------------------------------------------------------

so, now to the non-working regulator:

dmesg do not have such entry ;(

regulators-list in /sys/class only containing the dummy and some fixed reg=
ulators

cat /sys/class/regulator/regulator.*/name
regulator-dummy
fixed-1.8V
fixed-3.3V
fixed-5V

in arch/arm/boot/dts/mt*.dts and Makefile there is no change between
working and non-working version.
in drivers/regulators only the 2 files where i had reverted the
changes manually without success.

where can be the cause for no more binding main-regulator?

are these strange messages related to this problem?

mtk-cpufreq mtk-cpufreq: failed to initialize dvfs info for cpu0

another strange line is this:

mt6397 1000d000.pwrap:mt6323: unsupported chip: 0x0

so the pwrap above regulator is affected too

and here are many changes in 2 files...

git diff --name-only non-working..working -- drivers/mfd/mt6397-*
drivers/mfd/mt6397-core.c
drivers/mfd/mt6397-irq.c

which brings me to this 2 commits:

a4872e80ce7d mfd: mt6397: Extract IRQ related code from core driver
708cb5cc3fde mfd: mt6397: Rename macros to something more readable

after reverting those 2 regulators are working again.
Adding both Signed-off-People to CC to keep them informed that a fix is ne=
eded

> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.

i currently write in webmailer, where i cannot set this setting,
i try to add manual linebreak in long lines, ok?

regards Frank
