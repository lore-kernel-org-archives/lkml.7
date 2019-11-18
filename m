Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE331C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EF72071C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ztp0xfS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfKRIDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:03:03 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42336 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfKRIDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:03:03 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAI82uwY020694;
        Mon, 18 Nov 2019 02:02:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574064176;
        bh=PI8nD4jFp/0XnhGQ6/XR612OzagpQkaNZfAIXVgyfrY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ztp0xfS1khPfQ4X+EmSwA7YGiQmNzcDlMgINCoWyMQOp6+MzX2cBLCr6w4bvxoZ+J
         VYpIZmiIw77PzJXGH+vlMF90I5GNWYMLvtc0haB4jPEeuCQhLgAuJblVdc45OmtwOZ
         cBEnSgR87jkq3uKkkqMy8uIm7siY6Gegg5aizopQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAI82uLv004259
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Nov 2019 02:02:56 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 18
 Nov 2019 02:02:56 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 18 Nov 2019 02:02:56 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAI82reL087431;
        Mon, 18 Nov 2019 02:02:54 -0600
Subject: Re: [PATCH] bindings:phy Mark phy_clk binding as deprecated in
 Cadence Sierra Phy.
To:     Anil Joy Varughese <aniljoy@cadence.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <rafalc@cadence.com>
References: <1574062988-4751-1-git-send-email-aniljoy@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <dce65150-cbd8-eb4d-5778-47658a719eb5@ti.com>
Date:   Mon, 18 Nov 2019 13:32:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574062988-4751-1-git-send-email-aniljoy@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anil,

On 18/11/19 1:13 PM, Anil Joy Varughese wrote:
> Updated the Sierra Phy binding doc to mark phy_clk as deprecated.

This should also indicate why your are deprecating it.

Thanks
Kishon

> 
> Signed-off-by: Anil Joy Varughese <aniljoy@cadence.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-sierra.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
> index 6e1b47b..9a42b46 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
> @@ -5,7 +5,7 @@ Required properties:
>  - compatible:	cdns,sierra-phy-t0
>  - clocks:	Must contain an entry in clock-names.
>  		See ../clocks/clock-bindings.txt for details.
> -- clock-names:	Must be "phy_clk"
> +- clock-names:	Must be "phy_clk". This is deprecated and should not be used with newer bindings.
>  - resets:	Must contain an entry for each in reset-names.
>  		See ../reset/reset.txt for details.
>  - reset-names:	Must include "sierra_reset" and "sierra_apb".
> 
