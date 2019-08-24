Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829B8C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB8A23401
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566679588;
	bh=yZMM3l308/2lqQFht7ckfNZ8LSwL8s2Dgv+0qdHJC0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DZF2dX3HaF6W96B7cMXAKqD7Qa13q/ZRuSt6ZCVN0FNwBS3v+P8zmJl6fJZvjkzKZ
	 FOerqRl5pQ3l7+OCA2/7ZbN98RYpn84m0Nl8Qw4YqonZskNhPtN74KUabKhVWeE8Fa
	 qUs4uLsqO0s7FgNU4DCl4HfV0ZltWICHicuUj54Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfHXUqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 16:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfHXUqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:46:25 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5176323400;
        Sat, 24 Aug 2019 20:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566679584;
        bh=yZMM3l308/2lqQFht7ckfNZ8LSwL8s2Dgv+0qdHJC0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2rtEB2YMmpIYVgLsAtzygziEHICBpBa5ERig+771E0NZDfRpB1uOqbqPeujMfAXM
         61LjpTP6lfAaUamQwUfebLy8bpbZa1EZVIw07q1xJEts1KXTQoKL1IwmDRGYjEnCxZ
         iBcdQvx+YxXv5AIxIYUSkm8qRBVY3kfKQ5YALayc=
Date:   Sat, 24 Aug 2019 22:46:12 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 1/4] dt-bindings: vendor-prefixes: Add Anvo-Systems
Message-ID: <20190824204611.GL16308@X250.getinternet.no>
References: <20190822060238.3887-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822060238.3887-1-krzk@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 08:02:35AM +0200, Krzysztof Kozlowski wrote:
> Add vendor prefix for Anvo-Systems Dresden GmbH.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied all, thanks.
