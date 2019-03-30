Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D90C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54B1218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553964142;
	bh=nPy2ifQ54x7DxDr4UyLBeesbBInz8JwCwrDLuvli8PU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oh8920MCNoR9q9DUaXJj7z/iIRUmLNqZpeIVgop/fiUmzmq4oyHSt9FFJFW4by71q
	 6BWYEoc211VLX2k0M6U+bZ5b3rHY937Fop4ukiyVCfPas2IrfkAN7+7CUDgaXpOg3e
	 2p3wLzW6JiUVFb5WtatkhZuLsvoUiQKaMNFyatT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfC3QmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbfC3QmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:42:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19C81218A3;
        Sat, 30 Mar 2019 16:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553964140;
        bh=nPy2ifQ54x7DxDr4UyLBeesbBInz8JwCwrDLuvli8PU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T6NcWWrQ1Ld2sitoib3ajAabRFERyNnd0lAg0WSaoBxyBrW+D8h6/MnCrYUPMJZ9/
         kmIsy/N1a81lwl33JGcID5WuDuP1aVPYgQtCMhYGOqw9CWIYt+MpVYeah2bSd5/NRY
         6YRxERpdnsMapB1RfOvyk9nbRNPbE8Dvwoh4/hnw=
Date:   Sat, 30 Mar 2019 16:42:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: iio/temperature: Add thermocouple
 types (and doc)
Message-ID: <20190330164214.3189ca54@archlinux>
In-Reply-To: <20190326111842.12399-1-patrick.havelange@essensium.com>
References: <20190326111842.12399-1-patrick.havelange@essensium.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 12:18:40 +0100
Patrick Havelange <patrick.havelange@essensium.com> wrote:

> This patch introduces common thermocouple types used by various
> temperature sensors. Also a brief documentation explaining this
> "thermocouple-type" property.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
You have addressed all of Rob's feedback I think, so I'll not pester
Rob for any follow up (always welcome of course if he wants to give it!)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes v7
>  - Merge header and doc in same patch
>  - Doc:add it's a single cell entry
>  - Doc:removed non complete example
> 
> Changes v6
>  - Add this file
> ---
>  .../iio/temperature/temperature-bindings.txt     |  7 +++++++
>  .../dt-bindings/iio/temperature/thermocouple.h   | 16 ++++++++++++++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
>  create mode 100644 include/dt-bindings/iio/temperature/thermocouple.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt b/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
> new file mode 100644
> index 000000000000..8f339cab74ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
> @@ -0,0 +1,7 @@
> +If the temperature sensor device can be configured to use some specific
> +thermocouple type, you can use the defined types provided in the file
> +"include/dt-bindings/iio/temperature/thermocouple.h".
> +
> +Property:
> +thermocouple-type:	A single cell representing the type of the thermocouple
> +			used by the device.
> diff --git a/include/dt-bindings/iio/temperature/thermocouple.h b/include/dt-bindings/iio/temperature/thermocouple.h
> new file mode 100644
> index 000000000000..ce037f5238ac
> --- /dev/null
> +++ b/include/dt-bindings/iio/temperature/thermocouple.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _DT_BINDINGS_TEMPERATURE_THERMOCOUPLE_H
> +#define _DT_BINDINGS_TEMPERATURE_THERMOCOUPLE_H
> +
> +
> +#define THERMOCOUPLE_TYPE_B	0x00
> +#define THERMOCOUPLE_TYPE_E	0x01
> +#define THERMOCOUPLE_TYPE_J	0x02
> +#define THERMOCOUPLE_TYPE_K	0x03
> +#define THERMOCOUPLE_TYPE_N	0x04
> +#define THERMOCOUPLE_TYPE_R	0x05
> +#define THERMOCOUPLE_TYPE_S	0x06
> +#define THERMOCOUPLE_TYPE_T	0x07
> +
> +#endif /* _DT_BINDINGS_TEMPERATURE_THERMOCOUPLE_H */

