Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A84DC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C04206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfG2Igi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:36:38 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48653 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfG2Igi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:36:38 -0400
Received: from [192.168.1.110] ([77.4.29.213]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MZSJa-1huoPJ0xEc-00WVTJ; Mon, 29 Jul 2019 10:35:27 +0200
Subject: Re: platform/x86/pcengines-apuv2: Missing apu4
To:     Gerhard Wiesinger <lists@wiesinger.com>,
        Florian Eckert <fe@dev.tdt.de>, Eckert.Florian@googlemail.com,
        info@metux.net, dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <02b34d18-27bc-cb48-f698-03df61df7d91@wiesinger.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <343400be-bd86-b59c-cfa0-862780493450@metux.net>
Date:   Mon, 29 Jul 2019 10:35:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <02b34d18-27bc-cb48-f698-03df61df7d91@wiesinger.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EYQW+pBb9mnBt37sECCdyu8aLvd3jAYgcpuzZejxR8oUQYJ+pLC
 3en+dryVKbf0yeQaWH/8FYu8LnLAzGpv+zUe05kvllEe5kKo3a/7THyndsTLDHK41HaaEBf
 yvOyth09RSvpUzvPue2c3BCoKTbUQBOmI2fYC36uKskzLQX3yMqcpO/G+kKvl/HMOiq0UpW
 tn5ljRGFk08gLamMrIrhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZEEEIOHYPpA=:YhRTZxRfvidtRGaLn3sRPd
 Sav0rJlpP4j53wdUEhBT1qtGUtIalk8NE5KBiC3d3kpzmwtON5s61KDzssJ4pnejAwnQYy6e7
 yGHVkfy7Y9I7/7qeAD0d+V/a1bdozdZaIKmSoiDk53E6Le33oIh68SSYWasTbOXrSRGshiX/2
 Hkr+NbRslBQZSn+vvsL7M/aoUN1ubnyoad5EfutyXPHpJCSTrIIjwRhejjsUU3n/hx7lNs5Lh
 0TI9DkjfM09WcfV0InW66qK8xiDyEuc0Mjm22/RbxrACp2GCMTaQ3w63l8DYjjmrvPjuR8sfy
 26rmGsLV8FcnD5detOVqc4T485XrKFMsuXiXI4+o9ZBRp1gyWTD0EPHOrkrU5bXS7TKXXc2oI
 JdWMK0ECNwrk1eri8zuQg9PWV7y0iEL1j52P7sSfTIzHORlDAyOssTuK1IB2gX+1fumrd/6tZ
 uILNTSPTfWVz8uSkq4fuLOwWi4sgGmYTXvb5pQf2BkEX3KS83feG5paW4B4EX9utbXwjWQl+X
 kZGJE+MDpTreeQDOBr6uX/+iRG7JhZCwuzksPbr68zkkV6W7kDE+SHXg/V/5R0tTlyhaC1nlL
 Z3pJ7r59dRJ+6c5PD9z0GHXd3Rnt4kq3H7gPRZJEMvarjiTrR6YU4Geiu9PxpCZHenW/Axg5f
 WS4dEP6ZuEgpb1t1MGbLmabskQokpQ+yU0nc5jPIVZxdsn2UU6g6X7SgwoZiDwApMLOkhGCcR
 J0l6HuWynL1faAhWtwf/KY+yNZq24YYhK1MLRWT7aXe6nl2ISzGnRd9KO2w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.19 16:56, Gerhard Wiesinger wrote:
> Hello,
> 
> I saw that the apu4 board is completly missing (also on 5.3rc1). Can you 
> please add it. Should be very easy, see below.

Still in the pipeline - don't have an apu4 board for testing yet.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
