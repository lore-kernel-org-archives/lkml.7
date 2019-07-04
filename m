Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6C0C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0067D21738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfGDSSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 14:18:02 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:35141 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfGDSSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 14:18:02 -0400
Received: from [192.168.1.110] ([77.7.33.110]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MekKJ-1iHcF10Vrp-00aiBk; Thu, 04 Jul 2019 20:17:58 +0200
Subject: Re: [PATCH V2 1/2] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jeyentam <je.yen.tam@ni.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190703072435.34152-1-je.yen.tam@ni.com>
 <63697b10-98a7-86b7-2513-3eb793ed03c5@metux.net>
 <20190703144744.GB24961@kroah.com>
 <d6910b29-3ba6-4a3b-04e2-bc7c3c012554@metux.net>
 <20190703155941.GB19567@kroah.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <9f08515a-3498-709e-d72b-538a54b704ad@metux.net>
Date:   Thu, 4 Jul 2019 20:17:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190703155941.GB19567@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:64RlVmaFLfJlha/Ih2qmFZUuxvO/1Eo/DsldCYVASaAI+LXdoeK
 ZGBn/rarPtXIu8hf153V+ZDl+EdTw9VWD623MHzs2dVjYtNRvE4G6C9Sfff1QrRGg74YIlU
 gnSh3HEce1sSrwvHYfZra14wkTyTdc8rrU6tLfF1Z+/lwdHna/zf5sk8VR28q9+KoaivFmr
 g1klM6xm0RUqObL4RkA6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Jkgl22K3Zg=:xHAax89h6FBOOQHLER9mFE
 egKIlpYynvyBO9ovw36I7qU/lUTF0V9cKEZys6aM1wudEFSko6TEdjo6VzHjzKD5KQiO0DDS3
 bOHfdaOXtIlV2bevEumFFJrLPswkHAzakXR+DZshLcPDqxLpE+V1u/FMldwwbdjnhJM1t5Cyq
 TxvYGZ9wuJzM9/QFmfnirqO1gLrCk3FdplacHG7HS91fAc7Kpaa4NIAyfjkE2l02LZNyF4SvR
 EZa7V1MpABhS8ULLRxsRl4sB+TshUpaXmY9gm/XygP2qBBlGRiEsOlSfYSEjfhOH2qzxoOQGq
 0Ug2iRk3GzZ04ORh01r6BCoVjLRevjA/CtIM8Ol86Z2hwl+nL5CFSUTgMFRXmC+Ys9JDmNUk3
 f1cET7gWZeQjomG5Q48kNw0eUT/rQNdAxSydpm1TK+cZyu/TxmqoKTu60KgvdWXH5jhF1zq2k
 S1h0xogFMT32f5t0ZiSlD8Bg8ufJ+tNl4wZZFe52i8iKt7xxlNJmrD75zBD2Ne1naAq2ZKPyc
 HPkhLM1bxgkkx7ngsmfdWM17qSn5dtkbpi2FvN5G9M0f+C9ydc05U40p4i6vq7TsHYqGxBOW4
 rp2q0sCVzOPAeX0balL73I6OPIR18Xp8sJQDypIdWxgCin2cxvQVOvpdkSm7fH58aK5tVe0AD
 DciG2dibBBHQ4zqTKqzuyYzxa4s9wEI7yhpNo8V7eU3mjwYr+G5olQkctEv0+uhZfQz8s0D07
 cdIH15SLM7VNxuzbll/EEJ3qMAKbehxXs5N1zK9OqM5BSMOGgXb4h8NU1Z4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.19 17:59, Greg KH wrote:

>> That's sad, because in embedded world we often have to care about
>> code size, so making those devices optional would be of great help.
> 
> Really?  are you sure?  Try it and see what you really end up saving.

Just in 8250_pci.c alone, I could (depending on actual target) drop
about 80% LoC. Haven't tested how much the difference in image size
will really be.

But if you really like to know and would consider taking some patches
for making those things optional, I'll take some time and do the
dirty work.

By the way: would you still be opposed when these options are masked
behind CONFIG_EXPERT or CONFIG_EMBEDDED ? I can imagine this could be a
good compromise.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
