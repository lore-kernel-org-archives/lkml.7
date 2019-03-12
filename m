Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6890C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE2320693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfCLPLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:11:37 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37691 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLPLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:11:36 -0400
Received: from [192.168.1.110] ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MlfL0-1gcg2G3EMk-00iiMl; Tue, 12 Mar 2019 16:11:34 +0100
Subject: Re: [PATCH] drivers: gpio: octeon: use
 devm_platform_ioremap_resource()
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
References: <1552330521-4276-23-git-send-email-info@metux.net>
 <1552333701-22712-1-git-send-email-info@metux.net>
 <CAMpxmJWCpfm0E15k0vAcxOKFTGdaFkmqK-VXD+orVE65H1Uk2g@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <5f55101d-ae12-0908-fff1-934f0e8d0d54@metux.net>
Date:   Tue, 12 Mar 2019 16:11:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMpxmJWCpfm0E15k0vAcxOKFTGdaFkmqK-VXD+orVE65H1Uk2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+fa9yhcgcSd4NielpCp6MqzD6NyNH6Icuz/FtQdThkHTP6ihPB2
 9wMQVuCEyxtFykuHvc63Fp7tquXjhrzSMTuRl45kyVY0yfIADiC0qv63XQNE7PbQS1I4OIX
 wOjE6Jsi+GnVpPvztZkiThrNADDdntx3btprqQ3oPL0x3j0eyuNaOnN3t8TC//2RuGt1FkR
 h7BvF+7lDOf0UXzXw5N9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gVGGa9dIlmM=:G85DSOe4XmmOWWZWBXzH21
 zUV+pTLUtCVLbG2hnqctVGTjHX1ORC67a1BIvTYZQasdrJD2L3c+2bu34EJBP4xa9Vj/H4cSJ
 4EE+1kezYrDkdtrQdhtZUKZafl5qa1OrE3aGlPamtH1Y0pt53i/ZEMJMjvW0tgPOpCnLh047H
 DVwakzcIKJKJblVkYqiliVEv1sly4/95ROAbAfSkgZP8s0Zf7MqF2V5j4dvhFc0n8vBvonCNP
 2QKx+yAAZcltejhigRybCjd9JjHOiQsfCcQj9/gGwiUUI1flluh45MSLe/dJ7X98X4V/8Q0/i
 4mciG7ahm0FrmspQtxqJuwTvr2SSyUpHI4TDoFqAafAr3FUQDaJ7mOiYVqbZRkA2YhzXOPrve
 lK1AB8TfoGj0IZcuT4sydDMTAVP+OA/4pFxIY7ZfuyyWxQGVgCrVWj6QVf2lZkIDdP9r0kjE0
 sQJIouhQONe1v9Vb/qcrrDh9rlaEfX4ebtBKzA3pT4ZMVSFGJme7bcYefbotFRiS2iL7da+D8
 vjb1rZuPqAXFyActRc+ga/S33+cRsxIgbcMIe6+0IHGAMlR0absq1U3ZqOXLYjQ3E5mIDu7Nx
 FFUu/YmO6MMZR0+OJGInaHboJJONM6299OMil8VxH5q089T2ualbL8hfAqs9gtNVpPQbW4ej6
 ZxHIEdkKtg3VsYrrQUIO4NeEoMQuoDvMPlsRzliIYP9KKezgXjP3uQqmuVTHifoH5UU3T6dW3
 on3lOVrHL+CsCeG4/+9VQHOLMd2BKGanCQ4ISQeqKAXk7iU1kKVht7tGbwE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.19 14:45, Bartosz Golaszewski wrote:

> Can you make this a part of the bigger series and resend together with
> subject line fixes?

tried to resend it as reply on the prev version. but somehow this
didn't seem to work as intented.

> Also: maybe consider adding a coccinelle script for that. When I added
> that function I noticed there are 1200+ instances in the kernel that
> need fixing. I think we'll be better off automating it.

haven't coped w/ this yet ... I'll first need to have a deeper look
at it. advices welcomed.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
