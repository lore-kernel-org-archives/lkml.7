Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF006CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28D721872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mkYsadjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405542AbfJWNBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:01:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50654 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732149AbfJWNBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:01:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9ND0wKF041617;
        Wed, 23 Oct 2019 08:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571835658;
        bh=EuU0iGlFfXpr/90VNz9x7JLNC8IyvPE3kuocYGWj/Qo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mkYsadjYcD5QCy3EEcZdQ+YA6c7Mcxq8O0UpaFZRGt3cBhODgZOJ/UD27AvGFf8DD
         wZ5YAmlVGnx2DY4F3TUwPudgr8aL/CAoFKO1FBbLKSJ4XR+9ecgyC66YxW0XE0Mqci
         sU171WB0CmEPng9RYVY3m3i2CHQ5+xv+SJg2l0EE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9ND0wct073288
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 08:00:58 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 08:00:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 08:00:57 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9ND0tlG088549;
        Wed, 23 Oct 2019 08:00:56 -0500
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir
 GPIO
To:     Roger Quadros <rogerq@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191023084916.26895-1-rogerq@ti.com>
 <20191023084916.26895-3-rogerq@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d8398dc4-cd6c-a3d1-1951-f1ad3d1b3ae3@ti.com>
Date:   Wed, 23 Oct 2019 18:30:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023084916.26895-3-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roger,

On 23/10/19 2:19 PM, Roger Quadros wrote:
> This is an optional GPIO, if specified will be used to
> swap lane 0 and lane 1 based on GPIO status. This is required
> to achieve plug flip support for USB Type-C.
> 
> Type-C companions typically need some time after the cable is
> plugged before and before they reflect the correct status of
> Type-C plug orientation on the DIR line.
> 
> Type-C Spec specifies CC attachment debounce time (tCCDebounce)
> of 100 ms (min) to 200 ms (max).
> 
> Allow the DT node to specify the time (in ms) that we need
> to wait before sampling the DIR line.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  .../devicetree/bindings/phy/ti,phy-j721e-wiz.txt         | 9 +++++++++

I've posted new version to change the binding document to YAML format. Can you
make the changes on top of that series?

Thanks
Kishon

>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt
> index 19b4c3e855d6..253535a8819f 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt
> @@ -24,6 +24,15 @@ Optional properties:
>  assigned-clocks and assigned-clock-parents: As documented in the generic
>  clock bindings in Documentation/devicetree/bindings/clock/clock-bindings.txt
>  
> + - typec-dir-gpios: GPIO to signal Type-C cable orientation for lane swap.
> +     If GPIO is active, lane 0 and lane 1 of SERDES will be swapped to
> +     achieve the funtionality of an exernal type-C plug flip mux.
> +
> + - typec-dir-debounce: Number of milliseconds to wait before sampling
> +     typec-dir-gpio. If not specified, the GPIO will be sampled ASAP.
> +     Type-C spec states minimum CC pin debounce of 100 ms and maximum
> +     of 200 ms.
> +
>  Required subnodes:
>   - Clock Subnode: WIZ node should have '3' subnodes for each of the clock
>       selects it supports. The clock subnodes should have the following names
> 
