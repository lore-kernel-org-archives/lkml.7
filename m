Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34879C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032D421916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553193975;
	bh=+gypyK+Akc38XRbcSydE0cicK10pRvotHQMxgGwqkTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cUYpuumOdZoOIqNFxaDqF5we4MirxSbkbPx6uv2mEzBZ6Z7sVu8Rzqy6bfjgIbfod
	 enigTjbbFrgMa2aMFwH4NS+xxc/UfSN5gegRXJoQ36BGGbkbBvlZ50Lb83+s3HOM27
	 qXcKZ98B9sPPsEBiToDHJtM6+ZhbEIV2GIrGu18o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfCUSqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:46:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbfCUSqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:46:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AD26218D8;
        Thu, 21 Mar 2019 18:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553193972;
        bh=+gypyK+Akc38XRbcSydE0cicK10pRvotHQMxgGwqkTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zbcXHlCG+8ovhLsMQgO+5VdPgakrihURqKTP2rAgvcTk+NPFUrmsPPYt+PHIduz/F
         ZX5b2WVz9PdbyQIvNn+0l2bQTWddPqC6ESFMFAknnDW1PvkyVkod0B455W+2kwBzNi
         bT+Ci4XGGrzDZRxw51UP3X7c1bX1CofoH3J6igXE=
Date:   Thu, 21 Mar 2019 19:46:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     christian@lkamp.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ralink-gdma: Prefer u32 over uint32_t
Message-ID: <20190321184609.GB16785@kroah.com>
References: <20190321183710.GA8472@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321183710.GA8472@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 12:07:10AM +0530, Bharath Vedartham wrote:
> Change uint32_t to u32

That says _what_ you did, but _why_ are you doing this?  That's the main
content a changelog text should have in it.

thanks,

greg k-h
