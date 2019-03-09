Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BC6C4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD69120815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552155310;
	bh=uQFDsEVA9D57jAhFepjb7Qd4OqqXeasfpOGAwTekmTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rudgwFt4Hr5g7MKOzwh5w6TXJsmnoZmE3Ykv8GxE7Se5hqria45bos4Lx6SCTSGSU
	 dccYphAGEtgzjJeehd03RdX3OtH2G3J5yLSHK/uDVSrbxg76RK1R4gh0eEaxfxN54+
	 0z2V1LLioh4mpqTXV6m7u1F3HHon/p5GS+89JPd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfCISPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfCISPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:15:08 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 849D5206DF;
        Sat,  9 Mar 2019 18:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552155308;
        bh=uQFDsEVA9D57jAhFepjb7Qd4OqqXeasfpOGAwTekmTE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=st9d5y0TX4vteeK+BX3KIye3TJGRUcTtbvks3LENvsCU/8p8uvhwtR9LkbO/Bkdjg
         tq0/MQJQ/6dnNuNN9qXUZXnRLAmet9imhefsGTxx4W6QaUUHZD3iMp0MqAiyLT3gPJ
         Sd646OR8nujZXK6eGRvusAf8ZGJORaOjPwQXNNLk=
Date:   Sat, 9 Mar 2019 18:15:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Yang <decatf@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: accel: kxcjk1013: Add device
 tree binding documentation
Message-ID: <20190309181502.0ba185fd@archlinux>
In-Reply-To: <20190304151912.11485-3-decatf@gmail.com>
References: <20190304151912.11485-1-decatf@gmail.com>
        <20190304151912.11485-3-decatf@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 10:19:11 -0500
Robert Yang <decatf@gmail.com> wrote:

> Document device tree bindings for Kionix KXCJK-1013 Accelerometer driver.
> 
> Signed-off-by: Robert Yang <decatf@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

thanks,

Jonathan

> ---
>  .../bindings/iio/accel/kionix,kxcjk1013.txt     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
> new file mode 100644
> index 000000000000..eb76a02e2a82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
> @@ -0,0 +1,17 @@
> +Kionix KXCJK-1013 Accelerometer device tree bindings
> +
> +Required properties:
> +
> +- compatible: Must be one of:
> +    "kionix,kxcjk1013"
> +    "kionix,kxcj91008"
> +    "kionix,kxtj21009"
> +    "kionix,kxtf9"
> + - reg: i2c slave address
> +
> +Example:
> +
> +kxtf9@f {
> +	compatible = "kionix,kxtf9";
> +	reg = <0x0F>;
> +};

