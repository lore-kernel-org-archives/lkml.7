Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E3BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DCD2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aJynixs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfCLP7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:59:22 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60228 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfCLP7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:59:22 -0400
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EFC0A33C;
        Tue, 12 Mar 2019 16:59:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552406359;
        bh=io54To9FxPECqduKv6dSKmWHoGUJ5duFHD+rfRjcPzY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aJynixs3pTeSwkK82DMMTlvEVqWz4T/vlx9ReEbCHIgf+ekcAepHdLVOHrDmlLm56
         b1j/NDjqxQGmH1W9bulGCLUo8/Gq+4IvnCIq23qHpBRPklL+85lzVwB7qF2odoKupk
         60KSVnXyz4cE4y9iXUHDaxixxHP3Sw3jxvG04x1M=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH v2] gpu: drm: atomic_helper: Fix spelling errors
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20190312003307.14116-1-kieran.bingham+renesas@ideasonboard.com>
 <20190312151443.GE3888@intel.com>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <7b0ff11c-68f3-4e2e-f969-27a14062158e@ideasonboard.com>
Date:   Tue, 12 Mar 2019 15:59:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190312151443.GE3888@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville,

On 12/03/2019 15:14, Ville Syrjälä wrote:
> On Tue, Mar 12, 2019 at 12:33:07AM +0000, Kieran Bingham wrote:
>> Trivial fixes identified while working on the DRM code.
>>
>>   s/artifically/artificially/
>>   s/achive/achieve/
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> ---
>>
>> v2: - Actually spell achieve correctly!
> 
> drm convention is to put this above the --- so that it gets included in
> the commit msg.

Oh - in linux-media these are just dropped.

I'll try to remember this for my future work in DRM.

I don't have commit access anyway, so can I presume whomever will pick
this up will adjust if necessary?

Or should I repost? (which might be a bit redundant just to move a patch
version comment which would then increase again :D )


> With that
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

Thanks,
--
Regards

Kieran


> 
>>
>>  drivers/gpu/drm/drm_atomic_helper.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
>> index 540a77a2ade9..2453678d1186 100644
>> --- a/drivers/gpu/drm/drm_atomic_helper.c
>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
>> @@ -1752,7 +1752,7 @@ int drm_atomic_helper_commit(struct drm_device *dev,
>>  	 *
>>  	 * NOTE: Commit work has multiple phases, first hardware commit, then
>>  	 * cleanup. We want them to overlap, hence need system_unbound_wq to
>> -	 * make sure work items don't artifically stall on each another.
>> +	 * make sure work items don't artificially stall on each another.
>>  	 */
>>  
>>  	drm_atomic_state_get(state);
>> @@ -1786,7 +1786,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit);
>>   *
>>   * Asynchronous workers need to have sufficient parallelism to be able to run
>>   * different atomic commits on different CRTCs in parallel. The simplest way to
>> - * achive this is by running them on the &system_unbound_wq work queue. Note
>> + * achieve this is by running them on the &system_unbound_wq work queue. Note
>>   * that drivers are not required to split up atomic commits and run an
>>   * individual commit in parallel - userspace is supposed to do that if it cares.
>>   * But it might be beneficial to do that for modesets, since those necessarily
>> -- 
>> 2.19.1
> 

