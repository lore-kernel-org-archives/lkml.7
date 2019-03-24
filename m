Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA21FC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE40921741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfCXSB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:01:28 -0400
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:40674 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbfCXSB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:01:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E1AE8182CED34;
        Sun, 24 Mar 2019 18:01:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: note32_4662ac32e7323
X-Filterd-Recvd-Size: 1575
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun, 24 Mar 2019 18:01:23 +0000 (UTC)
Message-ID: <e922a949de93202ac4b4c9d0548fd288efbad2c1.camel@perches.com>
Subject: Re: [PATCH v5 2/2] staging: iio: ad5933: move out of staging
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, michael.hennerich@analog.com,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Date:   Sun, 24 Mar 2019 11:01:22 -0700
In-Reply-To: <20190324163828.1acf5945@archlinux>
References: <cover.1553192834.git.marcelo.schmitt1@gmail.com>
         <b1f96765c209f710145e255347867b618a54058c.1553192834.git.marcelo.schmitt1@gmail.com>
         <20190324163828.1acf5945@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-03-24 at 16:38 +0000, Jonathan Cameron wrote:
> > diff --git a/drivers/iio/impedance-analyzer/ad5933.c b/drivers/iio/impedance-analyzer/ad5933.c

trivial note:

> > +static void ad5933_calc_out_ranges(struct ad5933_state *st)
> > +{
> > +	int i;
> > +	unsigned int normalized_3v3[4] = {1980, 198, 383, 970};

This could be static const which would make the code smaller.


