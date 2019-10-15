Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F970C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F112083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571134765;
	bh=LVAubQ5a4tx6kJZJZxy2deaudXFrQruZncCOv4L38Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iLnobKL/D3LHiUfOtW8Vf6yYy4yez84FtAz2CbNerOL1FRhwyj9j+oKmsESALI8rQ
	 XBEhsPsEAgIsrgPxzf0Svt8a1MK3qSuns2lfOEzkQnXIbgJ5oJN9h7nh3Ll2wtiaCK
	 Lz6lwJ+l6l1f+ZqInomby8KdYlGL23pHlcacD7AU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfJOKTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729923AbfJOKTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:19:20 -0400
Received: from localhost (unknown [171.76.96.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4D0E217F9;
        Tue, 15 Oct 2019 10:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571134759;
        bh=LVAubQ5a4tx6kJZJZxy2deaudXFrQruZncCOv4L38Mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eq+Kcnom8n08MOw6Tu5+4FF+hrx6aSgIUwLuwIGc1H3goH3rgQNwA5srrcWaXrnPc
         Ujnb5hUX9a6V6glWMH2ljcibvyplBruPDS/vTjpfJy4XuDWtFC2+SRITOesr27mCcV
         OjO7Kwd/z/mA8ifT6WbtvRkVqtAQjjOCdCbaWTfQ=
Date:   Tue, 15 Oct 2019 15:49:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [PATCH 02/10] dt-bindings: dmaengine: usb-dmac: Add binding for
 r8a774b1
Message-ID: <20191015101914.GT2654@vkoul-mobl>
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570531132-21856-3-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570531132-21856-3-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-10-19, 11:38, Fabrizio Castro wrote:
> This patch adds the binding for r8a774b1 SoC (RZ/G2N).

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
