Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCBBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580262084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbfDASAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:00:50 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44849 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbfDASAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:00:47 -0400
Received: from [192.168.1.110] ([95.115.100.107]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N1M4p-1gmepq3q4x-012q0g; Mon, 01 Apr 2019 20:00:38 +0200
Subject: Re: [PATCH] Respond:Patch 0004-Add-support-for-SUNIX-parallel-card
To:     Morris Ku <saumah@gmail.com>, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com
References: <20190329112511.9087-1-saumah@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <732b88dd-651b-6770-b1f1-956aa908d6e0@metux.net>
Date:   Mon, 1 Apr 2019 20:00:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190329112511.9087-1-saumah@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:aFZLz0IqhrNKO2dQbiMl38nUCd+3QUOotXhDXwy2mGW+LC/8MoI
 CEwqE6yQXXyQTcfsoHDIclqrN2XL2Ay2FTPmqKuRavyWUjT3jhJcgOWpZJ2Mzv0oH2Rstq+
 fnp/gNwqVekex5KZeQLLmpHpMkg/lueCgItmiM2XTS93V9Ww+Y0oOr/78hNY9VV7oKkPgN8
 P38AqpOzVlhXI0kYnQMdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UK3F9wGvpyM=:lzZGlNoB6n2qybIFLfXhnJ
 gK49UEvLMeQmdW7dfNPEtJ5+CJ0FAU3bREmEciX5pE+MHZy85H8qVnjMhx/hEp6WiRiB3BLWP
 7x72d1osToe+hH+yNGfvgrDKZyGZDVeSX3jayt2Lg93FXPo1tg6fAOVGy/zzGijgmwj9bwiPX
 0caUJkxrB5I8LeJq5ym/My7YYMzVf3Qa7uMDsucsHyMd3a0Ta+Licl5I3/CiJtEuOzeV1eINz
 tiR8Fykajp4G6QVEKrEI5hjB2JcsvhBBgUNPsxXa0pKv3XDV4E/2VcAu6EN7IMMZUwgiP2Rzr
 P8EHELIiOruoXkMEa+hW/O2EfQ3dWkEBbh+AD7EYr6RoM+SkDV6nCPwVE96hsA2WjtpFZyRb4
 AuoeL0ZI256T0HbHZdIaUI/LpY+C5r54yMaSZT+SawXansWWZAAxgB5KC+VqYA2WrlFjf8czC
 nFQu2067uWbTBN5jPa0XF2miuPqh02bPVFvP/feC2YfrrS1P1/47kMaomDzmy7GHxaiMlOPOD
 1aHBExwAjMaDeQoJgeDDZ0Y+VejRKaydUQwZ4cIVCCVjGMchhN8kqP8V0xg+RJJag/b+RSz6/
 AR8ikBj6SKGKpok2uExAh7F8TBbVygm3b2u5q2vWMl/DccxhqHxTbJwU9afKpDx9W4JMV26bc
 FhhdTaNZPxTa5ZyP06CpE8lEdydPTdJGflSaz6Fe67kZAdTrRFEmbYClWrD39jz2OFEmlTrmP
 b9edS+iQVGeepQjppd+OqJkOhm4x6G9F3/KMLaBKfIWFBgwXE4jL3AbkUJA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.03.19 12:25, Morris Ku wrote:
> Hi,
> Thanks for review, my replies are inline:

https://www.netmeister.org/news/learn2quote.html

> +> +static struct snx_parport_driver snx_lp_driver = {
> +> +     .name = "lx",
> +> +     .attach = snx_lp_attach,
> +> +     .detach = snx_lp_detach,
> +> +};
> +
> +yet another case of duplication of some standard struct and hard-
> +typecasting ? use struct parport_driver here.
> +
> i will use standard struct(struct lp_driver) ,

you mean struct parport_driver ?

> about struct snx_parport driver,
> i will keep current format , because add a list for store device informations. 

No, your current approach breaks heavily (eg. as soon ans something in
struct parport_driver changes). If you really need to extend it, do it
by nested structs (same like struct parport_driver nests struct
device_driver), and use the proper macros (eg. container_of(), etc)
for typecasting.

Keep in mind: kernel-internal structures are NOT fixed, they can change
anytime - this is a fundamental design decision.

> +don't reimplement existing standard functionality. use the parport
> +subsystem.
> +
> +can i drop it ? it seems that it has no effect when port gone away.

If it's not needed, remove it. We don't like dead code.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
