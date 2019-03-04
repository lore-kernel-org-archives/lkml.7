Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEF7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F336C206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfCDUPz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:15:55 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:50323 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDUPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:15:55 -0500
Received: from oxbaltgw00.schlund.de ([172.19.246.6]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MNL2Y-1gdLVN3wR0-00OqtK; Mon, 04 Mar 2019 21:15:43 +0100
Date:   Mon, 4 Mar 2019 21:15:42 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, lkundrak@v3.sk,
        bcm-kernel-feedback-list@broadcom.com, eric@anholt.net,
        devicetree@vger.kernel.org, kernel@collabora.com
Message-ID: <1194402400.301453.1551730542978@email.ionos.de>
In-Reply-To: <20190304185454.18043-1-helen.koike@collabora.com>
References: <20190304185454.18043-1-helen.koike@collabora.com>
Subject: Re: rpi-b-rev2 can't detect hdmi display due to wrong hpd gpio pull
 in dts
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev51
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:k6Z79svwn1bzZ0IVf0R3dDJM47BNM2dtu36ZA6Y8ByHsYRqFsYJ
 Au5IdaVSdjIB6/Z/Od82EPZRRs4g2ljJwz54hHtrrhgF2pe9qKTxLFYriKp8gKNMCDtviKC
 EGHH8/9YZ/2ELTnkfVJ26PKDqy42XB2tKOCTC/45HmNWNvl4hRkiZVQ2664OiFytpgOYrhH
 Wqxdcu6UA6xZHl8pqIyiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uQEKZvb+8dY=:ISkC4kvpgd2OnuQwyW2kjv
 UxuGA54jtmgg0XBddsT3XlC8cKoEjpTQK6dR1/YR/7hWg7ODw5V3LOCfWhpg66AFbJljnmMdm
 LEXHL7YudPa1nfjeSYCqvXMJ60zx+GFUwGImfo4x7oGVNcAZScWGm7TFsVOpMVSo3T0QVw6dx
 nLAOP3kFrMrK/8ZDAquSL/RhC0n28uLBBMdXlgblX9DPX3nd7iMTzTRMse+zoqT3QpGhqlR/J
 IAzljY8Lh35gwA6cquZE3yWeU8mHS4j950Jkbwkh9Df7MdFAF1Amh+k8WtiaCKr/gltw2MRGn
 ROSyaaZFBp3wE+VEFkFnJZf0hz5nE8uaUp7dQhMclAkyEJloD+tDGOwfnBhogHyIzCJPGmtgj
 YEdho7rY4YKrzoBo5ouxzOK6u89PomhfnHsQe/PB061FAioVIBTf14l78cz1QJBrDTUShk9+g
 Y1DsaBwEwq7vHgxpdaZL6i7duhZJkB6qpUhbp6XtjOrJU9XERe/4SspFyo3UqKHulmILUBXkP
 qSogtDskgeqnQ5sWW+LGMhIPj/0/9lmexQDJwJZWYV3PLWN182e76i5M0gCMINCjQaKj1RgEC
 IjWw5M6+hCQ1RcDCozJZ5Z9l7mMcwfovGAFYPKs2MeETX12g9CmEBou87kJVALHhkBuolVFJF
 oNAj5cXVeucfTdxKuK1nm32Dga8yEJ53b9KKQAsqbtmvXJaj8QApYuaJL8ITulrMLLYDUmHHH
 JZmWAldr49ntLCIj+YVb2FaYvI/6JHbC29dgGHDmdt4nVylnoX7HXrPs3H4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helen,

> Helen Koike <helen.koike@collabora.com> hat am 4. März 2019 um 19:54 geschrieben:
> 
> 
> Hello,
> 
> I have a rpi-b-rev2 (two holes, 512M) and when I was trying to test vc4
> driver, the HDMI wans't being detected.
> 
> So I changed the hpd-gpios from ACTIVE_LOW to ACTIVE_HIGH and now it
> works correctly. I can see that modeprint from libdrm detects correctly
> when the display is plugged and when it is unpluggled.
> 
> So I was wondering if this is just in my board or if there is an error
> in the dts (which I think it's unlikely).
> 
> In any case I am dropping this email here in case anyone else see this
> problem, if you do, try appliying the patch below.

thanks for your report and the patch. I verified your change against dt-blob.dts / downstream file and it's correct.

I'm sorry but i cannot apply your patch because it doesn't have the proper format.

Should i take care of this?
Can i add your Signed-off-by including your mail address?

Stefan

> 
> Regards,
> Helen
> 
> ---
>  arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
> index 5641d162dfdb..28e7513ce617 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
> +++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
> @@ -93,7 +93,7 @@
>  };
>  
>  &hdmi {
> -	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
> +	hpd-gpios = <&gpio 46 GPIO_ACTIVE_HIGH>;
>  };
>  
>  &pwm {
> -- 
> 2.20.1
>
