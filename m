Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8E5C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0392077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575458832;
	bh=6Z0f+GH4Z7+tlO/TeA6h4wk+X8g4hZtHpvHBDJn+b18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JUunrPqRlKKz8RMbCFezae0/k3zOhPhIQykpv16elYGgk4j/jojl3o9VhTbbNthUn
	 LC4FiJsZZZr3J1avspejAFp+hLuEAHzrIGIYf3V8I+62HUB8u6mTCjpx6cP8GNoiyf
	 3g6zTZK5vjiS/xHEKlDYH8LPh1MLAcgzXRGaZxGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfLDL1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:27:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbfLDL1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:27:11 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF7F720637;
        Wed,  4 Dec 2019 11:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575458830;
        bh=6Z0f+GH4Z7+tlO/TeA6h4wk+X8g4hZtHpvHBDJn+b18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2f8Fse1Zp/kxqBfYLtLFtlWmUQULLl36F8QmrptmbxwWWIqm9mwFZumN3Mc44StCY
         jZSnhJT6Whb1m5h6DDcLu1ihiZfmXXP9EqKWZq++sH2wFOxWmMyS5ro92moKGx/b+P
         /7B1rbGr0Otv5DBGlSIS6YZIjpBUzMiwzEFNrBd8=
Date:   Wed, 4 Dec 2019 19:27:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fancy Fang <chen.fang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>, Jana Build <jana.build@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm: remove "simple-bus" for anatop
Message-ID: <20191204112700.GG3365@dragon>
References: <20191107103332.16485-1-chen.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107103332.16485-1-chen.fang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:35:26AM +0000, Fancy Fang wrote:
> Remove "simple-bus" compatible for device anatop,
> since no child nodes exist under it and it is not
> a populated bus.
> 
> Signed-off-by: Fancy Fang <chen.fang@nxp.com>

Applied both, thanks.
