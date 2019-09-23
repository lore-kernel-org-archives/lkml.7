Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497D0C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16624207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfIWPeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:34:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58376 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfIWPeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:34:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 45F75283B93
Subject: Re: [PATCH] drm/rockchip: Add AFBC support
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190923122014.18229-1-andrzej.p@collabora.com>
 <da7f0c5e-9ca9-020d-5366-2b21a42acdff@baylibre.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <332335a5-dc7f-2cce-601f-f73e9243dee5@collabora.com>
Date:   Mon, 23 Sep 2019 17:34:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <da7f0c5e-9ca9-020d-5366-2b21a42acdff@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

As a result of my mistake I've sent this patch with an incorrect SOB chain. 
Please kindly disregard this patch.

@Neil: thank you for your time you spent reviewing it and answering and I'm 
sorry it's to no effect.
@Ezequiel, @Tomeu: I apologize to you. My mistake.

Regards,

Andrzej Pietrasiewicz


W dniu 23.09.2019 o 15:53, Neil Armstrong pisze:
> On 23/09/2019 14:20, Andrzej Pietrasiewicz wrote:
>> From: Ezequiel Garcia <ezequiel@collabora.com>
>>
>> AFBC is a proprietary lossless image compression protocol and format.
>> It helps reduce memory bandwidth of the graphics pipeline operations.
>> This, in turn, improves power efficiency.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>> [locking improvements]
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> [squashing the above, commit message and Rockchip AFBC modifier]
>> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
>> ---
>>   drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 27 ++++++
>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 94 ++++++++++++++++++++-
>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 12 +++
>>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 18 ++++
>>   include/uapi/drm/drm_fourcc.h               |  3 +
>>   5 files changed, 151 insertions(+), 3 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
>> index 3feeaa3f987a..ba6caf06c824 100644
>> --- a/include/uapi/drm/drm_fourcc.h
>> +++ b/include/uapi/drm/drm_fourcc.h
>> @@ -742,6 +742,9 @@ extern "C" {
>>    */
>>   #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
>>   
>> +#define AFBC_FORMAT_MOD_ROCKCHIP \
>> +	(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 | AFBC_FORMAT_MOD_SPARSE)
> 
> This define looks useless, what's Rockchip specific here ?
> 
> Neil
> 
>> +
>>   /*
>>    * Allwinner tiled modifier
>>    *
>>
> 

