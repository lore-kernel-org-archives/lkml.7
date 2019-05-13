Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4BBC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D66D208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfEMV5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:57:49 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:56307 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726413AbfEMV5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:57:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 513FB1802912A;
        Mon, 13 May 2019 21:57:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tramp93_6119a0acc5355
X-Filterd-Recvd-Size: 1656
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 May 2019 21:57:47 +0000 (UTC)
Message-ID: <ffbff01f239ec468af0b591638e019f3f8fc990e.camel@perches.com>
Subject: Re: [PATCH 1/2] firmware: bcm47xx_nvram: Correct size_t printf
 format
From:   Joe Perches <joe@perches.com>
To:     Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org
Cc:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 13 May 2019 14:57:45 -0700
In-Reply-To: <20190513215250.19246-1-f.fainelli@gmail.com>
References: <20190513215250.19246-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-13 at 14:52 -0700, Florian Fainelli wrote:
> When building on a 64-bit host, we will get warnings like those:
> 
> drivers/firmware/broadcom/bcm47xx_nvram.c:103:3: note: in expansion of macro 'pr_err'
>    pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
>    ^~~~~~
> drivers/firmware/broadcom/bcm47xx_nvram.c:103:28: note: format string is defined here
>    pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
>                            ~^
>                            %li
> 
> Use %zi instead for that purpose.

typically it is %zu


