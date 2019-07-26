Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FB1C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EB32166E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="hpcgBbvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGZIGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:06:06 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:36846 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726384AbfGZIGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:06:05 -0400
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jul 2019 04:06:04 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2AB0A412D2;
        Fri, 26 Jul 2019 07:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        user-agent:in-reply-to:content-disposition:content-type
        :content-type:mime-version:references:message-id:subject:subject
        :from:from:date:date:received:received:received; s=mta-01; t=
        1564127814; x=1565942215; bh=t7R6X8nvFz+0QciEa3VrF8VwhbSoAtsuItD
        wYQ0loc4=; b=hpcgBbvByqr1Xb893BxdoU1Cbaaf36vBPH9hCTucba2X0xOPeyb
        O0RdOn5CcQzjxevvIR7J7f0PsQG+BICWXFCRKWdoRA/Uk2dHCcxvOrz3ATANxP6e
        EdLoB6R8qbQMg0lDsbc/25vKxrFDq+YySIcgsNhCuA4L5+oMhrH/DmPQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XJyaxH08dzGi; Fri, 26 Jul 2019 10:56:54 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 0BB6741185;
        Fri, 26 Jul 2019 10:56:53 +0300 (MSK)
Received: from localhost (172.17.14.115) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 26
 Jul 2019 10:56:53 +0300
Date:   Fri, 26 Jul 2019 10:56:53 +0300
From:   "Alexander A. Filippov" <a.filippov@yadro.com>
To:     Andrew Jeffery <andrew@aj.id.au>
CC:     <linux-aspeed@lists.ozlabs.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <joel@jms.id.au>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Filippov <a.filippov@yadro.com>
Subject: Re: [PATCH 04/17] ARM: dts: vesnin: Add unit address for memory node
Message-ID: <20190726075653.GA10397@bbwork.lan>
References: <20190726053959.2003-1-andrew@aj.id.au>
 <20190726053959.2003-5-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20190726053959.2003-5-andrew@aj.id.au>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Originating-IP: [172.17.14.115]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 03:09:46PM +0930, Andrew Jeffery wrote:
> Fixes the following warnings:
> 
>     arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dt.yaml: /: memory: False schema does not allow {'reg': [[1073741824, 536870912]]}
>     arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dt.yaml: memory: 'device_type' is a required property
> 
> Cc: Alexander Filippov <a.filippov@yadro.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> index 0b9e29c3212e..81d9dcb752a0 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> @@ -14,7 +14,7 @@
>  		bootargs = "console=ttyS4,115200 earlyprintk";
>  	};
>  
> -	memory {
> +	memory@40000000 {
>  		reg = <0x40000000 0x20000000>;
>  	};
>  
> -- 
> 2.20.1
> 

Tested-by: Alexander Filippov <a.filippov@yadro.com>
