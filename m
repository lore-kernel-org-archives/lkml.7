Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26FFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B312075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfCZNta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:49:30 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:18541 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZNta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:49:30 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2QDnGT8061775;
        Tue, 26 Mar 2019 22:49:17 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Tue, 26 Mar 2019 22:49:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2QDnGHD061770
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 26 Mar 2019 22:49:16 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v2] arm64: dts: rockchip: add rk3399 UART DMAs
To:     Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190321162244.10080-1-katsuhiro@katsuster.net>
 <8309531.dRdlsDmmhi@phil> <f2d0a95f-33c0-cdeb-80e3-0cd04bd0871d@arm.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <e7bcf8b9-123e-eb30-f47d-7f8855f30ccb@katsuster.net>
Date:   Tue, 26 Mar 2019 22:49:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <f2d0a95f-33c0-cdeb-80e3-0cd04bd0871d@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robin,

Sorry for inconvenience. Since I don't adhere enabling DMA for UARTs,
please revert my patch if you need.

BTW, there are DMA properties in RK3328 device-tree like as this patch.
RK3328 UART DMA could not work correctly too...??

Best Regards,
Katsuhiro Suzuki


On 2019/03/26 20:48, Robin Murphy wrote:
> On 25/03/2019 12:34, Heiko Stuebner wrote:
>> Am Donnerstag, 21. März 2019, 17:22:44 CET schrieb Katsuhiro Suzuki:
>>> Add UART dma channels as specified by the rk3399 TRM.
>>>
>>> Refer:
>>> RK3399 TRM V1.4: Chapter 12 DMA Controller
>>>
>>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>>
>> applied for 5.2
> 
> As a heads-up, I did manage to try my board with this patch applied over 
> the weekend, and it makes probing the bluetooth adapter fail with 
> communication errors, so I'm not sure the 8250 and pl330 drivers are 
> really cooperating well enough :(
> 
> Robin.
> 

