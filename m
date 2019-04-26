Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC1CC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876132077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfDZLsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:48:42 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44281 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZLsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:48:42 -0400
Received: from [192.168.1.110] ([95.117.100.117]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MZkYx-1hGIjx1hFn-00WqrU; Fri, 26 Apr 2019 13:48:30 +0200
Subject: Re: [PATCH 1/3] drivers: nvme: target: core: fix build break
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1556102081-11820-1-git-send-email-info@metux.net>
 <1556102081-11820-2-git-send-email-info@metux.net>
 <SN6PR04MB452772B2864B2074DDB018ED863D0@SN6PR04MB4527.namprd04.prod.outlook.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <0b4f821e-2b85-3199-32a2-21272748a301@metux.net>
Date:   Fri, 26 Apr 2019 13:48:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <SN6PR04MB452772B2864B2074DDB018ED863D0@SN6PR04MB4527.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ye750J3/ICb836QUb2aMUDYuFP5foHVslmTk+yXHNgn7bm9zs4c
 TgonIwv09pa8CGnZW7/Q30ldjUUz7pqEmQb8WoGKIVeqT+E0xFyMHIw3l48iCRUimkkH8oQ
 w9yrf2BAPk5YRyHps8D4Y1rmHZFp1SA8TDzxuPOK5m5shW7Us8Tup18OcYJnbZyW40sLywW
 tqH+hWUr9fzd1968Bc1WA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZjY8NmqLx6g=:73Dzj/NwmxW9ownme/oYMe
 WKukrO196SVi+cKfnFi72GwJ5zVDist1pYRWj8qmfIaRL8TRlWHc3m/U1SqeiP4+YBi3C/Ett
 hsRR7CI9xicRWuokK1m7qkcYNWIuk6LF5PFBRrPLPqtpFicLvZmMsrg67UZmmqhJclpsY10t+
 nvF4mbTrSiaNs+n9rXEhIDBqyCt8ABwRgcFBGqyhV0wJp3r9t30iJfQYBgrdSB4UN/KDUC9Vl
 /HlDOEEvGg/cpyGbnHJadjTQC38dgfXaFiagoFFP1MzvlbDFGwgKrxOW3oRcRFZ/0oBu/ZXAf
 SuGgsxNBAgkzKTx3mbF6KauKH+97e5bZ6oLXthbXQ1hpNp4DdC7rdnfudGWiOqrQHgU5FiCUQ
 Uw+5On5Ya3GP4EqWYQ4OuHFhpfvCQZoMNqqXJ8rMWm8vT9vlAjJqDL0c3htW5z2v9qpSgrFiO
 oSyxHxditwT3QPlkyriciqnfQTOP2+dzU8afqgZ3ujIMyTyUvkaWWYfmwWFZbLM0egkIrPtRV
 HipZapCS4bw+eXoDIVJx54p1dtSGFmIGQkhUtTNo9pXo5EqGU0SenCCeMJsQFskS2UerZtOr8
 Fq+wpC4T8GTnYVJkWXJRKR6D/Vx0gkHz+9rIXcNYtW1CIqlI31t1E3l0++bJwE7kjmZskVEhq
 oEcrUoQ9fa/I2sRVmJX1Sum+8sjhxKpLX+SfNgTpEZB6vsgZ7xncT+xWaC7nU8L+AnDJM3VQr
 1meVI+zpgU1rpgBt1d03MZcE1LRRXuEIm4GVT7cgekAwS8mKFww7V28Md+c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.19 03:00, Chaitanya Kulkarni wrote:
> Thanks for the fix Enrico. I'm still wondering on what platform
> you got this error ?

a pretty standard x86/pc.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
