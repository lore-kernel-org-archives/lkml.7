Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CC6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66CF2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfCZLsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:48:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35054 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfCZLsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:48:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C58661596;
        Tue, 26 Mar 2019 04:48:19 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7BD83F59C;
        Tue, 26 Mar 2019 04:48:18 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: rockchip: add rk3399 UART DMAs
To:     Heiko Stuebner <heiko@sntech.de>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190321162244.10080-1-katsuhiro@katsuster.net>
 <8309531.dRdlsDmmhi@phil>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f2d0a95f-33c0-cdeb-80e3-0cd04bd0871d@arm.com>
Date:   Tue, 26 Mar 2019 11:48:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <8309531.dRdlsDmmhi@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2019 12:34, Heiko Stuebner wrote:
> Am Donnerstag, 21. März 2019, 17:22:44 CET schrieb Katsuhiro Suzuki:
>> Add UART dma channels as specified by the rk3399 TRM.
>>
>> Refer:
>> RK3399 TRM V1.4: Chapter 12 DMA Controller
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> 
> applied for 5.2

As a heads-up, I did manage to try my board with this patch applied over 
the weekend, and it makes probing the bluetooth adapter fail with 
communication errors, so I'm not sure the 8250 and pl330 drivers are 
really cooperating well enough :(

Robin.
