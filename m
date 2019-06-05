Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE97C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F39120874
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559715524;
	bh=MSV/rGzBVTZxIWJspsr0g5i+nW0XZGAzFdtujk9ds4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c3QtoK1BkyiI8PDpkKIClt+cuaqEqWawqs0Pj8ZW8t/wYfBnffvkqDbEZLmGzLAQG
	 Bx+z7PUHm4yI7tRiDXbsjUoW0oO6qBiiLU1Xwe2GY0uLPDDmT7UIYeMO3aqzU3Lu+n
	 +gjdHMZp3F5fqDNTWiYEfloeIcBPPHwsfQ0PHA9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfFEGSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfFEGSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:18:43 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317C0206BA;
        Wed,  5 Jun 2019 06:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559715522;
        bh=MSV/rGzBVTZxIWJspsr0g5i+nW0XZGAzFdtujk9ds4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VjS1UvQCfrsxwpe/wmB0X+D7gqfthNMQYKRQv0P/B2WstrCv5+A557HhdzD2+cyxa
         Sb2lNU9CcNTaynzsUBmRLzITWkypYyY84HrlXtF/5mgHSL+lcicrV/PvON9yVqy4CW
         h32x655vtOJeZ+AboDSDEQ6hfeUv4Js8z2UhJkl8=
Date:   Wed, 5 Jun 2019 14:18:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls1028a: Enable sata.
Message-ID: <20190605061825.GE29853@dragon>
References: <20190524073022.32174-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524073022.32174-1-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 03:30:22PM +0800, Peng Ma wrote:
> Change the sata node to enable sata.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>

Applied, thanks.
