Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300DBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0859720863
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbfB1Cfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:35:37 -0500
Received: from mx.socionext.com ([202.248.49.38]:43295 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730648AbfB1Cfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:35:36 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 28 Feb 2019 11:35:35 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 69FFE6117D;
        Thu, 28 Feb 2019 11:35:35 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 28 Feb 2019 11:35:35 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id C55601A15B8;
        Thu, 28 Feb 2019 11:35:34 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id A7D9B121B6C;
        Thu, 28 Feb 2019 11:35:34 +0900 (JST)
Subject: Re: [PATCH v4 07/10] dt-bindings: serial: Add Milbeaut serial driver
 description
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1551243210-10826-1-git-send-email-sugaya.taichi@socionext.com>
 <20190227150450.GA7056@kroah.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <d4850e01-fad1-2691-ddbf-093bedd1b6d5@socionext.com>
Date:   Thu, 28 Feb 2019 11:35:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227150450.GA7056@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/02/28 0:04, Greg Kroah-Hartman wrote:
> On Wed, Feb 27, 2019 at 01:53:30PM +0900, Sugaya Taichi wrote:
>> Add DT bindings document for Milbeaut serial driver.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../devicetree/bindings/serial/milbeaut-uart.txt    | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
> 
> I have already queued this up in my tty tree for merging in 5.1-rc1.
> 
> thanks,
> 
> greg k-h
> 

I see. Thank you!

