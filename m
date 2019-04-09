Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C6CC282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A9920880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDIGys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:54:48 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54411 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfDIGyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:54:47 -0400
Received: from [192.168.178.52] ([109.104.45.158]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N9dg5-1gr3EW1Eur-015Vwy; Tue, 09 Apr 2019 08:54:21 +0200
Subject: Re: [PATCH 05/22] watchdog: bcm2835_wdt: drop platform_set_drvdata
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
 <1554752326-13319-6-git-send-email-linux@roeck-us.net>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <13e71a39-a725-e0d9-1e42-a6212b548b30@i2se.com>
Date:   Tue, 9 Apr 2019 08:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554752326-13319-6-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:0x5GjTLE4ZWmMPMhrn4tJ3UP/21bfMVyarsd/WVfRuZ6PJMfLbV
 tEDoA1buDf+Up0n1jWWCAeT4kz9pXcg2OYzsj3/e/Z/p3Ly6CHozTTDcIHnn55hT65CUsbn
 xgXbwqlAaOPUOqbqXB4OUJJIDgg/MoNW052Q2uDuuNfaYQZ3I+jd+Q/+i4MTZ4OOEyvB3mE
 i2HOLNACIXFHoe/o0vbTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+BO6YoWqVWY=:k5OFYMD+PVqKb+Iu4w/Ki3
 aMDF97xiOMzM+Xztg55fAwiwkCWSvz0/IgHB78v6sQk9uTeNWWuQ3i8WWqn+c1kyygOM7lK5N
 gdpjbkYptZkQaDz3sDuLmj1WxSMLixXRwgJk/kI5lzT81AGxgsqbEp+FShz8p5kycWkgzAz1+
 kVUrDnq9QgWZO5sa0eNKvx5+qLLPy5u7GDAPOPee3yklPzQgHsbBoKMCLglQszpYVJfbxZNGg
 nBW4gPjaaGxwsXEN+92O67066uFowF+tCHq0bXy3VjEtx8lIu8Q7oHQ3+W89pasXerl9TDlAA
 xwI9MapbFhqAYRsv/hGO+TQopMI8dyMI4aJPVuo14OEkDcTtOTNZytcmeV/rBsl1iVeX9+pev
 Rn8npeqRcnbMDTrT3YtDlq4Z4wwVcqOy6fiT14WGzZTFQWm9mQETNGJmtwm+QIeSWPmOKBfNH
 9wGhPdrRl1VPBY+YTT36zfb1hSi2cuH0N+Vdz7SaRv0Fr+gwk8jjsTMaGBmxyepaN6uGnavUj
 cwTNOLF16d4qKwV/sobguq7b17O/h0rfv78Q0r8+72S1RKjDpgVFhXwNBNVc1O8zZbhda6VNg
 rvnzgA1xbFyhv/4EArIOiT95K8dJPo6EbWkWeP6xsW6+O9rbLOjPvI3xnFu0+PRZP2cuqxZbM
 JCIzcrpCVM1IL1eHz4CmRRRU7cVGhZvFXg4Qij/c5tBwQDvbpqfOXEGkTR9JHXnoMC46vTQNG
 HD6y/pAFfWv6Jq4W845aEQZYWXXaMImLokB7hdUeVwvFGO5ks4rHxxSyQQk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.04.19 um 21:38 schrieb Guenter Roeck:
> There is no call to platform_get_drvdata() in the driver,
> so platform_set_drvdata() is unnecessary and can be dropped.
>
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks

