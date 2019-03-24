Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52E8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9342082F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553458397;
	bh=IslnaD65RHmr0roZTq8R3PgpTKFF4Rz4ghX1fNEHS44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Fulbuk8pD56442OEdJoaV8yaKGovUavJzslDgM5tuCBBl0YEAcKsC3/uspz9+JK7
	 QpP13dVB6Jk6gPMmrcVoil+UstrMlMR5h85dx12WT+aQ86VBrEuAtU7nJ83ff6Wdjb
	 vl0b1dLBb3ovp/f5XmWJSkCqwZsFSF4qvzClgMYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfCXUNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 16:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCXUNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 16:13:16 -0400
Received: from localhost (unknown [88.128.80.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 536AF2082F;
        Sun, 24 Mar 2019 20:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553458395;
        bh=IslnaD65RHmr0roZTq8R3PgpTKFF4Rz4ghX1fNEHS44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACbMUqREtRlWSq64JD6vTLe+7gHezaKr6/6DsWSJwoCKxs2nNKelL/u5BADQmX6hX
         P2FYP/RFECjFCa4wiYDXSiqRmYjr8bF/jtn3a723Rcp2t7ABvdkp1t9Midq0DEbFpo
         uMR9VyqZsFkYIt0HAgqIPqkBPvhU1Ao2iVs8IhEQ=
Date:   Sun, 24 Mar 2019 20:57:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     ojaswin <ojaswin25111998@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging: fix styling of the comment related to
 SPDX-License-Identifier in vt6656/*.h
Message-ID: <20190324195714.GA8262@kroah.com>
References: <1553449747-25704-1-git-send-email-ojaswin25111998@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553449747-25704-1-git-send-email-ojaswin25111998@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 11:17:22PM +0530, ojaswin wrote:
> Fix checkpatch.pl styling error related to SPDX-License-Identifier comment 
> in vt6656/*.h
> 
> Signed-off-by: ojaswin <ojaswin25111998@gmail.com>

We need a "real name" here, please see the kernel documentation about
this for the details.

thanks,

greg k-h
