Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C690BC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99422145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbfGPSYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:24:12 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58277 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPSYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:24:12 -0400
Received: from [192.168.1.110] ([77.9.100.150]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1McpeM-1iMEhl1qug-00ZySm; Tue, 16 Jul 2019 20:24:03 +0200
Subject: Re: [PATCH 1/3] platform/x86/pcengines-apuv2: add mpcie reset gpio
 export
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, info@metux.net,
        dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <20190704090205.19400-2-fe@dev.tdt.de>
 <3e98bbd8-c051-4996-fc5a-88a58a2fa2d4@metux.net>
 <10c574cd0dfb1c607536c68fc1c60c06@dev.tdt.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <83ada4a1-c18b-95b4-0891-62ba3f3aa276@metux.net>
Date:   Tue, 16 Jul 2019 20:23:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <10c574cd0dfb1c607536c68fc1c60c06@dev.tdt.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y97lrr/VHMzPf29e+iDjUnnzt47qhyaSLt2xnZhzvB5BKT5Jx+d
 Tmqamh/dLY+Y+DZW2Qh8Lhc1YrxATtbDZmaufhUuApSZIfkEIT8PWMLKUljjky6xxqPZ3wE
 mSTS3vVyW6cGNUKzQtFwd2KONMqPCkQMl9F4vvJYH+2dzW2YsGBP5fi8qQ0tovErCCIQqAB
 1VbTn0qZXbhwlYxmwFEZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y79y7TtvziE=:EbXoie/iMrI3/4PCV93mHC
 /Wn+8ZvCCk0C+OenRACTSIg+nRWnYq4T4GhEyFJTLEctaydFyyqL6JXvPeeb6Xk5FAwIEmzAi
 iiknRTSWwWw2josYVlkWNLDiFGik33nMjvhDCfTNM/WhQfdnCpDkQ+HxLmGRSX3thd2AuN4Wq
 KWSxyGGUChM6xX+UMcdM8vxymeeHMUCvBmKwcnaSQpHAoAc1VxdCthRCPjAk4NyQowqz0+721
 6reUuwgWtLwJ3tWJKYZfMXJK2dOJt9xUIURaUS1jdHY4S24Kcy0ux+0NGQJeVSH8Zu6kEh+pi
 f6AIvV5ddPeTlKb72y6PX5yAbQkYwWaWTdCqgZnj8Ila9KFOoUIbOK+/gwkwEpZM9tVllYoTD
 7k5Lx4/yWbGINZ6b2qkAseLs14UlKxtxm+BY3+ZO7Ms8rtybtLNe2ksKIBfryeqfNgCK2+ym0
 8YRnQHn6xSuLlOQMhNteX8/QEmpAba9PHdtXYqY/qw33ry2J7tHXj2gR82Q4P8ib0kmkS6Cdu
 bBloPTmfd4jniXGMhA4hyL1aUwCw2NC6i7Hj8pYTbs5GeSuCRuCEMr/Q3ROCZ2wVZgL9+rxGt
 WGukwzduD62LXr8BN6lA2kGsiB23EvQYpDONPVDKJuF2v69UXlzYjrACJabS8XAkQWwEHWqA5
 /3NgUUReA55pIi8oXVBAK6OouXxEOlBDoHeNmvKJgVAhsNFazJ2RzWltuCKoMOZ6DjRYgYJiM
 ukFOUEC9Zea0Z5uP5iDilBOyWo8twH8j7ek0HD629o+QfYLQMK4H4IyZ1Ok=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.19 16:38, Florian Eckert wrote:

> I plugged in a mpcie  usb modem.
> In my test case it was a EC25 from Quectel in mpcie2 port.
> After that I did a reboot and exported the gpio via "/sys/class/gpio"
> Then I executed the command "echo 0 > /sys/class/gpio/<name>/value" and
> "echo 1 > /sys/class/gpio/<name>/value".
> Then I have seen the log message in the kernel that the device did an
> unregistration/registration

hmm, did the same, tried both gpios (mpcie2_reset, mpcie3_reset), but
nothin happened.

But strange: I'm missing some hw, modem doesn't appear ... I'll have to
check again whether i've got unstable hw or missing some kernel config.


--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
