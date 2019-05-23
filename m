Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6C9C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019CA21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558601649;
	bh=JbDM8FwHo1HybCGoYonzmVnotF3j/4CKLTn/H6y5uKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q9QJafSW6Cif/Q+PIePU/YhvpbvPZ9buPUgiQ6z+xoSt3/oigF3G+hxmcxya79q7S
	 Ben3F9bIMq4Jscplx/5oF3ZGhypTPEsLPcU1VZAFmQGSOqftadnUWkyGvlzCfC5XPd
	 hDATiVqpJgH30KDFcixQRJ+4pRP7gmgYh/zTANmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfEWIyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:54:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfEWIyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:54:08 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 167402075E;
        Thu, 23 May 2019 08:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558601647;
        bh=JbDM8FwHo1HybCGoYonzmVnotF3j/4CKLTn/H6y5uKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uVlYz6CNnSq1BnpwFzgECTGlr0+MHZBp5av8sgTXxLHNojhV7AhV1I61FTP3Le5Rp
         bdBMKwDdgv2HHTMRqzfmeewRrJr73rjBfP/+ahkGO9/0ZX58bXx4Ak8Lewx4mL4PNO
         4s6KHoy9QjJDLuw/HMR0cQif03XuBhw3M5Bfn00M=
Date:   Thu, 23 May 2019 16:53:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: ls1028a: Add USB dt nodes
Message-ID: <20190523085306.GQ9261@dragon>
References: <20190517051624.4930-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517051624.4930-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 01:16:24PM +0800, Ran Wang wrote:
> This patch adds USB dt nodes for LS1028A.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

Applied, thanks.
