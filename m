Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23CCC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9288A223BB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563869591;
	bh=2VQD8E3BQRFxU0aFYHoYFzatw2/v99XN1lAqSVTFEhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sM5MB12dNj9aLgDL3/4ptbZXYVRrsy/KXKVW0oQACh8NS3vUmfYJCk4hqCPZhdfwj
	 V4ybZz3hNvtq1vkwDrvvLzejby3SKYXxGn+RkCHhH+R/8sA6LyfRRc5Xybuu+lLTgG
	 t4H3Dt7k0HqLkb1+ByHEAHto0g0lhJsLNleAkD1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfGWINK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730388AbfGWINJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:13:09 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D16E20449;
        Tue, 23 Jul 2019 08:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563869588;
        bh=2VQD8E3BQRFxU0aFYHoYFzatw2/v99XN1lAqSVTFEhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joDbOl5qJndFN0VSg9xkOUJT8aqznNMA5YvWZzyR3fMYuS3MjYUGlZt4Q/CPBUcnp
         AtoNw3zqSkEhjmT74eQTHjsILGITnfmsdCOjQ6CoMVa487Njwd9LZd1A6ShtQh9Uf3
         zUepVf8FJcpNQlDmeGzluLX6lsfkjjnv52Yf2Uks=
Date:   Tue, 23 Jul 2019 16:12:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wen He <wen.he_1@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, liviu.dudau@arm.com, robh+dt@kernel.org,
        leoyang.li@nxp.com
Subject: Re: [v2 3/3] dts: arm64: ls1028a: Add optional property node for
 Mali DP500
Message-ID: <20190723081238.GQ15632@dragon>
References: <20190719095956.11774-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719095956.11774-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 05:59:56PM +0800, Wen He wrote:
> This patch use the optional property node "arm,malidp-arqos-value" to
> can be dynamic configure QoS signaling.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>

Applied, thanks.
