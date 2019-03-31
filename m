Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D451CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62512146F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfCaGFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:05:33 -0400
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:37421 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725832AbfCaGFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:05:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 447D91800A012;
        Sun, 31 Mar 2019 06:05:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: beast00_3006f2d16eb3f
X-Filterd-Recvd-Size: 1814
Received: from XPS-9350 (unknown [172.58.35.144])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sun, 31 Mar 2019 06:05:29 +0000 (UTC)
Message-ID: <41750e16d14a967529d7cb5e315110ee5ccd313c.camel@perches.com>
Subject: Re: [PATCH] Staging: greybus: usb: Fixed a coding style error
From:   Joe Perches <joe@perches.com>
To:     Will Cunningham <wjcunningham7@gmail.com>, johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 30 Mar 2019 23:04:59 -0700
In-Reply-To: <20190331053040.GA12974@titus.pi.local>
References: <20190331053040.GA12974@titus.pi.local>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-03-31 at 01:30 -0400, Will Cunningham wrote:
> Line was >80 characters.
[]
> diff --git a/drivers/staging/greybus/usb.c b/drivers/staging/greybus/usb.c
[]
> @@ -169,8 +169,8 @@ static int gb_usb_probe(struct gbphy_device *gbphy_dev,
>  		return -ENOMEM;
>  
>  	connection = gb_connection_create(gbphy_dev->bundle,
> -					  le16_to_cpu(gbphy_dev->cport_desc->id),
> -					  NULL);
> +				le16_to_cpu(gbphy_dev->cport_desc->id),
> +				NULL);

Blind adherence to 80 column limits leads to poor looking
code.  Especially with longish identifier lengths.

Another way to do this, which is not necessarily actually
better is to position the left side of the assignment on a
separate line like:

	connection =
		 gb_connection_create(gbphy_dev->bundle,
				      le16_to_cpu(gbphy_dev->cport_desc->id),

Is that better?  <shrug>  I prefer the original.
It was better before as it was aligned to open parenthesis.


