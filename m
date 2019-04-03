Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49F5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B0A20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="B5pjlfSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDCJVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:21:30 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35663 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDCJVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:21:30 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 993B125BDFF;
        Wed,  3 Apr 2019 20:21:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1554283287; bh=DjBhL35uraJalSLq4/QUjCgnyxfuVnEhAuQauQTDEhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5pjlfSgoJob0QHRzaotu8jrGVQIjOoV3iXua9TFC+MTDdX2vP0yAckRGWpXN0WwR
         HqV08ecO/kSbArpFrxNiId7ytbtqmwGdwGHgjti5VS2GLBsUlNK5awCpqlDRPYlTcv
         URj94ilh5lTx0NXrpO08uD6upQbk7sOjOlkzvf+4=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id B0C05940361; Wed,  3 Apr 2019 11:21:25 +0200 (CEST)
Date:   Wed, 3 Apr 2019 11:21:25 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/3] phy: renesas: rcar-gen3-usb2: Use pdev's device
 pointer on dev_vdbg()
Message-ID: <20190403092124.3bs2pbgboqp33jvm@verge.net.au>
References: <1554120083-29990-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1554120083-29990-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554120083-29990-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 09:01:22PM +0900, Yoshihiro Shimoda wrote:
> To implement multiple phy instances in the future, this patch uses
> pdev's device pointer on dev_vdbg() instead of the phy's device
> pointer.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

LGTM

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

