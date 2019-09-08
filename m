Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5731EC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3165E21479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567938555;
	bh=psqnja6Tr2F/VWPHyPCbb2B1np9A5ZDGoR8uGYKZEfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=o7ttKeo/rCpvYKR2YEAbdf8fxSKRtPzfMZCw5Ps0bUOEuUUuKRd5WTxUYTe0QDeC0
	 s/1eWEbNJZX2l5+eSZ/xHD3Vvo87ogHNNzAE9RhV5Xr5hQrnWwRrMAULVvKGdxIbuI
	 dmub0NyTKxyWPWXxNFVgJEEr/GB+IijUJiFZ1dkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfIHK3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 06:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfIHK3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:29:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66933207FC;
        Sun,  8 Sep 2019 10:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567938553;
        bh=psqnja6Tr2F/VWPHyPCbb2B1np9A5ZDGoR8uGYKZEfs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qsLmOXxMhGf4eOjY/uN58da01YQ2X9Hp1uO2BsPOyEZUkDZUkALDmmdo31NYdYjas
         r4FuOdP1i+hBrgk6+0Yy/BRKOoqWdjc6+5BuTemDgfBNqSGQNdQxZIVI6Gthyfw7Uh
         19ydUgcT7HUoMkT5yjZk5WMjJ/1VcrDd54vhzI4Q=
Date:   Sun, 8 Sep 2019 11:29:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mircea Caprioru <mircea.caprioru@analog.com>,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        lars@metafoo.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH V4 4/4] dt-bindings: iio: adc: ad7192: Add binding
 documentation for AD7192
Message-ID: <20190908112907.6d9b8370@archlinux>
In-Reply-To: <20190903172937.GA15494@bogus>
References: <20190902130831.23057-1-mircea.caprioru@analog.com>
        <20190902130831.23057-4-mircea.caprioru@analog.com>
        <20190903172937.GA15494@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2019 18:29:37 +0100
Rob Herring <robh@kernel.org> wrote:

> On Mon, 2 Sep 2019 16:08:31 +0300, Mircea Caprioru wrote:
> > This patch add device tree binding documentation for AD7192 adc in YAML
> > format.
> > 
> > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
It seems that I messed up before and didn't actually revert the v3 patch.

I'll roll a small fix patch to bring the tree inline with this and send out to the
list.

Sorry about this. One of many things that went wrong in that last pull request!

Jonathan

> > ---
> > Changelog V2:
> > - no changes here
> > 
> > Changelog V3:
> > - no changes here
> > 
> > Changelog V4:
> > - remove the const value from avdd and dvdd supply
> > 
> >  .../bindings/iio/adc/adi,ad7192.yaml          | 119 ++++++++++++++++++
> >  1 file changed, 119 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

