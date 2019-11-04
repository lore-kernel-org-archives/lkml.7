Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C386FC47E49
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90626218BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572853544;
	bh=WTVqOEcC1dHVSVyC4yYVjyjBZVnNFJMwi8QDFxKH53I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hXvtK58cONBceimVNJeI5Xz4jVY6AlCmiDUH0kIxMa/7c52s7qgdNoXRfrczY3LDw
	 +CPWjv49ytifRKafiZ6XMf1pnPL4OkuoAMax2t2ZRpIZiSpTbKn9Ob6d6CLWaSus6A
	 FenjENF1494PgJTu1+8DGk30Orlq6CFTgdBw9Dhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfKDHpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 02:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfKDHpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:45:43 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A251A2190F;
        Mon,  4 Nov 2019 07:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572853542;
        bh=WTVqOEcC1dHVSVyC4yYVjyjBZVnNFJMwi8QDFxKH53I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rg4OuNF1FndrApd6dvSlvD0vw4tU7S7IQYdV8o9YydcB85WqTlGWHhLwAeYgcZNYm
         /BjWAx0vkKLnr0TCno438srfISO6vL94qEGMtFaJpW4PWD6lfnqwj7LJF8sUTr5ND5
         EyRQ5XdBxMAxhuQXu/Mh/jeByrYoqF36VgRNJjnw=
Date:   Mon, 4 Nov 2019 15:45:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/11] MAINTAINERS: Add an entry for Kontron
 Electronics ARM board support
Message-ID: <20191104074514.GU24620@dragon>
References: <20191031142112.12431-1-frieder.schrempf@kontron.de>
 <20191031142112.12431-12-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031142112.12431-12-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 02:24:34PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Kontron Electronics GmbH produces several ARM boards, that are
> planned to be upstreamed eventually. For now we have some
> i.MX6UL/ULL based SoMs and boards, that are already available
> in the kernel.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

We usually do not need MAINTAINERS entry for individual DTS files.

Shawn

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 296de2b51c83..a461d31ee98d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9103,6 +9103,12 @@ F:	include/linux/kmod.h
>  F:	lib/test_kmod.c
>  F:	tools/testing/selftests/kmod/
>  
> +KONTRON ELECTRONICS ARM BOARDS SUPPORT
> +M:	Frieder Schrempf <frieder.schrempf@kontron.de>
> +S:	Maintained
> +F:	arch/arm/boot/dts/imx6ul-kontron-*
> +F:	arch/arm/boot/dts/imx6ull-kontron-*
> +
>  KPROBES
>  M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
>  M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> -- 
> 2.17.1
