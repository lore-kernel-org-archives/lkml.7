Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D997FCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB383218BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfKDGvl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 01:51:41 -0500
Received: from mout.perfora.net ([74.208.4.194]:60205 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfKDGvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:51:40 -0500
Received: from [10.155.32.202] ([213.55.224.174]) by mrelay.perfora.net
 (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M0jDU-1i5rDu3rry-00uocL;
 Mon, 04 Nov 2019 07:51:17 +0100
Date:   Mon, 04 Nov 2019 07:51:09 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20191104012957.GI24620@dragon>
References: <20191026090403.3057-1-marcel@ziswiler.com> <20191104011657.GE24620@dragon> <20191104012034.GF24620@dragon> <20191104012957.GI24620@dragon>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 1/5] arm: dts: vf-colibri: fix typo in top-level module compatible
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-imx@nxp.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com
From:   Marcel Ziswiler <marcel@ziswiler.com>
Message-ID: <DE57B376-B5BF-47B7-AE7F-A89AD603F81A@ziswiler.com>
X-Provags-ID: V03:K1:qQ6B82UVh4fuMs6RI8T+GAHNqF3XNW0Zp+HEtEfvpX9GlcUO2wX
 L1JsJkiY4OVoMLqwjmbyTlvo7bVb/EWoCrjFr2WMD9naedPh5uYVIROmDdYqjtH28ugQhcE
 qlIDahFrmgm7zZH1ndAd9Weo39rU1toZ5iPGw6o/ZhkeP1fVcvGY1+MLoGLYphqfLFL3EO2
 nQLl79QAtFT9qImq1UJgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RuGUr5ZlRsQ=:wbQX2V4D8Afv+cRgsRCYjv
 2SZAgEFnnUJG9iE2BAtx1raUTZSuW2LBhm8D3C73juaBoiFvjfRqgGfR8DS5ttj7VZnVs5cMN
 R29JacxuPXb5pKZF+nvsV+89LywtlsyUZKRlNkLXE5eSk35vTcfrsnHEBlIiSIOU8w/qPC7eI
 v1GvB9u1nOJSZczdUbd+Xu8YZEe6dZcCsvkZhIhqrFWCNRNYV19XGCNxKDOPKiYPvaEmjscFK
 H/JHsV1VQjJhvAZ1kuyMQtlo2rJGX3nlE1vwc9rCJaGJwYtnoSkv0U6Shyl5UQaVqjJ0zYKkv
 pFHkKS5eUN9uDrdD54jUWVkV8uJVNRyU6AX5vL1Lo02rGXg53nfuGqFlQXvUgBpDL4nkSy+i8
 9oxs+MXxxJBvsjjUUhF5ARrAturCgmml5WyRsolIU86RLkOv3TtYVBNyy/Ua/b/dkUj5rzLSY
 KlrrbXgi3wfxmLOneew2JLCdqJtwwbXdHyOuMgD/K+iRFOOgyRORlUp/LJgqZpKmtZ7HdU5ad
 B/X/1eDzeJG9N8sY0R1QtZcognNNWCouEqFemz78lpz46FN4oRv5TlTEz0MTHNSZ9fVY28V4w
 DDNxV1HM+yeageJ6fJlNPztrymvxnf2A68DAlJ1IuBjV6eo6W5GPIMXIC86Pm41vBSy13ohd8
 11KWvoQKHN50LX1Ce5eoFeHl7DjkF+i2Sw+UX85EvSsYghl/atkWc8dSyWNYjDvndnmK5L4f0
 uZ+gZtmBagokJDtsDvHmYfMXpXm7XAswA4C23Sa6QzTCMTqFsb/19gq3X7vO+3Nm7z+fX2tdJ
 PxojHhpoHkfOFLvMlBMfTzXoiu28ujGv1C5Bm4peU+sozS59SU4RNNckpRdcesxr3dCGaHDXa
 rzAiEHBNJbUF+yeuFyI3aH0tjOBaX/h39mqwR8doY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn

On November 4, 2019 2:29:58 AM GMT+01:00, Shawn Guo <shawnguo@kernel.org> wrote:
>On Mon, Nov 04, 2019 at 09:20:35AM +0800, Shawn Guo wrote:
>> > Also as a practise, we use 'ARM: ...' for arch/arm/ patches going
>through
>> > IMX tree.
>> 
>> I fixed it up and applied the series.
>
>Just let you know that I did not receive patch #3.

I believe #3 got already applied by input subsystem maintainer Dmitry Torokhov. However, so far I believe he hasn't pushed that one as of yet.

>Shawn

Thanks, Shawn!

Cheers

Marcel
