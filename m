Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B61C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEC920851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfCIKrz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 05:47:55 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:35369 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfCIKry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 05:47:54 -0500
Received: from oxbaltgw09.schlund.de ([172.19.246.15]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MAORp-1hClzk3ICJ-00BqZW; Sat, 09 Mar 2019 11:47:39 +0100
Date:   Sat, 9 Mar 2019 11:47:38 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Message-ID: <387603168.348361.1552128458820@email.ionos.de>
In-Reply-To: <20190308210738.10666-1-eric@anholt.net>
References: <20190308210738.10666-1-eric@anholt.net>
Subject: Re: [PATCH] arm64: bcm2835: Add missing dependency on MFD_CORE.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev51
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:oJ412IDsY8FCLiWyiXZZl6tQgmiQ7ydf2meQNqv39mznmcShx/6
 M0R9MwJsM9Qaf/ht2fwKVpVTCIIj2Qn3T9M2xPT7ci1vdsMRjjY04Ju8BkaZfgDLYt4Zd9J
 i3byBPYLkA2K1LNlq5jP6lLUrkfj1lUXhGn/nFtXYcjjeAqxxBy4mqMkriE+vom4eLt4UHT
 HbJtlRePopHQQOykv55OA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:smhsKxxu7m0=:l8qSPar/9WRYyVgtRKZDug
 AFcd+B6vcdIZvB4yM243dh5aktqRi7Tucqmx/4nNLlEqkpqle9YECZ32UxKOZ/0Lb0UaE0nk/
 K60RlB3gVxZaYut2+5W7bIocNXqR1a7QRQtElA+iONAHnHrT91wW+HB9inKSe5OpD6o0E4FJw
 3adequUHv5MbXg6UwweZuHSgenduLhCsyJqYgsX1r13bY9LjiL8NjFmHoETi40V6K3uqbE9dI
 vY0jZBIWD5jbKi1k5ipho88Vylu13scwF0dw1yAqtj6dR2DFS/GhHHt0xLL/D++s6bfLcITq0
 PX4Upqrjz3IeZBKtbg0K4+Qst5xNwc480DEtn+frP+bLZnL+WaArojsvb0ppHAMUJDLfIFw19
 IlrVzX7gaWnfUGO53JHO8dmpli/xeTWsfhVZNjB0HKnJvJW0nv2dcN9prJ4+HArqZKY7uTxWl
 PzRAsFsVirog8lf6J6WMAdLYC8ct7MCe36ZW/K27pbgers7rnVhK/sad0wTSatDPh8DO8TuWH
 KtQiaZAuuvqgl+uQTt2yzaQFIw3pj1E7EZPMi6XUpCTVI867NuUcI/XZ/9SoZdBSZMiImi/FC
 WJfv3uhmCFCA3puCY1iI7yo8BDcqn9J6GqCOuCEYdpUmCB5p3JJT7P66uT3if54qtKVmvVfN5
 OTLWAo794w4XkKQfOcWkCNGRQMiAcAuqc+dScbHacFYvrw0cc/KBk2ZrbbHN03YFH8IiowY/2
 wG/yjtgz6DvUcSauBPCy1WNKCoc7LdISDUrK++qtBM/lWjbw4jY+nZp0YqA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Eric Anholt <eric@anholt.net> hat am 8. März 2019 um 22:07 geschrieben:
> 
> 
> When adding the MFD dependency for power domains and WDT in bcm2835, I
> added it only on the arm32 side and missed it for arm64.
> 
> Fixes: 5e6acc3e678e ("bcm2835-pm: Move bcm2835-watchdog's DT probe to an MFD.")
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
