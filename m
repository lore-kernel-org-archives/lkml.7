Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB86C4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065742086D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551553002;
	bh=7AKR1tv184X2mv/hZD9dIUvyb3t3mh6GtSAfMS1Ls3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BvhFdYJFrlBAMA5r5Msoi+5y5HTjDx0j3ZpYs5UagoHl6X4G2HB7hLH595ls0aKa6
	 c2QHees/LhsYt/suzqrGKJ1If7b+jvLif59yRWID+bDCUYuNtFZSnDGOWoAveU0JSR
	 sYbppBSyG+wPkdbThfggt63CyvRQZulp2oGfmbQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfCBS4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 13:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfCBS4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 13:56:40 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E767220830;
        Sat,  2 Mar 2019 18:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551552999;
        bh=7AKR1tv184X2mv/hZD9dIUvyb3t3mh6GtSAfMS1Ls3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JR6Nu5JW6V1+nVX8dqxs6MrV9nRCV3Zmg4K91yYifh0qz4vR+NKdCXTBF3P/rFRnK
         MnMTkJtIQE9ji1zinAqqBjGedui7JFedMG8tkdvC1AgVhg2igrpO2A8+bqJch/9sTL
         apyLL8kRfGX4RdOM7L9dFrwNzIpwI0GW0KZdKRKE=
Date:   Sat, 2 Mar 2019 18:56:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Yang <decatf@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: accel: kxcjk1013: Add device tree
 binding documentation
Message-ID: <20190302185633.022f35af@archlinux>
In-Reply-To: <20190228201811.7582-3-decatf@gmail.com>
References: <20190228201811.7582-1-decatf@gmail.com>
        <20190228201811.7582-3-decatf@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 15:18:10 -0500
Robert Yang <decatf@gmail.com> wrote:

> Document device tree bindings for Kionix KXCJK-1013 Accelerometer driver.
> 
> Signed-off-by: Robert Yang <decatf@gmail.com>
Hi Robert,

Thanks for this. One comment inline.

Jonathan

> ---
>  .../bindings/iio/accel/kionix,kxcjk1013.txt    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
> new file mode 100644
> index 000000000000..521c53799bc5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
> @@ -0,0 +1,18 @@
> +Kionix KXCJK-1013 Accelerometer device tree bindings
> +
> +Required properties:
> +
> +- compatible: Must be one of:
> +    "kionix,kxcjk1013"
> +    "kionix,kxcj91008"
> +    "kionix,kxtj21009"
> +    "kionix,kxtf9"
> +    "kionix,SMO8500"
This looks like an ACPI binding rather than a device name.  So
I'd drop this last one.

> + - reg: i2c slave address
> +
> +Example:
> +
> +kxtf9@f {
> +	compatible = "kionix,kxtf9";
> +	reg = <0x0F>;
> +};

