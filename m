Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67E9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03E220656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfDXJXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:23:45 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:34434 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfDXJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:23:44 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id A69D625AE99;
        Wed, 24 Apr 2019 19:23:41 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id B806894041B; Wed, 24 Apr 2019 11:23:39 +0200 (CEST)
Date:   Wed, 24 Apr 2019 11:23:39 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        niklas.soderlund+renesas@ragnatech.se, geert+renesas@glider.be,
        sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com,
        kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com,
        fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com,
        biju.das@bp.renesas.com, erosca@de.adit-jv.com,
        george_davis@mentor.com, joshua_frkuska@mentor.com
Subject: Re: [PATCH v4 2/2] thermal: rcar_gen3_thermal: disable interrupt in
 .remove
Message-ID: <20190424092339.7a3ahaiij2qnuwh5@verge.net.au>
References: <20190424051145.23072-1-jiada_wang@mentor.com>
 <20190424051145.23072-3-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424051145.23072-3-jiada_wang@mentor.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
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

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

