Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EB3C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A8D2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDLNfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:35:51 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLNfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:35:50 -0400
Received: from [192.168.178.52] ([109.104.50.142]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N49Yn-1gomgM2Kht-0101vG; Fri, 12 Apr 2019 15:35:15 +0200
Subject: Re: [PATCH V5 3/3] hwmon: pwm-fan: Add RPM support via external
 interrupt
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1554989411-23666-1-git-send-email-stefan.wahren@i2se.com>
 <1554989411-23666-4-git-send-email-stefan.wahren@i2se.com>
 <24771fbe-0c45-78b0-e96b-6ed31ccdcb7f@metux.net>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <518757ac-b0d7-298c-c896-4bd7e3b2ac5b@i2se.com>
Date:   Fri, 12 Apr 2019 15:35:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <24771fbe-0c45-78b0-e96b-6ed31ccdcb7f@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:wleykePClsDgbAjQmpOtAm3852cJHA61PeD5magwIfF5Ikf5mDI
 RkgqqHHs865TBQXyNHaOcN/OLQOqFJjjxm9zv4pHKIlpae42W26a+uDxehArPpnynrXiEFX
 3J36f+5QRusVvhnGTMPN43hHNvLFMWhJZ+UfvabV7UHIf6rva7sGco9PuaHuraGqvli/9EA
 Q4yDyFaIPA4pr3oHkpFFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3QclmQOO6e0=:hcAMYwEiTkbpsuYd9gH0xU
 mkFGd/v6/iFL2knNLngV/lCtRBQR0te7EGLZXxgHgjVkA5pc66ruVS/0MVU3QxM4v/o8yy1xT
 waN779FjPf+A1egO0YJ8VGAn9ERAgw+bgGP1rx7mBV1Y/WgiXCp9pm1/rEgqgrp89eOayHFGl
 ANgwPPQCnmSNU13MEEGWa0QOMP0euaJpY4ud6sftIipNRhSfN5GNmYBUMs7D+0pfuHrmpZ206
 YOG0PzNLr2uw2wckKLfDspxBba9DVAIgqGY1jjV2xAkumMTB1lDIDlHOZJCtftw4FwMVPyhfR
 PL8xbj6+7BQY8wb3XHoadvzqdAbhqIrzjbSgD2pDWWKfbQB9Fpgv2wTKug8kuZZk7m2UtNJqn
 A07ZPtJCtr4mTTRCwMzBwl7DLNzlY6FEiCOGloTBRlfVcOuzZI68POI+2jM4sMTuLyeTc2kp9
 o+4ruzkysfFoz0yoDE4LZk1O1KQdcqwY2RyIP0RtvhzvlI9RD04+FBJuMSepbtek+s+hcBL9q
 iGA2wW2b5t8MgKVDTIUJDrbwSrLlt0a9QzssUG+RP+0JPdI7/luSrL7gTe9Hw7fiImMwkUadk
 8U6mpXrh07VJAfi3HD50G0rxBIJP4igJ+JQOujpjMYer3WyGuiVMsUPKxIKSXKgQBszt7+ftU
 Wfp4jhuueHPhBieAohBgYCGdJLOE6lavnTGizYZUmdRQXT7B3ci7py8Uiusm0YuxPIJHbgBBC
 OtQURch/iibm7/FircPD4eafE/9PeuwXVmG943/TSDjStv4V6a6SrV0zPVc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On 12.04.19 15:15, Enrico Weigelt, metux IT consult wrote:
> On 11.04.19 15:30, Stefan Wahren wrote:
>> This adds RPM support to the pwm-fan driver in order to use with
>> fancontrol/pwmconfig. This feature is intended for fans with a tachometer
>> output signal, which generate a defined number of pulses per revolution.
> Wouldn't it be better to have a CONFIG_* flag for keeping the kernel
> image size smaller when this feature isn't needed ?

i compared the kernel module size in linux-next for ARM without and with
this patch:
without patch: 12088 bytes
with patch: 14292 bytes

I don't think it is worth the trouble.

Stefan

>
>
> --mtx
>
