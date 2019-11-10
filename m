Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B76DC17442
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 11:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209BB20B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 11:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573385982;
	bh=SAo6Y0zyaI4H4yeBlaypq/MPnAbAVbFLYUWmkZ0d1Hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IeS4jZ4eABwvKj2EAI2To1NlurkMLTvzONdXhPy00Pc3mcY6iIxCsrpNqwytwdT39
	 pjjLS7vd6Sj6lbkZRoZ62/aNpXelxZCfXmVfSzZwrByxAYOm7RfWIy7dH+R9m+f0WO
	 f2Ndalt/nH5FKF0z9ADmuzJD9wP0YFNHm7705blw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfKJLjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 06:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfKJLjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 06:39:40 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7794620818;
        Sun, 10 Nov 2019 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573385980;
        bh=SAo6Y0zyaI4H4yeBlaypq/MPnAbAVbFLYUWmkZ0d1Hk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gZn+jbKMcp9bKsFtkZtmQHdpylOIdujHTU3ZJ6KapBPptVTPoqNED2t0T/STC6NDV
         HEuqJjYfex4OvETYvBMgTQQdPu/ZWhD8lLCE7phZGBW/AKm4lJBVhBH+D/TMOOWMh1
         bLb1rQ03BY6GYY7LZjcB3//KIJXOVIYwsMTfXKbw=
Date:   Sun, 10 Nov 2019 11:39:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kent Gustavsson <kent@minoris.se>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: dac: Migrate LTC1660 documentation
 to yaml
Message-ID: <20191110113933.4a577a9e@archlinux>
In-Reply-To: <20191108073929.GA3844@gmail.com>
References: <20191108072539.3547-1-marcus.folkesson@gmail.com>
        <20191108073929.GA3844@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019 08:39:29 +0100
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> On Fri, Nov 08, 2019 at 08:25:39AM +0100, Marcus Folkesson wrote:
> > Rewrite bindings to use json-schema vocabulary.
> > 
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>  
> 
> Forgot Robs tag from v2
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing

Thanks,

Jonathan

