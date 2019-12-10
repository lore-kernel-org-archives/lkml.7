Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401DBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDBE20828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575979285;
	bh=rjM38HyV7X4Jc0xazOMgdtH5goM5XesQuqArDXIboDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Caw/+225SgvlFoF9t0QZ7PwJUWAbqb1Z8yVbMdAX+b/WcYW+yyvRcWZm7J2ptM83k
	 FFlkAU3vH7HaAzUgAIC80nUbVCDBQOvilnvugwrWSy9SvsfUJIYST1xVVL0yHh1aQj
	 vehOi13rTaf7CL+Av2y329Bd9zBM4aHHDHYIn6eI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLJMBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:01:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbfLJMBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:01:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3008920726;
        Tue, 10 Dec 2019 12:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575979282;
        bh=rjM38HyV7X4Jc0xazOMgdtH5goM5XesQuqArDXIboDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AXDFjJefm9aQ3sxtR1LKPNgzfZluVJFkzzSwO8ik6SniAiDJNQnRPKVZx9SItAVpp
         3WA9ypIGTiEkvIx/sEW0i4hd0MkC8DsAzpiyUCRI2JgA5HUctbDj6/0XxPsRAu1cR5
         2bE/oLO+8h3LKlD2oxD23hIFPxCMS3maLun0JeWI=
Date:   Tue, 10 Dec 2019 13:01:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sandro Volery <sandro@volery.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        David Daney <ddaney@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Florian Westphal <fw@strlen.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Branden Bonaby <brandonbonaby94@gmail.com>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        Paul Burton <paulburton@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Giovanni Gherdovich <bobdc9664@seznam.cz>,
        Valery Ivanov <ivalery111@gmail.com>
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
Message-ID: <20191210120120.GA3779155@kroah.com>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <EFBFCF4B-745B-4B1B-A176-08CE8CADBFEA@volery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EFBFCF4B-745B-4B1B-A176-08CE8CADBFEA@volery.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 12:40:54PM +0100, Sandro Volery wrote:
> Doesn't octeon have drivers out of staging already?
> What is this module for?

I have no idea :(

