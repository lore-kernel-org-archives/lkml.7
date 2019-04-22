Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB122C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 01:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8281021741
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 01:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555894954;
	bh=jt1+PPDU4te4UfMgcBe22ILWLeGs76X+pCWjoI1Lk4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kf1LkiAIFKdPcIoeesKzFJ/Xzy5Siozykq83T2TYj6sEyIlb99RKQTstvFwgDzci3
	 KKfa5k0aXF/7h5dQhD8dxzci/Qdq3J1QPHSVxF8KQb6LGGR0FPrCr6H5J0Rp9xPXEI
	 sJBMK0Bd0Q7h3aUsfbDa/PIndiXypSahVYIaCpJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfDVBCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 21:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfDVBCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 21:02:33 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1E4C20859;
        Mon, 22 Apr 2019 01:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555894952;
        bh=jt1+PPDU4te4UfMgcBe22ILWLeGs76X+pCWjoI1Lk4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ecb+ED0rhFcJjmsmJG2BXPgb3SC6QChkrF/fHqv0+JDSmtTmM6xQTcp5n8FPhd0wS
         rdVPllG3ypX/6UN+KhP1eu4z6XjebG9sVehI3qPUmloAyvKlEkuB7nMWpC+GoATruS
         jmsJBoMB/8VANjWV0tNuqAor4YBcuWXsI2izylHs=
Date:   Mon, 22 Apr 2019 09:02:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: arm: fsl: Add support for ZII i.MX7
 RPU2 board
Message-ID: <20190422010217.GK19962@dragon>
References: <20190414183403.21538-1-andrew.smirnov@gmail.com>
 <20190414183403.21538-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414183403.21538-3-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 11:34:02AM -0700, Andrey Smirnov wrote:
> Add support for ZII i.MX7 RPU2 board.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org

Applied, thanks.
