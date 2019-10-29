Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1721FCA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 05:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB78820830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 05:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbfJ2F1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 01:27:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:53142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfJ2F1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 01:27:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA52BAEAC;
        Tue, 29 Oct 2019 05:27:05 +0000 (UTC)
Subject: Re: [PATCH v2 06/11] arm64: dts: realtek: Add RTD129x reset
 controller nodes
To:     linux-realtek-soc@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20191023101317.26656-1-afaerber@suse.de>
 <20191023101317.26656-7-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <d33c26ac-5015-0b3c-3361-531992a943e8@suse.de>
Date:   Tue, 29 Oct 2019 06:27:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023101317.26656-7-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.10.19 um 12:13 schrieb Andreas Färber:
> Add nodes for the Realtek RTD1295 reset controllers.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Rebased, moved from rtd1295.dtsi to rtd129x.dtsi
>  
>  arch/arm64/boot/dts/realtek/rtd129x.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Applied to linux-realtek.git v5.5/dt64:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/log/?h=v5.5/dt64

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
