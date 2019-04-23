Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9E3C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A84206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555984402;
	bh=yYlBk54eT0POhrQ8h6mFEp9+Wa3/jKrja28Tv5ZBbVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ay7JvS3VVEJvYLbYieUaC3vR6hiz3Y9HxwN+Pt3sfC06BzsdxFJ1uUnYY+AibqUMB
	 S0m+3pGtbhQATBsOHqO1AsjRCpEEc2CisEm/lNhR37kb+OrNdcj/HHrQR/iFpw+Jfy
	 qSoCIRatsV3XVWZu5DDcNFXTsXX5ZRvn72MpuBkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfDWBxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 21:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbfDWBxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 21:53:19 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B67206BA;
        Tue, 23 Apr 2019 01:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555984399;
        bh=yYlBk54eT0POhrQ8h6mFEp9+Wa3/jKrja28Tv5ZBbVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSEyuIF+t87Ire3hDVpDPYPIF1+PKxBm9jc9044wsJbHD5M6dvh1GO842mS1qnagZ
         T9GaOywnFFjsHSlBT2qHHnrPXIPllkdnGHK9d9Nc0hQWVP+V6HU3Zk7nrw9Iycr4+b
         u/6y2REvSmNC4U3+bOkS4DleZeLfv38aWlAjCJVM=
Date:   Tue, 23 Apr 2019 09:53:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] ARM: dts: imx7s: Specify #io-channel-cells in ADC
 nodes
Message-ID: <20190423015300.GB16166@dragon>
References: <20190414183403.21538-1-andrew.smirnov@gmail.com>
 <20190414183403.21538-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414183403.21538-2-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 11:34:01AM -0700, Andrey Smirnov wrote:
> Specify #io-channel-cells in ADC nodes. Needed to be able to reference
> them by phandle.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org

Applied, thanks.
