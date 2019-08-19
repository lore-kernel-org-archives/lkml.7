Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AF8C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DB322CEB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566237110;
	bh=+7QKYeUbcMCxsQX0oH5oA7FEOb5oKVFMAqNXEf6W2fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jGk6ytE/K0AD8NGoHZDdE4W7I8B3sZ+hYpDL9giFOeYj9/oDxf+/s6LRT0TDf7V+N
	 0dTy7KyPKw47BRvxuqCP+bNYLyfCFcAxL58lcfrCEW1cZGE4o80XO1FFfI/6zFWuNd
	 gsIHbU8+CX3LpDq/GKNpsvrKeEylC7xBj8UHmG8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfHSRvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbfHSRvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:51:49 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B705D218BA;
        Mon, 19 Aug 2019 17:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566237108;
        bh=+7QKYeUbcMCxsQX0oH5oA7FEOb5oKVFMAqNXEf6W2fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7bVdM3yw8O8alVxWgFO84DzblNWStlq5JeZ/F5MZafxNcyO/zdzqv9tXe7ZC63gZ
         eMzO9bLaWrkbKMvQB+kjfCMy3vZkQIq9o1AAI24yFUxUtLPbT/aUHUU9+bsAnNgSgc
         ddjMA6H66raGskUeHeDROSDKxKezHS67GlmxX/Zo=
Date:   Mon, 19 Aug 2019 19:51:43 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 5/5] ARM: dts: sunxi: Add missing watchdog interrupts
Message-ID: <20190819175143.g5hilveoeubkbfpk@flea>
References: <20190813124744.32614-1-mripard@kernel.org>
 <20190813124744.32614-5-mripard@kernel.org>
 <CAGb2v66C-Mqdo-xWm4RAw33sFk-gLy-L_YWQ__6BjYU9gcpYug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v66C-Mqdo-xWm4RAw33sFk-gLy-L_YWQ__6BjYU9gcpYug@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 12:44:02PM +0800, Chen-Yu Tsai wrote:
> On Tue, Aug 13, 2019 at 8:48 PM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > From: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > The watchdog has an interrupt on all our SoCs, but it wasn't always listed.
> > Add it to the devicetree where it's missing.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
>
> On a separate note, the A31 has four watchdogs in the timer block, and
> one interrupt for each watchdog. Should we expand the node to encompass
> all of them, or add separate nodes for each additional one?

Yep, I guess that's the idea considering the register range.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
