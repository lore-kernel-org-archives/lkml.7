Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0D6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C26D2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfKSRPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:15:02 -0500
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:42586 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726985AbfKSRPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:15:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B6DE8182CED2A;
        Tue, 19 Nov 2019 17:15:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hose89_65b5758ac5c31
X-Filterd-Recvd-Size: 2134
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 Nov 2019 17:14:58 +0000 (UTC)
Message-ID: <64ace55545c028bc39b08370074aafd32e8fc5f5.camel@perches.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Switch to Marvell addresses
From:   Joe Perches <joe@perches.com>
To:     Robert Richter <rrichter@marvell.com>,
        Arnd Bergmann <arnd@arndb.de>, arm soc <arm@kernel.org>
Cc:     Jan Glauber <jglauber@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Nov 2019 09:14:36 -0800
In-Reply-To: <20191119165549.14570-4-rrichter@marvell.com>
References: <20191119165549.14570-1-rrichter@marvell.com>
         <20191119165549.14570-4-rrichter@marvell.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-19 at 16:56 +0000, Robert Richter wrote:
> Switch all addresses from @cavium.com to @marvell.com.
> 
> On that occasion, switching also to my Marvell address for all my
> Cavium/Marvell entries.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -3727,14 +3727,14 @@ S:	Supported
>  F:	drivers/mmc/host/cavium*
>  
>  CAVIUM OCTEON-TX CRYPTO DRIVER
> -M:	George Cherian <george.cherian@cavium.com>
> +M:	George Cherian <gcherian@marvell.com>
>  L:	linux-crypto@vger.kernel.org
>  W:	http://www.cavium.com

Might want to change these W: links too

> @@ -17911,7 +17911,7 @@ S:	Supported
>  F:	drivers/char/xillybus/
>  
>  XLP9XX I2C DRIVER
> -M:	George Cherian <george.cherian@cavium.com>
> +M:	George Cherian <gcherian@marvell.com>
>  L:	linux-i2c@vger.kernel.org
>  W:	http://www.cavium.com

etc...

>  S:	Supported

