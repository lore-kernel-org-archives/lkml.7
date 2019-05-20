Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C24C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD1F208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="N4IM6ASU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392833AbfETRds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:33:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:49409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387560AbfETRds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558373616;
        bh=mQs3SYPmcbZjpGgryO5QDTUYaOixaOst/TPnLx2UjpQ=;
        h=X-UI-Sender-Class:Subject:Cc:References:To:From:Date:In-Reply-To;
        b=N4IM6ASUD5u8cjyKxdbRiXO77lRCNWNcmStfTAx1IfYKV40hAQi08AXpus3TH3dEc
         cWJD1egfQtqr5Yghq8Q0nx0lAwfjv8/f1+ZhXFqnO191ySuLzIJaFX5aieUUgoMYRK
         U+wEK7+6SuGR+8ke0WoI03Q4fqXktA3hXxeJW0ro=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.166] ([37.4.249.160]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LvE2c-1gSOGj3xw2-010OtB; Mon, 20
 May 2019 19:33:36 +0200
Subject: Re: [PATCH] MAINTAINERS: Update Stefan Wahren email address
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1556740055-4962-1-git-send-email-wahrenst@gmx.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Eric Anholt <eric@anholt.net>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <8c07c0b0-5610-bd5f-73d5-373178af6502@gmx.net>
Date:   Mon, 20 May 2019 19:33:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556740055-4962-1-git-send-email-wahrenst@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:VdyJZS/+FYNTQ1T0daX0em3koSMMFR+R4XeZzL8DaV6zBayV1xE
 34n/frAQY+qoLAOdPSK+WJXBhHDufPkxXRUj6zqVU/HgXXUV8QgCeHhY9qwd9yV01Ylz5CG
 RLbU2xYha1pW8aA5Y2urSmKaBx5tikbPhT2jqDK8GnCrxgrERILJkf2tnZ4EjXp+cI4qJ8Y
 ZhvNlTYGQsL3VKYlrbTLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j218esgr/Xo=:j/sJUMSu0jqFtkxbMj9uLf
 cBvdYem5ZzAe1gnFDclc747Q9fiF3CZD1KF2YiaYU2mwg/ejEPERGbFPubEpTKLUL3UxLKyyi
 PJJu291ZiyDvGYuV1Vg+SjsvLrBFJ0Y0cKVlwyIjajRiBUJDry5Ej/Znk2vu8QwRPk3xYhris
 oH7HpCFlnmCx1aTjghPoPA/drdp3Dxi3ULMKVq9oeB02Nq/VS8UvICwqGVx77J/8QA4a5qukf
 UjpV0kZr634UmYNGhqdlt6tq8bg3ogQ6CRUULKUHBTvxWpcoBYyIiwcHEnVDe5PXv8H/blIyM
 jEb48r5rQrnZfdzAU6uvF7OA5kRZcd0uHyU3TNsJ0snqHwXFcwZKT+Irk0lIE8UenXfydha0P
 87k301Io9SjibsziM/URsj4/M6VglSYXky28hSJ1opBdy9zRwFk3FhbPzExZNZuJ8Tlk9EGNc
 8z+oLODvl9M9y4mqugCTzOQIqVy+4udi8AgPQ180iOLoQpjroETn+xSHJvamaj4fJMHWck+7V
 ywNYBuJEadTobCw9Zq+Zvk1mq/leBt7NXnIY74DxGm91HWSAclUvRThynHUzeU5uNlbQ8wR4G
 hrFBpM+IdwLJvCsx6fJxBfCOjJyfBl1HFxhN6b1gbFkJ5oDEREI+3qGKjDWoyhogmeVTWMftP
 XJo67zdsCOhgjTWri3+iQDTg/+HY6VNJXpBnY4e9YGgp97dQ2UJwyRNE8UVksRJ+gcz5ko7mo
 0hgJ2bJC51rHTjGKTtLgslinenxP0jGKv7iWOoxKeeu150GvgVuvrhLHTA0m06d1xt7G6HCcO
 6NtTejhLCVLYiRelnnF+T97jmN6ilb8r/7imYDEKn6ctaXkpMNCrUluI9+QYZOCGujEcaZ3av
 gR7j0+JqfyWRFE03Y0wdzbrjCnzYGTIAjaEe+lO9mFBvDNt7wgZT1GjWE2H6MgmpZsMxUnUdL
 e6iYn/QxYxaiVNaOTO+oGJ/ipt1j/PhQZyJD+i9ujkwmCsyfyy5nL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Am 01.05.19 um 21:47 schrieb Stefan Wahren:
> I2SE has been acquired, so i decided to use my private address now.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
should i send a pull request or can you pick it up directly?
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2c7d4e1..75a7876 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3068,7 +3068,7 @@ F:	arch/arm/mach-bcm/
>
>  BROADCOM BCM2835 ARM ARCHITECTURE
>  M:	Eric Anholt <eric@anholt.net>
> -M:	Stefan Wahren <stefan.wahren@i2se.com>
> +M:	Stefan Wahren <wahrenst@gmx.net>
>  L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  T:	git git://github.com/anholt/linux
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
