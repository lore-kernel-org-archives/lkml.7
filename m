Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1139DC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60CA243AA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559651436;
	bh=IQ7Kg2HzTQ2nVL1MNKgIUyZrLVCbPoVX2ISWMBIj8I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1EdGcl0mh2rWJRNn4dV7CS7ZTZQ3kXjS66n1mDBfdmL6ZHsi7NkEenUM/drJIKgEp
	 n4OdTqfo2MJyPYXZhd18ISRjkssPE4JLZK+dGmAYq6zthuLnMxtW0DUDYx8ke+cCUa
	 3wMOTRB+IfKsq6wd43VVHrUXzx3NvuHM89OwJ5RY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfFDMaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfFDMae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:30:34 -0400
Received: from localhost (unknown [117.99.94.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7020123E30;
        Tue,  4 Jun 2019 12:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559651434;
        bh=IQ7Kg2HzTQ2nVL1MNKgIUyZrLVCbPoVX2ISWMBIj8I4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RByXCAjz6MKy9XaPkoAfY3JJSv/jA5nGvo7B0u1EPB4yqokCcdbqMPQgCfP9vt5jx
         JYcJn785U/G5uDbglaMLhEAynzdMGuZalesc6mQ6vHUBYdVK54EKOXcYKSubBEMRkb
         hA6TfYhxo9kFwbD+piVbfM8B/lCCh3uw7NuxFVd4=
Date:   Tue, 4 Jun 2019 17:57:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/7] dt-bindings: arm64: allwinner: h6: Add binding
 for DMA controller
Message-ID: <20190604122726.GZ15118@vkoul-mobl>
References: <20190527201459.20130-1-peron.clem@gmail.com>
 <20190527201459.20130-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190527201459.20130-2-peron.clem@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-05-19, 22:14, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> DMA in H6 is similar to other DMA controller, except it is first which
> supports more than 32 request sources and has 16 channels. It also needs
> additional clock to be enabled.
> 

Applied, thanks

-- 
~Vinod
