Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A8EC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCB32086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388926AbfFJS7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:59:53 -0400
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:42730 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388544AbfFJS7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:59:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A2533181D33FB;
        Mon, 10 Jun 2019 18:59:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: beef60_1ba01763c0b04
X-Filterd-Recvd-Size: 1885
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Jun 2019 18:59:49 +0000 (UTC)
Message-ID: <4491ae98b10f4519874141eb39cd2f0b5491b3a5.camel@perches.com>
Subject: Re: [PATCH V5 11/11] MAINTAINERS: add maintainer for SD-FEC
From:   Joe Perches <joe@perches.com>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Date:   Mon, 10 Jun 2019 11:59:48 -0700
In-Reply-To: <1560038656-380620-12-git-send-email-dragan.cvetic@xilinx.com>
References: <1560038656-380620-1-git-send-email-dragan.cvetic@xilinx.com>
         <1560038656-380620-12-git-send-email-dragan.cvetic@xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-09 at 01:04 +0100, Dragan Cvetic wrote:
> Add maintainer entry for Xilinx SD-FEC driver support.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -17345,6 +17345,17 @@ S:	Supported
>  F:	Documentation/filesystems/xfs.txt
>  F:	fs/xfs/
>  
> +XILINX SD-FEC IP CORES
> +M:	Derek Kiernan <derek.kiernan@xilinx.com>
> +M:	Dragan Cvetic <dragan.cvetic@xilinx.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> +F:	Documentation/misc-devices/xilinx_sdfec.rst
> +F:	drivers/misc/xilinx_sdfec.c
> +F:	drivers/misc/Kconfig
> +F:	drivers/misc/Makefile

I suggest that you do not want to be nor are responsible
for the Kconfig and Makefile just because entries in
those files are associated to xilinx files.



