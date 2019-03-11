Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344ACC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF6B205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WyiRwyJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfCKQkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:40:19 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60796 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKQkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:40:19 -0400
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E0BF255;
        Mon, 11 Mar 2019 17:40:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552322417;
        bh=pZw7et5seMJkLr5dhJ6+pftoKiAxCDAR7zSnseRaxkE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WyiRwyJ/zOwr4oWrS+Pdd4PxV98iDnhkk5yoRew7EnNzzq++UpecbiRcV5NN2s62J
         MtcxGlV8rYI74qBrm3obQa34b4O2gUoNlG7R0voLbL+scrWJoAWedA8AxeXKOdATPd
         II4GdBpH9SDQkbWZ8PgD52Ss6bsQ1D+4xZo83hxg=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH] gpu: drm: atomic_helper: Fix spelling errors
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
References: <20190311153639.979-1-kieran.bingham+renesas@ideasonboard.com>
 <20190311160013.GZ3888@intel.com>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <1890c871-16e3-4e38-aeeb-714e66cea24f@ideasonboard.com>
Date:   Mon, 11 Mar 2019 16:40:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190311160013.GZ3888@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville,

On 11/03/2019 16:00, Ville Syrjälä wrote:
> On Mon, Mar 11, 2019 at 03:36:39PM +0000, Kieran Bingham wrote:
>> Trivial fixes identified while working on the DRM code.
>>
>>   s/artifically/artificially/
>>   s/achive/acheive/
> 
> achieve?

Good point :) It's rubbish being a native English speaker :( - So much
harder to get the spelling correct :D.

I'll repost a v2 - sorry for the noise!

--
Kieran



> 
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> ---
>>  drivers/gpu/drm/drm_atomic_helper.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
>> index 540a77a2ade9..ccb278ed1bf8 100644
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
>> + * acheive this is by running them on the &system_unbound_wq work queue. Note
>>   * that drivers are not required to split up atomic commits and run an
>>   * individual commit in parallel - userspace is supposed to do that if it cares.
>>   * But it might be beneficial to do that for modesets, since those necessarily
>> -- 
>> 2.19.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

