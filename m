Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F289C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465E923F50
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559651521;
	bh=smPFn3xTaQlOwxDv+rvChZ8BjQgGMLXVICl/qcx1NEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MLv1RH6aWvCyIVM5fe5mm6tZU98mgjBgPhmzBLGYZVA+Rwq7ZbdT2ImpLqqxqWkvD
	 8SXuO3uMOIlhOG6c1xeb//mNDnHBFOuzu5LEFythIEl38FSn60Zd8KR9I27PeGk/ss
	 /Sp5Cd/3am2cOPvVyk5QjjS8Cf8HOhI/LiMo1Go4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfFDMcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfFDMcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:32:00 -0400
Received: from localhost (unknown [117.99.94.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A36F623E30;
        Tue,  4 Jun 2019 12:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559651519;
        bh=smPFn3xTaQlOwxDv+rvChZ8BjQgGMLXVICl/qcx1NEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHiRxdNqwSAHp7BKsZRtvVGcVXKjpAxTA7yvwUKCV1RP6ptEuIV0iu6u/tVzVCMRp
         ATzEbgEDA5Ri2oXQ3ioYeCZ/NUsy1U2bIF2uGCaOr5xpl6QNNjOxc+/loysi8LWV5b
         6ZIB40FX6+n+YWYTe0sZDvX62FPAGHaUh8m3gAYA=
Date:   Tue, 4 Jun 2019 17:58:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v3 5/7] dmaengine: sun6i: Add support for H6 DMA
Message-ID: <20190604122851.GD15118@vkoul-mobl>
References: <20190527201459.20130-1-peron.clem@gmail.com>
 <20190527201459.20130-6-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190527201459.20130-6-peron.clem@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-05-19, 22:14, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 DMA has more than 32 supported DRQs, which means that configuration
> register is slightly rearranged. It also needs additional clock to be
> enabled.
> 
> Add support for it.

Applied, thanks

-- 
~Vinod
