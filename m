Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B927C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3287D206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfCDOAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:00:13 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:10131 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCDOAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:00:12 -0500
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x24E03UR038804;
        Mon, 4 Mar 2019 23:00:03 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Mon, 04 Mar 2019 23:00:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x24E02DP038801
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 4 Mar 2019 23:00:03 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: add #sound-dai-cells to HDMI
 of rk3328
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190217173407.29189-1-katsuhiro@katsuster.net>
 <36101455.UDL3bTQpI8@phil>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <262965ee-e9e8-60d7-d9fc-114b9eeff651@katsuster.net>
Date:   Mon, 4 Mar 2019 23:00:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <36101455.UDL3bTQpI8@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

On 2019/03/03 22:55, Heiko Stuebner wrote:
> Am Sonntag, 17. Februar 2019, 18:34:06 CET schrieb Katsuhiro Suzuki:
>> This patch adds #sound-dai-cells to use HDMI node as audio
>> codec from device tree of rk3328 boards.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> 
> applied for 5.2 .
> 
> I'm holding off of patch2 for a bit until you and Jonas can clarify that
> all is right as it is :-)

Thanks and I understand about patch 2.

Best Regards,
Katsuhiro Suzuki

> 
> 
> Heiko
> 
> 
> 

