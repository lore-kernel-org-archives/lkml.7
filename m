Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A159DC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD8C2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfJFTBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 15:01:13 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:51959
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbfJFTBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 15:01:12 -0400
X-IronPort-AV: E=Sophos;i="5.67,265,1566856800"; 
   d="scan'208";a="321778515"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2019 21:01:09 +0200
Date:   Sun, 6 Oct 2019 21:01:09 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Jules Irenge <jbi.octave@gmail.com>
cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        olsonse@umich.edu, hsweeten@visionengravers.com, abbotti@mev.co.uk
Subject: Re: [Outreachy kernel] [PATCH] staging: comedi: Capitalize macro
 name to fix camelcase checkpatch warning
In-Reply-To: <20191006184827.12021-1-jbi.octave@gmail.com>
Message-ID: <alpine.DEB.2.21.1910062100530.2515@hadrien>
References: <20191006184827.12021-1-jbi.octave@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Oct 2019, Jules Irenge wrote:

> Capitalize RANGE_mA to fix camelcase check warning.
> Issue reported by checkpatch.pl

I guess mA means something, so it would be better to keep it?

julia

>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/staging/comedi/comedidev.h           | 2 +-
>  drivers/staging/comedi/drivers/adv_pci1724.c | 4 ++--
>  drivers/staging/comedi/drivers/dac02.c       | 2 +-
>  drivers/staging/comedi/range.c               | 6 +++---
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/staging/comedi/comedidev.h b/drivers/staging/comedi/comedidev.h
> index 54c091866777..2fc536db203c 100644
> --- a/drivers/staging/comedi/comedidev.h
> +++ b/drivers/staging/comedi/comedidev.h
> @@ -603,7 +603,7 @@ int comedi_check_chanlist(struct comedi_subdevice *s,
>
>  #define RANGE(a, b)		{(a) * 1e6, (b) * 1e6, 0}
>  #define RANGE_ext(a, b)		{(a) * 1e6, (b) * 1e6, RF_EXTERNAL}
> -#define RANGE_mA(a, b)		{(a) * 1e6, (b) * 1e6, UNIT_MA}
> +#define RANGE_MA(a, b)		{(a) * 1e6, (b) * 1e6, UNIT_MA}
>  #define RANGE_unitless(a, b)	{(a) * 1e6, (b) * 1e6, 0}
>  #define BIP_RANGE(a)		{-(a) * 1e6, (a) * 1e6, 0}
>  #define UNI_RANGE(a)		{0, (a) * 1e6, 0}
> diff --git a/drivers/staging/comedi/drivers/adv_pci1724.c b/drivers/staging/comedi/drivers/adv_pci1724.c
> index e8ab573c839f..f20d710c19d3 100644
> --- a/drivers/staging/comedi/drivers/adv_pci1724.c
> +++ b/drivers/staging/comedi/drivers/adv_pci1724.c
> @@ -64,8 +64,8 @@
>  static const struct comedi_lrange adv_pci1724_ao_ranges = {
>  	4, {
>  		BIP_RANGE(10),
> -		RANGE_mA(0, 20),
> -		RANGE_mA(4, 20),
> +		RANGE_MA(0, 20),
> +		RANGE_MA(4, 20),
>  		RANGE_unitless(0, 1)
>  	}
>  };
> diff --git a/drivers/staging/comedi/drivers/dac02.c b/drivers/staging/comedi/drivers/dac02.c
> index 5ef8114c2c85..4503cbdf673c 100644
> --- a/drivers/staging/comedi/drivers/dac02.c
> +++ b/drivers/staging/comedi/drivers/dac02.c
> @@ -54,7 +54,7 @@ static const struct comedi_lrange das02_ao_ranges = {
>  		UNI_RANGE(10),
>  		BIP_RANGE(5),
>  		BIP_RANGE(10),
> -		RANGE_mA(4, 20),
> +		RANGE_MA(4, 20),
>  		RANGE_ext(0, 1)
>  	}
>  };
> diff --git a/drivers/staging/comedi/range.c b/drivers/staging/comedi/range.c
> index 89d599877445..dacdd7b6f1a0 100644
> --- a/drivers/staging/comedi/range.c
> +++ b/drivers/staging/comedi/range.c
> @@ -23,11 +23,11 @@ const struct comedi_lrange range_unipolar5 = { 1, {UNI_RANGE(5)} };
>  EXPORT_SYMBOL_GPL(range_unipolar5);
>  const struct comedi_lrange range_unipolar2_5 = { 1, {UNI_RANGE(2.5)} };
>  EXPORT_SYMBOL_GPL(range_unipolar2_5);
> -const struct comedi_lrange range_0_20mA = { 1, {RANGE_mA(0, 20)} };
> +const struct comedi_lrange range_0_20mA = { 1, {RANGE_MA(0, 20)} };
>  EXPORT_SYMBOL_GPL(range_0_20mA);
> -const struct comedi_lrange range_4_20mA = { 1, {RANGE_mA(4, 20)} };
> +const struct comedi_lrange range_4_20mA = { 1, {RANGE_MA(4, 20)} };
>  EXPORT_SYMBOL_GPL(range_4_20mA);
> -const struct comedi_lrange range_0_32mA = { 1, {RANGE_mA(0, 32)} };
> +const struct comedi_lrange range_0_32mA = { 1, {RANGE_MA(0, 32)} };
>  EXPORT_SYMBOL_GPL(range_0_32mA);
>  const struct comedi_lrange range_unknown = { 1, {{0, 1000000, UNIT_none} } };
>  EXPORT_SYMBOL_GPL(range_unknown);
> --
> 2.21.0
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191006184827.12021-1-jbi.octave%40gmail.com.
>
