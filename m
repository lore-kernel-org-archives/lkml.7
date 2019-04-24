Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1316C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E76218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfDXMbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:31:24 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:34411 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730206AbfDXMbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:31:24 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 1DC1B3C0034;
        Wed, 24 Apr 2019 14:31:22 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T5yEyPkFV5b8; Wed, 24 Apr 2019 14:31:15 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 797143C00D1;
        Wed, 24 Apr 2019 14:31:15 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr
 2019 14:31:15 +0200
Date:   Wed, 24 Apr 2019 14:31:15 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Jiada Wang <jiada_wang@mentor.com>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms+renesas@verge.net.au>,
        <niklas.soderlund+renesas@ragnatech.se>, <geert+renesas@glider.be>,
        <sergei.shtylyov@cogentembedded.com>,
        <marek.vasut+renesas@gmail.com>,
        <kuninori.morimoto.gx@renesas.com>, <hien.dang.eb@renesas.com>,
        <fabrizio.castro@bp.renesas.com>, <dien.pham.ry@renesas.com>,
        <biju.das@bp.renesas.com>, <george_davis@mentor.com>,
        <joshua_frkuska@mentor.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v4 2/2] thermal: rcar_gen3_thermal: disable interrupt in
 .remove
Message-ID: <20190424123115.GB22366@vmlxhi-102.adit-jv.com>
References: <20190424051145.23072-1-jiada_wang@mentor.com>
 <20190424051145.23072-3-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190424051145.23072-3-jiada_wang@mentor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 02:11:45PM +0900, Jiada Wang wrote:
> Currently IRQ remains enabled after .remove, later if device is probed,
> IRQ is requested before .thermal_init, this may cause IRQ function be
> called before device is initialized.
> 
> this patch disables interrupt in .remove, to ensure irq function
> only be called after device is fully initialized.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Based on https://patchwork.kernel.org/cover/10914079/#22603533 :

Reviewed-and-Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Thanks!

-- 
Best regards,
Eugeniu.
