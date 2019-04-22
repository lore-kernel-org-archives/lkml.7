Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695A2C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CE520874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfDVOrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:47:53 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:17400 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727386AbfDVOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:47:52 -0400
X-IronPort-AV: E=Sophos;i="5.60,382,1549926000"; 
   d="scan'208";a="379665763"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 16:47:49 +0200
Date:   Mon, 22 Apr 2019 16:47:49 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [PATCH v2 48/79] docs: driver-model: convert docs to ReST and
 rename to *.rst
In-Reply-To: <dbd6b1ffee1bc31c89d0816588f13a7f91bc9f66.1555938376.git.mchehab+samsung@kernel.org>
Message-ID: <alpine.DEB.2.21.1904221647060.2458@hadrien>
References: <cover.1555938375.git.mchehab+samsung@kernel.org> <dbd6b1ffee1bc31c89d0816588f13a7f91bc9f66.1555938376.git.mchehab+samsung@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/scripts/coccinelle/free/devm_free.cocci b/scripts/coccinelle/free/devm_free.cocci
> index b2a2cf8bf81f..e32236a979a8 100644
> --- a/scripts/coccinelle/free/devm_free.cocci
> +++ b/scripts/coccinelle/free/devm_free.cocci
> @@ -2,7 +2,7 @@
>  /// functions.  Values allocated using the devm_functions are freed when
>  /// the device is detached, and thus the use of the standard freeing
>  /// function would cause a double free.
> -/// See Documentation/driver-model/devres.txt for more information.
> +/// See Documentation/driver-model/devres.rst for more information.
>  ///
>  /// A difficulty of detecting this problem is that the standard freeing
>  /// function might be called from a different function than the one

Acked-by: Julia Lawall <julia.lawall@lip6.fr>



> --
> 2.20.1
>
>
