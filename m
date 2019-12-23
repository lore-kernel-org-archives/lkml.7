Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8638C2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8098A207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577084122;
	bh=39ehGZ6TuL922vgrdz2h/bRu6TOJa3ZY3hJJ2N9KD9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mtDfy82YnnWwuuW/WkPsVYumf+FihnDhR4QuoK/5269Mrq/ns+Yu0Gvk57MgaFDHv
	 l/c3jMHFSFQ2O3wG2Gxen4EWX9sQ98KEjCfuvAvuwteUf6rPiYv0WYxBovYGnWTUFz
	 H9ua1E+Dlv6zkZfuFnZApf7sAthFmyBt6EroWY2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLWGzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 01:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLWGzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:55:21 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9620B20663;
        Mon, 23 Dec 2019 06:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577084120;
        bh=39ehGZ6TuL922vgrdz2h/bRu6TOJa3ZY3hJJ2N9KD9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HW+GJS5OxSVhugdZ53LcIsfKTacGVpg6i8VPohFdkaXvBTZZ5Gft/aTeytg9wPTQw
         qC0xltbypWCL5MPPInkZw5WdA/K0miyj1St6t+XwQyHSW9o//mvtbP81SnAKQ5LA1W
         okYlXQFuzM2+Zuu5b/dE0xSVXprh64vRDs1D4FmA=
Date:   Mon, 23 Dec 2019 14:54:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, xiaobo.xie@nxp.com,
        jiafei.pan@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: ls1028a: fix little-big endian issue
 for dcfg
Message-ID: <20191223065458.GO11523@dragon>
References: <20191213021839.23517-1-yinbo.zhu@nxp.com>
 <20191213021839.23517-2-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213021839.23517-2-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 10:18:39AM +0800, Yinbo Zhu wrote:
> dcfg use little endian that SoC register value will be correct
> 
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> Acked-by: Yangbo Lu <yangbo.lu@nxp.com>

I reworded the subject and commit log a little, added Fixes tag and
applied a fix.

    arm64: dts: ls1028a: fix endian setting for dcfg
    
    DCFG block uses little endian.  Fix it so that register access becomes
    correct.
    
    Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
    Acked-by: Yangbo Lu <yangbo.lu@nxp.com>
    Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>
