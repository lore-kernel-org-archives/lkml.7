Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCDEECE58C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF7B20679
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MLOsUSl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfJMTFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 15:05:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:37669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbfJMTFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 15:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570993519;
        bh=MO2oXO2i14ZtdkD68DinZld5+bL5TDWxW+IcfydEnZw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MLOsUSl9T1lMIAx8wmXUqYPhvsXiDwTz6Q5D9vS8SNyxDDdS4kjIcXveTilsEyxiY
         7zUtaayxutyBkCl/2ZGpM9cWIpXs2gUL8eSmjG6uIy/wUp0lKmW2mfca1XBSHbDQh8
         1230FRXqeUjyPwdTFdik4qQqF/SUfof3S6cDUjO4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.112]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC34h-1iDvD13FbJ-00CSTA; Sun, 13
 Oct 2019 21:05:18 +0200
Subject: Re: [PATCH 1/2] staging: vc04_services: fix lines ending with open
 parenthesis
To:     Jules Irenge <jbi.octave@gmail.com>,
        outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, eric@anholt.net,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, daniela.mormocea@gmail.com,
        dave.stevenson@raspberrypi.org, hverkuil-cisco@xs4all.nl,
        mchehab+samsung@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        sbranden@broadcom.com, rjui@broadcom.com, f.fainelli@gmail.com
References: <20191013183420.13785-1-jbi.octave@gmail.com>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <38a29280-820a-4752-d9b5-099647a159d5@gmx.net>
Date:   Sun, 13 Oct 2019 21:05:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191013183420.13785-1-jbi.octave@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:oekdBUYy9JblNZTDryIiY4k9qbz96nELqU0fWbvsIAKMlCfzSoO
 Vf1SxQieI0o6MpseCrTMCUJ9EvaghlmGvBoja6Sy7Z+NTkyGr0M0dVgmX254tZT7biRfCwo
 VedSrf7vvnIthR9JJGwTLYI2PsKDDJNiEfre6Chjt+7rPNtk51CVzM77JHxMmwKTPYlEUCo
 LyzgI/01Ldt4GUrV743xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iTrNcnt6GRk=:yt2+kE4Wg4RaXVE162SAQB
 H2murMDCUcNTzaI59qGJ1/Vpji1CqO/v9JWjPwlgu7yvXC/9JutFMl6AL6RNxdL6e2VB0dNCK
 1UwNz8Z2Y7uN3P6MwA2r9A04ETOv4BhbwyXKxzHsJO9S6PKCbpPPkvrzFwWe5jNtIKvHuppUY
 Uag4xEEH84p6G9tM+nDfyWvanXDCob8xhYdY4TC0D0tIRXd+i3mvr1ILdpDwdMxLXqXj/drsm
 tV18jtDPHPeyY6GcoVRbMj0n2ZFeFO9J7+WPM3AiL9+6r/73BrLjLOGVfiIpQTJlhgJYAl2QQ
 T1dnjh9UdeFB/uU/U21CDk52Nt4bfp48tg/SVpFLYsWyKPw2oTPSTWrMDXLnDd6oue0vNiwbY
 1LI4iK+WH33QuyI94V/LJO4kIRmvzUTCBoMfTB7wltzFC1mlHj2zcph57VCCrtwrvHGZM+hbx
 DpemID0udkYnEqloS2TSio7LsYzxHOIvqsRgKkPntSbdl/iF0TCOpSztqoOc2EW8krThHUnVK
 UhpLaxgfZ96GLuWI8qyJN5jjc4fgYzGVb8cFDHdeCukk1RUumkjEUPdZrjXVFO/RTVKgMK+Li
 y2V6PPm3TKoR3LfawkhbxuS2XGegEPm0Y8GhKCqlHhy3/0VobBsKrV7xM5u74WT/QKfcxeGVl
 4URKZSU/xrARZKBR704DcOmhlmTpAj7hdmTXUgT8yLcAn4mLhw7g7HOnYhzUWKlhdIG+/LS71
 0CWklXup3yDQ9Lv1lsEZe4D/ECMb+SXXtRizoaV592oKnDwp4LFojXidgkEwnnZsEm2vrsnFG
 bzQh/byujnu9WRV1GIwM9vT9gfcoszyoX5DYxQY9q7Bs//P+50g4GTKsV4ONTEZDTltkE27YC
 v7cwmqKN97GseKDdyf9W8+Duq10qHiBwW1yQOQ9VHdLr5N7M3fheu5lR+alWj0rONwPGmPa33
 vCkBPaIxFc1GMzYsGAZ/IKBDlw895RgipElImQBHXcnYopYsGNrhvc4jpX293I8U994RpIaA3
 sq7DErYrXFCYlYkJvOoA/Gs7vWZsjHdSEDV9m4UbWHJXhSt5tY6bUjZFf9C7DerIgntavMAYJ
 1zBnLusnTrDa75IcfcfkUeYBiK1Eocq+/M8kl/xgaW7rkKr0A1iyOi2LYQByiOqlYYUZqPOm9
 5KXi8ycPBVvZV83k0Vyg4/Y9f3LraVr+3oN85zwyu09tp5RbrAm31DnGAEPhSPLdGlc5mxhF2
 4Xv373gNP/RNnp6SdNL1I3/T6KeOHeVRvWW8eLTpcrkl4xUmaieDHEBxNM8k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jules,

Am 13.10.19 um 20:34 schrieb Jules Irenge:
> Fix lines ending with open parenthesis. Issue detected by checkpatch tool.
> In the process, change driver functions name in the multiple files from:
> vchiq_mmal_port_parameter_set to vmp_prmtr_set
> vchiq_mmal_component_disable to vm_cmpnt_disable
> vchiq_mmal_port_connect_tunnel to vmp_cnnct_tunnel
> vchiq_mmal_component_enable to vm_cmpnt_enable

please no. Changing random function names into something unreadable
doesn't increase code readability. We need to keep an eye on the whole
interface. Maybe you better start with the 2nd part of Joe's suggestion
first.

Stefan

