Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9C5C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE2321874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfH2QOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:14:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:56270 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbfH2QOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:14:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 09:14:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; 
   d="scan'208";a="171947177"
Received: from friedlmi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.54.26])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2019 09:14:24 -0700
Date:   Thu, 29 Aug 2019 19:14:17 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: tpm: document properties for cr50
Message-ID: <20190829161417.tzk4wewlupr4udgd@linux.intel.com>
References: <20190828082150.42194-1-swboyd@chromium.org>
 <20190828082150.42194-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828082150.42194-2-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 01:21:47AM -0700, Stephen Boyd wrote:
> From: Andrey Pronin <apronin@chromium.org>
> 
> Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> firmware.
> 
> Cc: Andrey Pronin <apronin@chromium.org>
> Cc: Duncan Laurie <dlaurie@chromium.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Andrey Pronin <apronin@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/security/tpm/google,cr50.txt     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
> 
> diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
> new file mode 100644
> index 000000000000..cd69c2efdd37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
> @@ -0,0 +1,19 @@
> +* H1 Secure Microcontroller with Cr50 Firmware on SPI Bus.
> +
> +H1 Secure Microcontroller running Cr50 firmware provides several
> +functions, including TPM-like functionality. It communicates over
> +SPI using the FIFO protocol described in the PTP Spec, section 6.
> +
> +Required properties:
> +- compatible: Should be "google,cr50".
> +- spi-max-frequency: Maximum SPI frequency.
> +
> +Example:
> +
> +&spi0 {
> +	tpm@0 {
> +		compatible = "google,cr50";
> +		reg = <0>;
> +		spi-max-frequency = <800000>;
> +	};
> +};
> -- 
> Sent by a computer through tubes
> 

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
