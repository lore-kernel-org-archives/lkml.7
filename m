Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F14C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2968B217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567424817;
	bh=3AeKxO0ddoJuqHSrvWoZKyJIKicbcRXMYvMJTXIXUkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=opbReC6/SwA8HgvSwaoDJa453lZOh45Nms8Yt+56HwW5FNn4kL5uBzgiiQzlfg24+
	 BG8+rUCUS2UCHzAk4JqFvt3bdTaLmhRMWQHVRQJJb3km/UDpKlLMG3Dqovc2KKwDfr
	 a1Rh2RT69hURd4RX7ct9QDSEzNQB5JvQo/ad50AU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbfIBLq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 07:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731082AbfIBLqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 07:46:53 -0400
Received: from localhost (smbhubinfra01.hotspot.hub-one.net [213.174.99.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78E502173E;
        Mon,  2 Sep 2019 11:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567424813;
        bh=3AeKxO0ddoJuqHSrvWoZKyJIKicbcRXMYvMJTXIXUkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NOMkxTlpJiSLb1t19p8ePomtZzXLnK4x7mAVZFT8P7TxQHbZFafWmBozeYUnuejtq
         /eOWS2ZMDmVO8GQXvizOvHzE6hm6197vIi4dqfTSIv0d20lU7Z+FLnZdxIbxoOTY9g
         3PAH/y/1afdQCcMAszgWphcDBNYpBesP/6mPdFb0=
Date:   Mon, 2 Sep 2019 13:46:50 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/6] dt-bindings: watchdog: Add YAML schemas
 for the generic watchdog bindings
Message-ID: <20190902114650.w65ya7mgfsyu275x@flea>
References: <20190821143835.7294-1-mripard@kernel.org>
 <20190830164811.GA7911@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830164811.GA7911@roeck-us.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenther,

On Fri, Aug 30, 2019 at 09:48:11AM -0700, Guenter Roeck wrote:
> On Wed, Aug 21, 2019 at 04:38:30PM +0200, Maxime Ripard wrote:
> > From: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > The watchdogs have a bunch of generic properties that are needed in a
> > device tree. Add a YAML schemas for those.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks for reviewing this, which tree should this go through? Yours or Rob's?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
