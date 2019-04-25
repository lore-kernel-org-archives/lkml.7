Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DD3C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A481A2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfDYRL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:11:29 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:43263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYRL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:11:29 -0400
Received: from oxbaltgw05.schlund.de ([172.19.246.11]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MD9Ox-1hSCLR1rYP-009AJI; Thu, 25 Apr 2019 19:11:12 +0200
Date:   Thu, 25 Apr 2019 19:11:11 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Andre.Przywara@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org
Message-ID: <1375455768.808427.1556212271639@email.ionos.de>
In-Reply-To: <20190415212129.1112-10-jeremy.linton@arm.com>
References: <20190415212129.1112-1-jeremy.linton@arm.com>
 <20190415212129.1112-10-jeremy.linton@arm.com>
Subject: Re: [v8 09/10] arm64: add sysfs vulnerability show for speculative
 store bypass
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev54
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:EiwVhB3XXpe5Oux+q614hCOdrvLuQGrnO8GGL3/xbZcxZB66jeP
 2XUTmYwWTClu/ijBWkfrNG9zxOszrtmhgX6tooI+bv1jOIgOvGerroF0Nc/HUjAHBgcbY8b
 Gs9YLOy3WfZwhjyfueGlniJIoshi/IYxp1voAnZkVGVwnuK26T7SAY6c4lJq7nNpFK3Cq9z
 Z2s+fNc/AlZxykK+Y8DIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1lppWUuFHUA=:PffeInm+yTx1FG9of4fjBs
 Av09yqD3QH6snduQEbdiil+BWZuOvSzOgIArXW32O1Hh/uOgyLUFXT18vJwv9RTPkslw7MAIQ
 x6FNU9zrq+/Lssc/+Be4nbBVq61W+mcdBWY3xkkM15/DPKEHvW9IlrXotvsccA0PcwkaGuwm9
 l7enK/8pqG8dy+UptK5uvurJazcEWxIyhb0/rAwZK6o9bYO0vuzo9hDb+wI5boD1WHo3jOg03
 Bo1smk0tMmXbwxjBrE4+BnpHor3rzDIWv0E7X0Y1Wjx3vqwxlgnNsiwdXkOsR9kieLNKzCplH
 6ktRDM3Uy9+NdeiPoyPTxDAciJn9yfO+FqirhqjNZElcNIGQ6hrnKeY0xA26Kd10HTbBBAk80
 iLXSmdzGGJ1fGGulVgeWOGzvVuqCeiZVkouJVaQWADrSFYbCe4C+sAo7wSoXC5H3H2GfAsDqk
 2W3vbso7pLY2DVH52BpG7uWX0LJAbTBsZ9xq4KWbgpK9vjT/MyAM4dVlLI/sdu4BiavW9bHAb
 dKk695/QTNV96cP1M7ZomqzNc8AnMP6YQCtRd9omUw574/c78FkdX17HceyYVSjkDJ916Fs17
 hzc7Yt5QJOgp67nlBsNVf+7J/NsoiUMhLN37vqzoqPjsD5zLP3ozKcmKnZGshSrCeL/5oApbm
 5ArfqR1XsTCjZtRaIp4i3FCoZaf9NNQKPke5RUj3pkFaRfCrDcXyhPyo7X/tP5RzK1aP5WMKE
 0iLIZYyYtbMV1PdAPvPXCV4mIsBbUZnrNv12C103RWpeTfPMB7aV7knZEi8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Jeremy Linton <jeremy.linton@arm.com> hat am 15. April 2019 um 23:21 geschrieben:
> 
> 
> Return status based on ssbd_state and __ssb_safe. If the
> mitigation is disabled, or the firmware isn't responding then
> return the expected machine state based on a whitelist of known
> good cores.
> 
> Given a heterogeneous machine, the overall machine vulnerability
> defaults to safe but is reset to unsafe when we miss the whitelist
> and the firmware doesn't explicitly tell us the core is safe.
> In order to make that work we delay transitioning to vulnerable
> until we know the firmware isn't responding to avoid a case
> where we miss the whitelist, but the firmware goes ahead and
> reports the core is not vulnerable. If all the cores in the
> machine have SSBS, then __ssb_safe will remain true.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

on a Raspberry Pi 3 B
