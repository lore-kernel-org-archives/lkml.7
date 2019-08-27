Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7B0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4DE217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfH0Ns2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:48:28 -0400
Received: from ms.lwn.net ([45.79.88.28]:37120 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfH0Ns1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:48:27 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 70A72537;
        Tue, 27 Aug 2019 13:48:26 +0000 (UTC)
Date:   Tue, 27 Aug 2019 07:48:25 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Gerald BAEZA <gerald.baeza@st.com>
Cc:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: add link to stm32mp157 docs
Message-ID: <20190827074825.64a28e88@lwn.net>
In-Reply-To: <1566908347-92201-1-git-send-email-gerald.baeza@st.com>
References: <1566908347-92201-1-git-send-email-gerald.baeza@st.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 12:19:32 +0000
Gerald BAEZA <gerald.baeza@st.com> wrote:

> Link to the online stm32mp157 documentation added
> in the overview.
> 
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> ---
>  Documentation/arm/stm32/stm32mp157-overview.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/arm/stm32/stm32mp157-overview.rst b/Documentation/arm/stm32/stm32mp157-overview.rst
> index f62fdc8..8d5a476 100644
> --- a/Documentation/arm/stm32/stm32mp157-overview.rst
> +++ b/Documentation/arm/stm32/stm32mp157-overview.rst
> @@ -14,6 +14,12 @@ It features:
>  - Standard connectivity, widely inherited from the STM32 MCU family
>  - Comprehensive security support
>  
> +Resources
> +---------
> +
> +Datasheet and reference manual are publicly available on ST website:
> +.. _STM32MP157: https://www.st.com/en/microcontrollers-microprocessors/stm32mp157.html
> +

Adding the URL is a fine idea.  But you don't need the extra syntax to
create a link if you're not going to actually make a link out of it.  So
I'd take the ".. _STM32MP157:" part out and life will be good.

Thanks,

jon
