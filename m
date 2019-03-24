Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23E9C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9156A21741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553450822;
	bh=uiBXlOmwp39VH8o5OSFRICLedS+X7fpXWLyg3aKyuFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wwWctccdPruj6P4sYWtcfgis6/b6ccfQMbbC+j8xWlN/vW7cZrEWUrywna4YTPGXZ
	 MpjusyGMn2C623tRqEahbHhSfRKMVDrmdZSQtNjXY1KCBSKoG5Zi+04mQck4CyQY/Y
	 X0rV/Go1UNMisVqXeJUZ7hB2WsT9dUXUKbupCq2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfCXSHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfCXSHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:07:01 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29BA22147C;
        Sun, 24 Mar 2019 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553450820;
        bh=uiBXlOmwp39VH8o5OSFRICLedS+X7fpXWLyg3aKyuFU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Jy7D6luk0S311rkrq5YKAPdpoQ/cLo7CWjTDsPK2GZNsozD3YCVM5g9oPk7Rxv7T
         GWIqC5j6hUPKiOhaec+FN81P3/FcP9bmXze0aOuPSpxYha5nBquffnChz9pjiGA32r
         OEp0gEoPDbR1iXwirX02svg+XM51f1wWvgWB07C8=
Date:   Sun, 24 Mar 2019 18:06:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: Re: [PATCH 2/2] dt-bindings: iio: add Bosch BMG160 gyroscope sensor
Message-ID: <20190324180654.44289894@archlinux>
In-Reply-To: <1664da2e7a9cb687eece1f27501d275219bcc4ed.1552922054.git.hns@goldelico.com>
References: <cover.1552922054.git.hns@goldelico.com>
        <1664da2e7a9cb687eece1f27501d275219bcc4ed.1552922054.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 16:14:15 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Define bindings for "bosch,bmg160" and "bosch,bmi055_gyro".
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Simple binding so applied to the togreg branch of iio.git and pushed out as
testing. Still time for a devicetree ack (or to pull it ;) if anyone has
time to look.

Thanks,

Jonathan

> ---
>  .../bindings/iio/gyroscope/bmg160.txt         | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt b/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
> new file mode 100644
> index 000000000000..78e18a1e9c1d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
> @@ -0,0 +1,20 @@
> +* Bosch BMG160 triaxial rotation sensor (gyroscope)
> +
> +Required properties:
> +
> +  - compatible : should be "bosch,bmg160" or "bosch,bmi055_gyro"
> +  - reg : the I2C address of the sensor (0x69)
> +
> +Optional properties:
> +
> +  - interrupts : interrupt mapping for GPIO IRQ, it should by configured with
> +		flags IRQ_TYPE_EDGE_RISING
> +
> +Example:
> +
> +bmg160@69 {
> +	compatible = "bosch,bmg160";
> +	reg = <0x69>;
> +	interrupt-parent = <&gpio6>;
> +	interrupts = <18 (IRQ_TYPE_EDGE_RISING)>;
> +};

