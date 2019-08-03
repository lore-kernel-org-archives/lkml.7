Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEDFC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 15:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856EF2166E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 15:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564845362;
	bh=BEpL6l+3xiuW/IzVuyU+RrKo0dYWHViZQBu/4eOViPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uq2+Yqw4N4iHlyZ+LHyxk76VfoiU3wojhfk5zVgTdxc72dsfynjCmOK1vBEblTrLJ
	 FMl7/iYKI6n1rRIn7DTRAVRCj0f7URAql7Hpw1N8zuo5Zh9yGkrYgWY5Siht3rqt/6
	 sPtkvUA0ezW3SiRJdbzYzAhGW39awR27Txs8dP0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfHCPQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 11:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfHCPQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 11:16:00 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B912073D;
        Sat,  3 Aug 2019 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564845360;
        bh=BEpL6l+3xiuW/IzVuyU+RrKo0dYWHViZQBu/4eOViPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxpvC7IsJY1oxOl9aW34GdwmdCi/9TD3h8DJ+zYpVvddjomGXnatruz9azzvlFet8
         OQOz3LwIkMbWnolkOASN5g+J3vyZz7dSmGJckO5tDHzDchKMey+lIPmo9KKQOrH87d
         1+c8AwLARAAQb56ABJsx3yxjlOxDRAXGPoVorVOU=
Date:   Sat, 3 Aug 2019 17:15:52 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: defconfig: CONFIG_DRM_ETNAVIV=m
Message-ID: <20190803151551.GR8870@X250.getinternet.no>
References: <20190802122102.3932-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802122102.3932-1-christian.gmeiner@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 02:20:28PM +0200, Christian Gmeiner wrote:
> For imx8 we want to enable etnaviv, let's enable it
> in defconfig, it will be useful to have it enabled for KernelCI
> boot and runtime testing.
> 
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>

Applied, thanks.
