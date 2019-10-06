Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CF7C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80A12133F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570357679;
	bh=TxFhjrm56Pjm6MFAtGv+HR0edZ7F5tj7DSzzc+pDVPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=P++con0d+K3R6OU0Z5i4jrFB1Fs0HFHcKdQRTib1YpRxnIdh5fTU7JpHN81VjqFRc
	 V5jyeoHpz2NdZy9ULkXVDA+NbMNJ60wzK/Nrn410E8QJPWayVflS8cwZJl0xekfwHk
	 HeJR2b4Or+CYWoTOEkJBaEuO+JMWbMCPEI6gNSf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfJFK16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 06:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfJFK15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 06:27:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D152084B;
        Sun,  6 Oct 2019 10:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570357677;
        bh=TxFhjrm56Pjm6MFAtGv+HR0edZ7F5tj7DSzzc+pDVPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p5UxAnkVq5U+SIgvfQ0XBXBGLtp7FZbz09lj3vfWHDUMXK2V6oQiuYYoJG6jsyUj9
         HXE9I3sNN5VfygfYp5Bccnyv1aNak4JZrFI9IsKFABLABfEx+JoFIJmHDQ7YUjSifk
         49TZeCpdlESCCfpC3va1mM+Xz+gXlV+PCPczoi50=
Date:   Sun, 6 Oct 2019 11:27:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 7/7] dt-bindings: iio: adc: max1027: Document max12xx
 series compatibles
Message-ID: <20191006112751.775fc849@archlinux>
In-Reply-To: <20191003173401.16343-8-miquel.raynal@bootlin.com>
References: <20191003173401.16343-1-miquel.raynal@bootlin.com>
        <20191003173401.16343-8-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Oct 2019 19:34:01 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Update the bindings documentation with new Maxim ADCs compatibles.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Both DT patches look fine to me... 

If you happened to fancy doing the yaml conversion it would be
appreciated... :) 

If not we'll get to this one one day.

Anyhow, a few trivial bits in the earlier patches so v3 should be
good to go.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/max1027-adc.txt        | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt b/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
> index 7b23d68f655c..1b703a01d882 100644
> --- a/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
> @@ -1,7 +1,13 @@
> -* Maxim 1027/1029/1031 Analog to Digital Converter (ADC)
> +* Maxim 1027/1029/1031/1227/1229/1231 Analog to Digital Converter (ADC)
>  
>  Required properties:
> -  - compatible: Should be "maxim,max1027" or "maxim,max1029" or "maxim,max1031"
> +  - compatible: Should be one of:
> +    * "maxim,max1027"
> +    * "maxim,max1029"
> +    * "maxim,max1031"
> +    * "maxim,max1227"
> +    * "maxim,max1229"
> +    * "maxim,max1231"
>    - reg: SPI chip select number for the device
>  
>  Optional properties:

