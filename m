Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB46C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D1B2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566220750;
	bh=8TTzp+tZN5RuUVBzoIrpfSJN79i1Vr6tzgGxPMsL4Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gm32iHWkvHbGgog8aJ9lknz2wARKir30cJTSoymgNd7BMh5GkXGJr1AkuqxAcGXTd
	 JBV+nIA7dRZwnepBHcd6S3pJhL40sW8fEzoQ+FoPopS9XCFA6MmZFbT3HTd8Pt6HgX
	 bUeKjNhYs9txVMCqKjygATQvZleK3IcgpLLSxSTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfHSNTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbfHSNTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:19:09 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CEB20843;
        Mon, 19 Aug 2019 13:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566220748;
        bh=8TTzp+tZN5RuUVBzoIrpfSJN79i1Vr6tzgGxPMsL4Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wQEddTicyf/YOArp1KmESJ9ELJxt+uWGJkWyU7dhIk3BZBKtS1gLwxlUhoMlB8qip
         sloB7FJuzUdkNLqiA/V/iu4Jf2s9dpeYkVHh7aWTP9gurGuoqRyAz3msXMwmdvbGlQ
         sK8B76xe2H7nDJSfLN1FiQgTkuDSRaVcFAfPdXq0=
Date:   Mon, 19 Aug 2019 15:18:56 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hui Song <hui.song_1@nxp.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: ls1088a: fix gpio node
Message-ID: <20190819131854.GI5999@X250>
References: <20190813020457.45370-1-hui.song_1@nxp.com>
 <20190819114358.GX5999@X250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819114358.GX5999@X250>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 01:43:59PM +0200, Shawn Guo wrote:
> On Tue, Aug 13, 2019 at 10:04:57AM +0800, Hui Song wrote:
> > From: Song Hui <hui.song_1@nxp.com>
> > 
> > Update the nodes to include little-endian
> > property to be consistent with the hardware
> > and add ls1088a gpio specify compatible.
> > 
> > Signed-off-by: Song Hui <hui.song_1@nxp.com>
> 
> Applied, thanks.

Just noticed there is a new version, so dropped this one.

Shawn
