Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090FFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB25920872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfDPR3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:29:16 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60645 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPR3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:29:16 -0400
Received: from [192.168.1.110] ([95.117.99.70]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N6LIF-1goMH42Hur-016dZK; Tue, 16 Apr 2019 19:27:47 +0200
Subject: Re: [PATCH v11 3/7] anybus-s: support the Arcx anybus controller
To:     Sven Van Asbroeck <thesven73@gmail.com>, robh+dt@kernel.org,
        linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, jan.kiszka@siemens.com,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190416155618.1369-1-TheSven73@gmail.com>
 <20190416155618.1369-4-TheSven73@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <2caf5f92-164a-3723-e2ef-42e4045d2ec3@metux.net>
Date:   Tue, 16 Apr 2019 19:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190416155618.1369-4-TheSven73@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:P98hr+O26YLJ29556Q1mCHCxORZtk/flBuq6cFIaLOUnTUG5iUH
 /wlcrbvmubYHhMNSyvHWWuzqBzODX6aqD/7ykjq2nN5aGcXAGGQ17vVGz6IFGVacJCneh7W
 wTmfrJDdokBqToQkKRWTk8KoLU7/kragMcZwdoUJAkaUWRGvI3Gx+jy4POBZ1aEvZSTm5Yn
 cSpbxH1C8QJlL5FXKXUFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RNYttUooMO8=:r3r7L1EduPV2G+6rDQsqbV
 FYPkb1sz/6s5R452S+7we2n13+wlkjY60RRzYP78ovbagErhSJU3nEgZaNJJHJrL2hdTOvfcZ
 /NCPCJLsZpaMWHYbF86HsSPnVdu5KkE2icOgpIhyHctjpgLvayy/CHfnXhHkSMvjl0vfcJwyM
 WxZkz7GlQWs15wRdN84Rl5DDuPAwOKgnsEfQVvFMtsU/+N/zybpIlY0JMNDp9/LQyvUZ4hi6Y
 Z+WhtTfW/F3BxWbhanIHxDNgkSRMFoamoCaY8/NU9QZ8//DcxlVcCoa+Ltxz5zi3AEpB89OMY
 0wjmdpJh8N2yfAshaB96pF6Nq7PtEk/rn1rfhvkfwf4EYjvt9ElVyEMPOFtNvAq+e+7Q0lFE1
 KBAqn22AKRPfm2NkZTecpmF/iV1iVFRQK6pWVJe5GVDNDpTUSvWN1QmOGqJVQxYm4VISTrGke
 d5ZcQd9N56nMLSgS8rTHQ+JicAmB7luvLrgHdeOBPFg/o524guePctXrJzqK4gWG100P35bAZ
 AH9t/VR+DgnkS0J7ImUoFDmCjNqs++81pWC6efXy3q1/H7jLBaYsm8r6GIDEN4Ncxr95rxQ0q
 G+qwrLh+HWn6nbLZMjE+i6w9KE/DhloJ60gtBziKXVt/BRL+ry3PF5G+ZTnBmo+X1/mI08M1w
 4ZrfN4ayZ1mXkLBavHR3q5ZKvRzVp7qqWZGSyEfx8I0kmQ9ZpgTFPm5MT5R2FaUPFpSlH4EP7
 kDwwK0cnyAcgZc3wfznlowT2P9P09HNpYUv2X6yi5mLYQdw3e8VD7ZT6pJV7wfu0P00JDlea/
 1FfS8LmrSiK4kFxcnZ82aB5jZ7uPPCR6uj3/yselUrh69vuveLLuQ/Gd8KA9ovQZQe5XIVy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.19 17:56, Sven Van Asbroeck wrote:
> Add a driver for the Arcx anybus controller.
> 
> This device implements two Anybus-S hosts (buses),
> and connects to the SoC via a parallel memory bus.
> There is also a CAN power readout, unrelated to the Anybus,
> modelled as a regulator.

How do the anybus host and the CAN stuff relate to each other ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
