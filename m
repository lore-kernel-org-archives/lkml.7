Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550E9C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 10:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE8120869
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564224163;
	bh=FKIv2Flt+IqqJ1Su+e/rVR/A6BEogeYEWgrpHI8gt4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wmulp/R9hfmwzaoPZNgbpruBlIZNdENbM84WuDTxc9QCD+7kwnqgc00xNGA4J43rM
	 uEqoT+eplNrg51A0wlRZX4I37r+oyBNIePrzYsY8l0H8z/41Zk8grL/+ZYB/RTeIyb
	 iFA+hG087RgcYdlMKpzc05qQN05y+5reT11iwgFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfG0Kmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 06:42:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbfG0Kml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 06:42:41 -0400
Received: from localhost (lfbn-1-17239-195.w86-248.abo.wanadoo.fr [86.248.61.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DC4C2081B;
        Sat, 27 Jul 2019 10:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564224161;
        bh=FKIv2Flt+IqqJ1Su+e/rVR/A6BEogeYEWgrpHI8gt4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGH+vdTBIheA4rIMvadvnrLach2gVA/iKJhDyrnv9Zzy+0EmeU4b8j4O/xhO0iUUY
         b9YEkwaab7ZjiKTA1xpR4LsMdoM5w8Yu+UvapoxloPOfa8SFePvASZEozYrdoe+N3A
         jysOrI81icWHuhf8wNIqWO144bffEbGDRIA/yFrM=
Date:   Sat, 27 Jul 2019 12:42:36 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     thierry.reding@gmail.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/6] pwm: sun4i: Add a quirk for reset line
Message-ID: <20190727104236.43r7pa4e7htudc5y@flea.home>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-3-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726184045.14669-3-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 08:40:41PM +0200, Jernej Skrabec wrote:
> H6 PWM core needs deasserted reset line in order to work.
>
> Add a quirk for it.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
