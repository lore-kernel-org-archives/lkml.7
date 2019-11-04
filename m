Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886B9CA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F46821D7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572830824;
	bh=Hw+hwKVQUsNdBF/kcpsFusDQL/5LzDx1ZI16h1Gs/0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IQxfX+blpCOyoKDwpmhMoNxPx4STn2eOK/A/7UkhtRSLvm9Kdz4W6q+VIml/QOgsd
	 nnDpYuePGv1TPJe4GdAvysqvrtcqs0JIIQacqnev2D4r5MJjCFMRophC9DjqT/yEdk
	 nAhiH0T11TeR74hrFQ3/nCRXWhG/ptGq12+5UQFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfKDB1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbfKDB1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:27:02 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77A0E214D9;
        Mon,  4 Nov 2019 01:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572830822;
        bh=Hw+hwKVQUsNdBF/kcpsFusDQL/5LzDx1ZI16h1Gs/0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cEnEO8WQAZ1Ps68a5ITLLen2o72C1yvGJTn2nnSHDdSqGyRpmbx0Kd/MGtqLtVEFF
         NerVOI+g+07CxlCqdxnpy5kwi7bZQKx1Le/MS0w+DBqvf34zxDwB/acsG/F3NPhmMx
         Qz7WCHXnfy7hdoTh31OY4TnBgYFlQUyevEme3DE8=
Date:   Mon, 4 Nov 2019 09:26:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-imx@nxp.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5] dt-bindings: arm: fsl: add nxp based toradex
 colibri-imx8x binding docu
Message-ID: <20191104012635.GH24620@dragon>
References: <20191026090403.3057-1-marcel@ziswiler.com>
 <20191026090403.3057-5-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026090403.3057-5-marcel@ziswiler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 11:04:03AM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Document the NXP SoC based Toradex Colibri iMX8X module and carrier
> board devicetree bindings previously added.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

I changed subject a little bit as below.

  dt-bindings: arm: fsl: add nxp based toradex colibri-imx8x bindings

Shawn
