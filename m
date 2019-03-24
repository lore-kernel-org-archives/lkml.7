Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1323C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EABD2147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553448044;
	bh=55E3cy3sPnkatyUh2RRZVRkdGyUQN/8AsxZk0oirgX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2n3AtgUo8reiNwJrodf4jgFugsEC7EB+jemvYv3Gv2bdXK5t907mODHO3+/4w2Huh
	 RLRB/zqHZRhL/pQZhWn8SA9m1Ol/pPiM9GoUvuSqcvJ4oc9GiBtbEu/WF1UTs8aRcK
	 49ehrxGCcwb8/Mv92SQFlF2WCwuAo6MR+fjOmJL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfCXRUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728945AbfCXRUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:20:42 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6631720989;
        Sun, 24 Mar 2019 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553448041;
        bh=55E3cy3sPnkatyUh2RRZVRkdGyUQN/8AsxZk0oirgX4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OVx5n/llgbwrdkC/RWkBGtlAvoig/knwJuwrTRNlDzvjAUGuqvIFYwRd2toZjbRKZ
         gmq9D/xsHY08dh2awDXHgV/keDgXH+6DSqgqWhVhl72vOmaMxqVr7YMhtASTDF5RlY
         YfIpdFTQDC8n9WBDMxsz65U36sn9keMA7LpaIgXs=
Date:   Sun, 24 Mar 2019 17:20:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dt-bindings: iio: light: add vcnl4000 devicetree
 bindings
Message-ID: <20190324172036.0208c470@archlinux>
In-Reply-To: <20190321154047.23236-4-angus@akkea.ca>
References: <20190321154047.23236-1-angus@akkea.ca>
        <20190321154047.23236-4-angus@akkea.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 08:40:45 -0700
"Angus Ainslie (Purism)" <angus@akkea.ca> wrote:

> Document the vishay VCNL4000 devicetree bindings.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Fairly straight forward, so I'll take this without explicitly waiting
for a dt ack.  Still plenty of time to add one if Rob or anyone else
does want to take a look.

Applied to the togreg branch of iio.git and pushed out as testing

Thanks,

Jonathan

> ---
>  .../bindings/iio/light/vcnl4000.txt           | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
> new file mode 100644
> index 000000000000..4a9d558a412a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
> @@ -0,0 +1,22 @@
> +VISHAY VCNL4000 -  Ambient Light and proximity sensor
> +
> +This driver supports the VCNL4000/10/20 and VCNL4200 chips
> +
> +Required properties:
> +
> +	-compatible: must be one of :
> +        vishay,vcnl4000
> +        vishay,vcnl4010
> +        vishay,vcnl4020
> +        vishay,vcnl4200
> +
> +	-reg: I2C address of the sensor, should be one from below based on the model:
> +        0x13
> +        0x51
> +
> +Example:
> +
> +light-sensor@51 {
> +	compatible = "vishay,vcnl4200";
> +	reg = <0x51>;
> +};

