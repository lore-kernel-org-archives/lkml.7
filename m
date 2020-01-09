Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463EDC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1927220673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbgAIP2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:28:21 -0500
Received: from mail.manjaro.org ([176.9.38.148]:60864 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbgAIP2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:28:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 0A2AC36E4E6C;
        Thu,  9 Jan 2020 16:28:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Er5maKmcrGp7; Thu,  9 Jan 2020 16:28:17 +0100 (CET)
Subject: Re: [RESEND 0/1] Add support for BOE NV140FHM-N49 panel to
 panel-simple
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200109112952.2620-1-t.schramm@manjaro.org>
 <20200109140742.GA12940@ravnborg.org>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <d4b20bfa-9315-b24b-b58b-f16825df715b@manjaro.org>
Date:   Thu, 9 Jan 2020 16:27:43 +0100
MIME-Version: 1.0
In-Reply-To: <20200109140742.GA12940@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Tobias.
> 
> We need binding schema before we can apply this patch.
Knew I forgot something
> See patch below.
> Please review/ack the patch, then we can process your panel-simple
> patch.
LGTM, thanks!
> 	Sam
> 
> On Thu, Jan 09, 2020 at 12:29:51PM +0100, Tobias Schramm wrote:
>> This patch adds support for the 14 inch BOE NV140FHM-N49 eDP panel to
>> the panel-simple driver. The panel is used by the Pinebook Pro.
>>
>> Resending with changed CCs due to lack of feedback.
> 
> 
>>
>> Tobias Schramm (1):
>>    drm/panel: Add support for BOE NV140FHM-N49 panel to panel-simple
>>
>>   drivers/gpu/drm/panel/panel-simple.c | 35 ++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>  From ad19c4636475bb05ba5c0b6cec2bee85045d628e Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Thu, 9 Jan 2020 14:48:41 +0100
> Subject: [PATCH] dt-bindings: display: add BOE 14" panel
> 
> Add bindings for the BOE NV140FHM-N49 14" 1920x1080 panel.
> 
> The panel is used by the pine64 Pinebook Pro.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Tobias Schramm <t.schramm@manjaro.org>
> ---
>   .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index ddc00480b6fe..6c098a0b6e1e 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -35,6 +35,8 @@ properties:
>         - ampire,am800480r3tmqwa1h
>           # AUO B116XAK01 eDP TFT LCD panel
>         - auo,b116xa01
> +        # BOE NV140FHM-N49 14.0" FHD a-Si FT panel
> +      - boe,nv140fhmn49
>           # GiantPlus GPM940B0 3.0" QVGA TFT LCD panel
>         - giantplus,gpm940b0
>           # Sharp LS020B1DD01D 2.0" HQVGA TFT LCD panel
> 
Reviewed-by: Tobias Schramm <t.schramm@manjaro.org>
