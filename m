Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96323C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4AD21873
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfCaGlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:03 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:48962 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726905AbfCaGlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 37097100E86C2;
        Sun, 31 Mar 2019 06:41:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sheep33_42bb214506e16
X-Filterd-Recvd-Size: 1879
Received: from XPS-9350 (unknown [172.58.35.144])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun, 31 Mar 2019 06:40:58 +0000 (UTC)
Message-ID: <8b6afee25fe6d2248353015fe2303d793b2a1d49.camel@perches.com>
Subject: Re: [greybus-dev] [PATCH] Staging: greybus: usb: Fixed a coding
 style error
From:   Joe Perches <joe@perches.com>
To:     Alex Elder <elder@linaro.org>,
        Will Cunningham <wjcunningham7@gmail.com>, johan@kernel.org
Cc:     devel@driverdev.osuosl.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Date:   Sat, 30 Mar 2019 23:40:28 -0700
In-Reply-To: <5c95c177-b8fe-ab0b-eb7a-d270e35a7ce6@linaro.org>
References: <20190331053040.GA12974@titus.pi.local>
         <41750e16d14a967529d7cb5e315110ee5ccd313c.camel@perches.com>
         <5c95c177-b8fe-ab0b-eb7a-d270e35a7ce6@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-03-31 at 01:20 -0500, Alex Elder wrote:
> On 3/31/19 1:04 AM, Joe Perches wrote:
> > Blind adherence to 80 column limits leads to poor looking
> > code.  Especially with longish identifier lengths.
> I agree.  If it were me, I'd use a local variable.  For example:
> 
> 	struct greybus_descriptor_cport *cport_desc = gbphy_dev->cport_desc;
> 	...
> 	connection = gb_connection_create(gbphy_dev->bundle,
> 					  le16_to_cpu(cport_desc->id), NULL);
> 
> Or maybe better:
> 
> 	u16 cport_id = le16_to_cpu(gbphy_dev->cport_desc->id);
> 	...
> 	connection = gb_connection_create(gbphy_dev->bundle, cport_id, NULL);

True.

A possible negative though:

Temporaries that are only used once are sometimes
less readable as the declaration is supposed to be
done at an open brace and that could be relatively
far away from the set and use.

