Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A5CC2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 18:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C9F20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577124124;
	bh=MLg4g5Ofa/wkZ1A5nGhyBam3JNTaXHswT+qU5Xu90d0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YblcFrLE58uay9vojxqDYw8dHdVCaX6jSicmj8JUvCXaHlqDVb2HQHF756fp29w0m
	 6RmcwYnrdVL5WqF1WQ7+JvbkWlTOliUsF2SIsdz/cxWtSPiAUnvbxrlIXbCKvqRoJq
	 sp5N9KaEd6wjOIdgafjfNzaaV3S6WFP4tnu/8phw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfLWSCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:02:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfLWSCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 13:02:03 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2627420643;
        Mon, 23 Dec 2019 18:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577124122;
        bh=MLg4g5Ofa/wkZ1A5nGhyBam3JNTaXHswT+qU5Xu90d0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DDBWmD15tYJKGCh8E1rW4nr88u8YLoROxnQz5Hv9+/1+xNjhYJjDOn83dhC0u4ZBs
         AYk2iSXaNzDmzIaq9FQ7GEgiIVseqIC2eL8oWQnldtz7b9MFCYkFdyKc++VLcg0qFO
         FiFmvLk4Iu2v3KVty5JNpy2O76CjLGGcWbEKCmB0=
Date:   Mon, 23 Dec 2019 18:01:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Olivier Moysan <olivier.moysan@st.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com, lars@metafoo.de,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
        fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: iio: adc: convert sd modulator to
 json-schema
Message-ID: <20191223180157.49b971f0@archlinux>
In-Reply-To: <20191218223032.GA8641@bogus>
References: <20191206100058.26767-1-olivier.moysan@st.com>
        <20191218223032.GA8641@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 16:30:32 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, 6 Dec 2019 11:00:58 +0100, Olivier Moysan wrote:
> > Convert the sigma delta modulator bindings
> > to DT schema format using json-schema.
> > 
> > Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> > ---
> > Changes since v1:
> > - add additionalProperties
> > - remove unit-address in example
> > ---
> >  .../iio/adc/sigma-delta-modulator.txt         | 13 -------
> >  .../iio/adc/sigma-delta-modulator.yaml        | 37 +++++++++++++++++++
> >  2 files changed, 37 insertions(+), 13 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan


