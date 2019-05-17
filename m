Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4CDC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F8920818
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfEQHuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:50:09 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:44805 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfEQHuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:50:08 -0400
Received: from [192.168.178.167] ([109.104.37.130]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MAwTn-1hYOAy3Hzt-00BN1q; Fri, 17 May 2019 09:49:53 +0200
Subject: Re: [PATCH v2] Staging: bcm2835-camera: Prefer kernel types
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>, eric@anholt.net,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20190516213340.9311-1-madhumithabiw@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <bf9d2354-4ba6-bc18-841f-79ad75e6d911@i2se.com>
Date:   Fri, 17 May 2019 09:50:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516213340.9311-1-madhumithabiw@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-Provags-ID: V03:K1:5vRoIj7Qja7sHTo/eTuJyaMrKZswD7CC0dePgB/jan/opZcO5fi
 2AxCxBwblWgaxK4pmLJuaq4/kOigN4/CdB8CzWAgCS3XhA9bKcS8xrcdIvoZwV9y1zRRAJa
 yLDsIdmHDEPG8tJ2TvxwuRuZ92NGjM1s2CI7qwJg9QTJXu2eWKVIPFl2OTzP1aQTCRlQ3Wl
 I1/nrPVaflIUqTWFtGvxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:poAiXjetLp8=:Yr5UiP7twLxtvNUfdfsjWz
 kGhcNLpNAjigYCRlaYnIUZ2fCPSyKH6pRx8yIgziJG/JaYrBHwKjxpWnYyBj0Le5ewTz4kQhO
 NEodSeLH90X+Tf7yiHZkWZO8H0ezxBKIl25Khko4DWbiEKw6yichg8cJ60ELBRrxTRsy4BPWW
 3LtLPzYA+iyTII0B4FkJZBqp4+VCRp8xqa3dQoMRlRSLFMs/V+U7xvqlacCSf/9K7QMmzYpRt
 Uw5HEV2pxlCV6VFlDWaTkcJQV9m500bMeUrNlFUuLtTFTa12UDxhjEIdsTeF+pNxG6LiEJfyC
 iBekcSsX5WBbj3G0MW9htNrgs/J8P+gQWFlxv5p+se/D0a0AejU4thkHDoj9K8XjGziXRglQl
 CYeT1VkRyr0Yx22/7VNZm75RBSuTiy4RatpBdRvMtjbst4i5ZY8VXedmrMd8/0zlloo+Ye/T0
 vsjSkBPpTR5L5JU0K6y9psUyyNlu3H31m2sZB2rVA7SDhcJ5zekdREITGC917RNgLobf3RT0j
 ZmRgNE2lJixrYwX2FeI1iiXf9ZtVd3z8NUduqwV5B08JLIYffnt+Co6glitm2bWpzudZSIpx1
 hnYEQSTUbb6tFbtWFXIDlRHlOabq65ZuiYjmtdmnePGT798me6MpBeo+raVCQjgicwaAbBcs0
 qPBUlZvD2fi3P7hs0xx/5UY23EsYkG7V8YwlJFGyGwesPN2WLUOy8w0EB0c44pmRtLtFYcoD1
 r0oJKSqcbcZZo/aTH3KGQG4Q6rea+3t56Y8uBfm40w2hV0SAbC5OtjCHkAM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 16.05.2019 um 23:33 schrieb Madhumitha Prabakaran:
> Fix the warning issued by checkpatch
> Prefer kernel type 'u32' over 'uint32_t'.
> Along with that include a blank line after a declaration
> to maintain Linux kernel coding style.
>
> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

