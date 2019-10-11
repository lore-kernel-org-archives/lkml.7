Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED074ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68EA21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vspBJqWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfJKMZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:25:51 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59818 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfJKMZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:25:50 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9BCPfVt067140;
        Fri, 11 Oct 2019 07:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570796741;
        bh=HpS8+JtsrSkPNqh+2hbehEID2iehq7ANLODOvnBMIjE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vspBJqWTpDOHWWCpZNWi+3SdbINO7ZjNMWy6k3B8y0sWRNzOIVfaGIulpjKIiFs6V
         XcXHysl2Nw6hQMBICMsenuzPoYBq5vgYHLq/VcyZQ+36ecnn/9uA1o7c0l3U/3iDAh
         TREx/afjgZMguKsEndScG9B8x434xWuL4xZS+flI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9BCPfO5029425;
        Fri, 11 Oct 2019 07:25:41 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 11
 Oct 2019 07:25:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 11 Oct 2019 07:25:37 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with SMTP id x9BCPf2t030553;
        Fri, 11 Oct 2019 07:25:41 -0500
Date:   Fri, 11 Oct 2019 07:28:17 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: linux-next: Fixes tag needs some work in the v4l-dvb tree
Message-ID: <20191011122817.dlqlmayxlvghuphq@ti.com>
References: <20191011074702.1ebb98a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191011074702.1ebb98a7@canb.auug.org.au>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote on Fri [2019-Oct-11 07:47:02 +1100]:
> Hi all,
> 
> In commit
> 
>   e20b248051ca ("media: ti-vpe: vpe: Make sure YUYV is set as default format")
> 
> Fixes tag
> 
>   Fixes: 40cc823f7005 ("media: ti-vpe: Add support for NV21 format")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Did you mean
> 
> Fixes: b2bb3d822f2c ("media: ti-vpe: Add support for NV21 format")

Ah, yes.
This was obviously missed through the rebase, sorry.

Benoit

> 
> -- 
> Cheers,
> Stephen Rothwell


