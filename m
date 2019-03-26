Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C10DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A9320828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553578138;
	bh=O7DNrgkxB8zkBDCbcmxizSv3hd4nJNmswIIejMtsq1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2JYvzpcSKyTsa4TMs5cOM19/iyjLJhHs6hdZzyuhjlhbHjIq7fmO+rlNdwr1h1G5q
	 ErTIVmykzBaNGC5lbn85QotHWuDMDP/ml2jCmYNuMfGCFpSCEOCpGOmO4nSNY6AQ0K
	 4+JaFqhHGIAR2tcH/c6lJenwsdocp2aSOGQLq+mQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfCZF25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfCZF24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 01:28:56 -0400
Received: from localhost (unknown [171.61.95.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DAA820856;
        Tue, 26 Mar 2019 05:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553578135;
        bh=O7DNrgkxB8zkBDCbcmxizSv3hd4nJNmswIIejMtsq1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2DXSV+owy9xeOvOtNefsIdMWh80Qhf5guWVd6L+v63iFoxIPcpEN6mag+vubqnztY
         rgzSmBTiF75U4zDdGGVoME0g0iatjOojYd4ob3niK0wi5Cbh4L4Imn6KMW123lDG7P
         dw9h+73ewhl+tSE+pcvYQ+4IvvRL3QJ17c6iRocg=
Date:   Tue, 26 Mar 2019 10:58:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Bad file pattern in MAINTAINERS section 'ARM/UNIPHIER
 ARCHITECTURE'
Message-ID: <20190326052849.GV5348@vkoul-mobl>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212453.25934-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325212453.25934-1-joe@perches.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-03-19, 14:24, Joe Perches wrote:
> A file pattern line in this section of the MAINTAINERS file in linux-next
> does not have a match in the linux source files.
> 
> This could occur because a matching filename was never added, was deleted
> or renamed in some other commit.
> 
> The commits that added and if found renamed or removed the file pattern
> are shown below.
> 
> Please fix this defect appropriately.
> 
> 1: ---------------------------------------------------------------------------
> 
> linux-next MAINTAINERS section:
> 
> 	2344	ARM/UNIPHIER ARCHITECTURE
> 	2345	M:	Masahiro Yamada <yamada.masahiro@socionext.com>
> 	2346	L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> 	2347	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> 	2348	S:	Maintained
> 	2349	F:	Documentation/devicetree/bindings/arm/socionext/uniphier.txt
> 	2350	F:	Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
> 	2351	F:	Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.txt
> 	2352	F:	arch/arm/boot/dts/uniphier*
> 	2353	F:	arch/arm/include/asm/hardware/cache-uniphier.h
> 	2354	F:	arch/arm/mach-uniphier/
> 	2355	F:	arch/arm/mm/cache-uniphier.c
> 	2356	F:	arch/arm64/boot/dts/socionext/uniphier*
> 	2357	F:	drivers/bus/uniphier-system-bus.c
> 	2358	F:	drivers/clk/uniphier/
> -->	2359	F:	drivers/dmaengine/uniphier-mdmac.c

yeah this should be drivers/dma/<>

I have fixed it up with below

 --8<--


From: Vinod Koul <vkoul@kernel.org>
Date: Tue, 26 Mar 2019 10:55:47 +0530
Subject: [PATCH] MAINTAINERS: Fix uniphier-mdmac.c file path

Commit 32e74aabebc8 ("dmaengine: uniphier-mdmac: add UniPhier MIO DMAC
driver") wrongly put filepath for uniphier-mdmac.c, fix it

Fixes: 32e74aabebc8 ("dmaengine: uniphier-mdmac: add UniPhier MIO DMAC driver")
Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..67e895feddc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2356,7 +2356,7 @@ F:	arch/arm/mm/cache-uniphier.c
 F:	arch/arm64/boot/dts/socionext/uniphier*
 F:	drivers/bus/uniphier-system-bus.c
 F:	drivers/clk/uniphier/
-F:	drivers/dmaengine/uniphier-mdmac.c
+F:	drivers/dma/uniphier-mdmac.c
 F:	drivers/gpio/gpio-uniphier.c
 F:	drivers/i2c/busses/i2c-uniphier*
 F:	drivers/irqchip/irq-uniphier-aidet.c
-- 
2.20.1

Thanks
-- 
~Vinod
